import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:get_it/get_it.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shimmer/shimmer.dart';
import '../models/route.dart' as route_model;
import '../models/enum.dart';
import '../providers/route_creation_provider.dart';
import '../routing/routes.dart';
import '../services/bottomSheetServices.dart';
import '../services/distanceFormatter.dart';
import '../services/locationService.dart';
import '../utilities/duration_formatter.dart';
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/dialogs/stopRoutedialog.dart';
import '../widgets/wayPointBottomSheet.dart';
// Import the widgets
import '../widgets/mapbox_widget.dart';
import '../widgets/map_controls_widget.dart';
import '../widgets/start_route_button.dart';
import '../widgets/active_route_details.dart';
import '../widgets/map_layers_bottom_sheet.dart';
import '../controllers/map_controller.dart';
import '../controllers/navigation_controller.dart';
import '../constants/app_constants.dart';

class MapMarkerScreen extends ConsumerStatefulWidget {
  final route_model.Route? baseRoute; // The route passed from RouteDetailsScreen that user might want to start
  const MapMarkerScreen({Key? key, this.baseRoute}) : super(key: key);

  @override
  ConsumerState<MapMarkerScreen> createState() => _MapMarkerScreenState();
}

class _MapMarkerScreenState extends ConsumerState<MapMarkerScreen>
    with TickerProviderStateMixin {
  MapboxMapControllerWrapper? _mapControllerWrapper;
  NavigationController? _navigationController;
  final LocationService _locationService = GetIt.I<LocationService>();
  String _currentStyle = MapboxConfig.STYLE_OUTDOORS;

  // Navigation state
  bool _isTrackingUser = true;
  StreamSubscription? _navigationEventSubscription;
  // For position updates from RouteCreationProvider
  Function(Position)? _positionUpdateCallback;

  // The route passed from RouteDetailsScreen that user might want to start
  route_model.Route? _existingRouteToStart; 

  @override
  void initState() {
    super.initState();
    // If we have a baseRoute, set it
    if (widget.baseRoute != null) {
      _existingRouteToStart = widget.baseRoute;
    }
    // Ensure location service is initialized
    _ensureLocationServiceRunning();
 
  }
  
  Future<void> _ensureLocationServiceRunning() async {
    if (!_locationService.isListening) {
      await _locationService.startListening();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Get RouteCreationProvider and register for position updates
    // We do this in didChangeDependencies to ensure ref is available
    final userRouteProvider = ref.read(routeCreationProvider.notifier);
    
    if (_positionUpdateCallback == null) {
      _positionUpdateCallback = (Position position) {
        // If we have a NavigationController, forward position updates to it
        _navigationController?.updatePosition(position);
      };
      
      // Add the callback to listen for position updates
      userRouteProvider.addPositionListener(_positionUpdateCallback!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the UserRoute from the userRouteProvider
    final currentUserRoute = ref.watch(routeCreationProvider);
    // Read the userRouteProvider to get the currentPosition and baseRoute
    final userRouteProvider = ref.read(routeCreationProvider.notifier);
    final currentPosition = userRouteProvider.currentPosition;
    final baseRoute = userRouteProvider.baseRoute;

    // Prepare the "committed" polyline from route points
    final committedPoints = userRouteProvider.committedPoints;

    return Scaffold(
      // Remove bottom navigation bar for this screen
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: null,
      body: Stack(
        children: [
          // Use the improved MapboxWidget
          MapboxWidget(
            committedPoints: committedPoints,
            userPos: currentPosition,
            // Display either the active baseRoute or the route to start
            baseRoute: baseRoute ?? _existingRouteToStart,
            onMapInitialized: _onMapInitialized,
            onMapClick: (point, coordinates) {
              // Deselect tracking when user interacts with the map
              setState(() {
                _isTrackingUser = false;
                
                // If navigation controller exists, update tracking state
                if (_navigationController != null) {
                  _navigationController!.toggleTracking(false);
                }
              });
            },
            styleString: _currentStyle,
          ),

          // Use the MapControlsWidget with back button only
          MapControlsWidget(
            onCenterLocationPressed: _centerOnUserLocation,
            onLayersPressed: _toggleMapLayers,
            onBackPressed: () => Navigator.of(context).pop(),
          ),

          // Show Start Route Button when no active route - either start a new route or the existing one
          if (currentUserRoute == null)
            StartRouteButton(
              onPressed: _existingRouteToStart != null
                ? () => _startExistingRoute(_existingRouteToStart!)
                : _onPressStartRoute,
              label: _existingRouteToStart != null ? 'Start This Route' : 'Start New Route',
            ),

          // Always show the ActiveRouteDetails when we have a route
          if (currentUserRoute != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ActiveRouteDetails(
                context: context,
                currentUserRoute: currentUserRoute,
                baseRoute: baseRoute,
                currentPosition: currentPosition,
                onStopPressed: () => _onStopRoutePressed(context),
              ),
            ),
        ],
      ),
    );
  }

  /// Called when the map is initialized
  void _onMapInitialized(MapboxMapControllerWrapper controller) {
    _mapControllerWrapper = controller;
    
    // Initialize navigation controller with the map controller
    _navigationController = NavigationController(_mapControllerWrapper!);
    
    // Listen for navigation events to handle special cases
    _navigationEventSubscription = _navigationController!.navigationEvents.listen((event) {
      switch (event) {
        case NavigationEvent.offRoute:
          // Alert if user is off route
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You appear to be off route')),
          );
          break;
        case NavigationEvent.arrivedAtDestination:
          // Alert when arrived at destination
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You have arrived at your destination!'),
              backgroundColor: Color(0xFF3E6C51),
              duration: Duration(seconds: 5),
            ),
          );
          break;
        default:
          break;
      }
    });
    
    // Center map on user's location once initialized
    _centerOnUserLocation();
    
    // Listen for when the map style is loaded
    controller.isInitialized.addListener(() {
      if (controller.isInitialized.value) {
        // The map is fully initialized
        _updateMapWithLatestData();
      }
    });
  }
  
  /// Update the map with the latest data from providers
  void _updateMapWithLatestData() {
    if (_mapControllerWrapper == null || !_mapControllerWrapper!.isMapInitialized) return;

    final userRouteProvider = ref.read(routeCreationProvider.notifier);
    final committedPoints = userRouteProvider.committedPoints;
    final currentPosition = userRouteProvider.currentPosition;
    
    // If we have a current position and we're tracking, center on it
    if (currentPosition != null && _isTrackingUser) {
      _mapControllerWrapper!.centerOnUserLocation(currentPosition);
    }
    
    // Start navigation when we have a route
    if (committedPoints.isNotEmpty && _navigationController != null && ref.read(routeCreationProvider) != null) {
      _navigationController!.startNavigation(route: committedPoints);
    }
  }

  Future<void> _centerOnUserLocation() async {
    final userRouteProvider = ref.read(routeCreationProvider.notifier);
    final currentPosition = userRouteProvider.currentPosition;
    
    if (currentPosition != null && _mapControllerWrapper != null) {
      await _mapControllerWrapper!.centerOnUserLocation(currentPosition);
    } else {
      try {
        // Get latest position from location service
        final position = await _locationService.getCurrentPosition();
        
        if (_mapControllerWrapper != null) {
          await _mapControllerWrapper!.centerOnUserLocation(position);
        }
      } catch (e) {
        debugPrint('Error centering on user location: $e');
      }
    }
    
    // Re-enable tracking
    setState(() {
      _isTrackingUser = true;
      
      // If navigation controller exists, update tracking state
      if (_navigationController != null) {
        _navigationController!.toggleTracking(true);
      }
    });
  }

  void _toggleMapLayers() {
    // Show a modal bottom sheet with map style options
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MapLayersBottomSheet(
        onMapStyleSelected: (styleString) {
          setState(() {
            _currentStyle = styleString;
          });
        },
      ),
    );
  }

  /// Start a new route
  Future<void> _onPressStartRoute() async {
    // Show the choose route type dialog
    final routeType = await showRouteTypeEnumDialog(context);
    if (routeType == null) return;

    final userRouteProvider = ref.read(routeCreationProvider.notifier);
    Position? userPosition;
    
    try {
      // Try to get current position from location service
      userPosition = await _locationService.getCurrentPosition();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: ${e.toString()}')),
      );
      return;
    }

    if (userPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not determine your location')),
      );
      return;
    }

    // Start a new route with the current position
    userRouteProvider.startNewRoute(
      routeType,
      route_model.GeoPoint(
        latitude: userPosition.latitude,
        longitude: userPosition.longitude,
      ),
    );

    // Ensure we're tracking the user
    setState(() {
      _isTrackingUser = true;
    });
    
    // Force center on user location
    await _centerOnUserLocation();
    
    // Now that we have a route, start navigation automatically
    _updateMapWithLatestData();
  }

  /// Stop the route
  Future<void> _onStopRoutePressed(BuildContext context) async {
    final shouldStop = await showStopDialog(context);
    if (shouldStop == true) {
      // Stop navigation if it's running
      if (_navigationController != null) {
        _navigationController!.stopNavigation();
      }
      
      // Stop the route in the service
      final userRouteProvider = ref.read(routeCreationProvider.notifier);
      await userRouteProvider.stopUserRoute();

      // Store references to route and userRoute before navigation
      final baseRoute = userRouteProvider.baseRoute;
      final userRoute = ref.read(routeCreationProvider);

      // Navigate to save screen
      Navigator.of(context).pushNamed(
        Routes.saveRoute,
        arguments: {'Route': baseRoute, 'UserRoute': userRoute},
      );
    }
  }

  /// Start an existing route that was passed from RouteDetailsScreen
  Future<void> _startExistingRoute(route_model.Route route) async {
    // Show the choose route type dialog
    final routeType = await showRouteTypeEnumDialog(context);
    if (routeType == null) return;

    final userRouteProvider = ref.read(routeCreationProvider.notifier);
    
    // Start the existing route with selected route type
    await userRouteProvider.startExistingRoute(route, routeType);
    
    // Ensure we're tracking the user
    setState(() {
      _isTrackingUser = true;
      _existingRouteToStart = null; // Clear the route to start since we've started it
    });
    
    // Force center on user location
    await _centerOnUserLocation();
    
    // Now that we have a route, start navigation automatically
    _updateMapWithLatestData();
  }

  @override
  void dispose() {
    _navigationEventSubscription?.cancel();
    
    // Remove position update callback when screen is disposed
    if (_positionUpdateCallback != null) {
      final userRouteProvider = ref.read(routeCreationProvider.notifier);
      userRouteProvider.removePositionListener(_positionUpdateCallback!);
      _positionUpdateCallback = null;
    }
    
    _navigationController?.dispose();
    super.dispose();
  }
}
