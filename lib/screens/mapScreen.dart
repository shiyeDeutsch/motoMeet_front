import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../constants/app_constants.dart';
import '../models/enum.dart';
import '../models/route.dart' as app_models;
import '../providers/route_creation_provider.dart';
import '../routing/routes.dart';
import '../services/bottomSheetServices.dart';
import '../services/locationService.dart';
import '../widgets/active_route_details.dart';
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/dialogs/stopRoutedialog.dart';
import '../widgets/map_controls_widget.dart';
import '../widgets/map_layers_bottom_sheet.dart';
import '../widgets/start_route_button.dart';

class MapScreen extends ConsumerStatefulWidget {
  final app_models.Route? baseRoute;

  const MapScreen({Key? key, this.baseRoute}) : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  // Mapbox controller
  MapboxMap? _mapboxMap;

  // Map style
  String _currentMapStyle = MapboxConfig.STYLE_OUTDOORS;

  // State tracking
  bool _isRecording = false;
  bool _isLoading = true;
  bool _isNavigationMode = false;
  geo.Position? _currentPosition;
  
  // Layer IDs for route drawing
  static const String _baseRouteSourceId = 'base-route-source';
  static const String _baseRouteLayerId = 'base-route-layer';
  static const String _userRouteSourceId = 'user-route-source';
  static const String _userRouteLayerId = 'user-route-layer';

  @override
  void dispose() {
    // Clean up resources
    _mapboxMap?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user route from the provider if recording
    final userRoute = ref.watch(routeCreationProvider);
    final routeNotifier = ref.watch(routeCreationProvider.notifier);
    
    // Get user position from route provider if available
    _currentPosition = routeNotifier.currentPosition ?? _currentPosition;

    return Scaffold(
      body: Stack(
        children: [
          // Mapbox map as the main content
          _buildMapView(),
          
          // Map controls (back button, center location, layers)
          MapControlsWidget(
            onBackPressed: () => _handleBackPress(context),
            onCenterLocationPressed: _centerOnCurrentLocation,
            onLayersPressed: () => _showMapLayersBottomSheet(context),
          ),
          
          // Conditionally show relevant UI based on recording state
          if (!_isRecording && !_isLoading)
            StartRouteButton(
              onPressed: () => _startNewRouteFlow(context),
              label: widget.baseRoute != null ? 'Start Following Route' : 'Start New Route',
            ),
          
          // Show active route details when recording
          if (_isRecording && userRoute != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ActiveRouteDetails(
                currentUserRoute: userRoute,
                baseRoute: widget.baseRoute,
                currentPosition: _currentPosition,
                onStopPressed: _stopRouteTracking,
                context: context,
              ),
            ),
            
          // Loading indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: MapWidget(
        key: const ValueKey("mapWidget"),
        styleUri: _currentMapStyle,
        onMapCreated: _onMapCreated,
        cameraOptions: CameraOptions(
          center: Point.fromJson({
            "coordinates": [0.0, 0.0]
          }),
          zoom: MapConfig.DEFAULT_ZOOM,
          bearing: 0.0,
          pitch: MapConfig.DEFAULT_TILT,
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    
    try {
      // Get user's current location
      final currentLocation = await LocationService.getCurrentLocation();
      if (currentLocation != null) {
        _centerOnLocation(currentLocation);
      }
      
      // Draw base route if available
      if (widget.baseRoute != null) {
        _drawBaseRoute();
      }
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing map: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _centerOnLocation(LatLng location) async {
    if (_mapboxMap == null) return;
    
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({
          "coordinates": [location.longitude, location.latitude]
        }),
        zoom: MapConfig.DEFAULT_ZOOM,
        pitch: _isNavigationMode ? MapConfig.NAVIGATION_TILT : MapConfig.DEFAULT_TILT,
      ),
      MapAnimationOptions(duration: 500),
    );
  }

  Future<void> _centerOnCurrentLocation() async {
    try {
      final currentLocation = await LocationService.getCurrentLocation();
      if (currentLocation != null) {
        _centerOnLocation(currentLocation);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not get current location: $e')),
      );
    }
  }

  Future<void> _startNewRouteFlow(BuildContext context) async {
    // Show route type selection dialog
    final selectedRouteType = await showRouteTypeEnumDialog(context);
    
    if (selectedRouteType == null) return;
    
    try {
      setState(() {
        _isLoading = true;
      });
      
      // Get current location for route start point
      final currentLocation = await LocationService.getCurrentLocation();
      if (currentLocation == null) {
        throw Exception('Could not get current location');
      }

      final startPoint = app_models.GeoPoint(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );
      
      // Start a new route or use the base route
      if (widget.baseRoute != null) {
        // Start an existing route
        await ref.read(routeCreationProvider.notifier).startExistingRoute(widget.baseRoute!);
      } else {
        // Start a brand new route
        await ref.read(routeCreationProvider.notifier).startNewRoute(selectedRouteType, startPoint);
      }
      
      // Set up navigation mode
      setState(() {
        _isRecording = true;
        _isLoading = false;
        _isNavigationMode = true;
      });
      
      // Apply navigation camera settings
      await _mapboxMap?.flyTo(
        CameraOptions(
          center: Point.fromJson({
            "coordinates": [currentLocation.longitude, currentLocation.latitude]
          }),
          zoom: MapConfig.DEFAULT_ZOOM,
          pitch: MapConfig.NAVIGATION_TILT,
        ),
        MapAnimationOptions(duration: 500),
      );
      
      // Set up listener for location updates to update camera and route
      LocationService.locationUpdates.listen(_onLocationUpdate);
      
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting route: $e')),
      );
    }
  }

  void _onLocationUpdate(geo.Position position) {
    if (!mounted || !_isRecording) return;
    
    setState(() {
      _currentPosition = position;
    });
    
    // Only follow user location if in navigation mode
    if (_isNavigationMode) {
      _followUserLocation(position);
    }
    
    // Update user route line on map
    _updateUserRoutePath();
  }

  Future<void> _followUserLocation(geo.Position position) async {
    if (_mapboxMap == null) return;
    
    // Adjust zoom level based on speed
    double zoomLevel = MapConfig.DEFAULT_ZOOM;
    
    // Adjust zoom level based on speed
    if (position.speed > SpeedThresholds.FAST_DRIVING) {
      zoomLevel = 13.0;
    } else if (position.speed > SpeedThresholds.MEDIUM_DRIVING) {
      zoomLevel = 14.0;
    } else if (position.speed > SpeedThresholds.SLOW_DRIVING) {
      zoomLevel = 15.0;
    } else if (position.speed > SpeedThresholds.BIKING) {
      zoomLevel = 16.0;
    } else if (position.speed > SpeedThresholds.WALKING) {
      zoomLevel = 17.0;
    } else {
      zoomLevel = 18.0;
    }
    
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({
          "coordinates": [position.longitude, position.latitude]
        }),
        zoom: zoomLevel,
        pitch: MapConfig.NAVIGATION_TILT,
        bearing: position.heading, // Orient map in direction of travel
      ),
      MapAnimationOptions(duration: 300),
    );
  }

  Future<void> _updateUserRoutePath() async {
    if (_mapboxMap == null) return;
    
    // In a real implementation, this would draw the user's route on the map
    // For now, we'll just update the UI by storing location in provider
    // The route drawing API requires a detailed understanding of the mapbox API
  }

  Future<void> _drawBaseRoute() async {
    if (_mapboxMap == null || widget.baseRoute == null) return;
    
    // Get route points from the base route
    final route = widget.baseRoute!;
    
    // In a real implementation, this would draw the base route on the map
    // For now, we'll just position the camera on the start point
    if (route.startPoint != null) {
      final startPoint = LatLng(
        route.startPoint!.latitude!,
        route.startPoint!.longitude!,
      );
      
      _centerOnLocation(startPoint);
    }
  }

  void _showMapLayersBottomSheet(BuildContext context) {
    BottomSheetService.showSmallBottomSheet(
      context: context,
      content: MapLayersBottomSheet(
        onMapStyleSelected: (style) {
          setState(() {
            _currentMapStyle = style;
          });
          _mapboxMap?.loadStyleURI(style);
        },
      ),
    );
  }

  Future<void> _stopRouteTracking() async {
    // Confirm with user
    final shouldStop = await showStopDialog(context);
    
    if (shouldStop != true) return;
    
    // Stop recording
    await ref.read(routeCreationProvider.notifier).stopUserRoute();
    
    final userRoute = ref.read(routeCreationProvider);
    final baseRoute = ref.read(routeCreationProvider.notifier).baseRoute;
    
    // Navigate to save route screen
    if (userRoute != null) {
      Navigator.of(context).pushReplacementNamed(
        Routes.saveRoute,
        arguments: {
          'Route': baseRoute,
          'UserRoute': userRoute,
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleBackPress(BuildContext context) {
    if (_isRecording) {
      _stopRouteTracking();
    } else {
      Navigator.of(context).pop();
    }
  }
}
