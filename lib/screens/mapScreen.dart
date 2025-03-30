import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart' as latlng2;
import 'package:mapbox_gl/mapbox_gl.dart';

import '../constants/app_constants.dart';
import '../models/enum.dart';
import '../models/route.dart' as app_models;
import '../providers/route_creation_provider.dart';
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
  MapboxMapController? _mapController;
  String _selectedMapStyle = MapboxConfig.STYLE_OUTDOORS;
  
  // Location service
  late LocationService _locationService;
  Position? _currentPosition;
  
  // Route tracking
  bool _isInNavigationMode = false;
  StreamSubscription<Position>? _positionSubscription;
  
  // Mapbox elements
  Symbol? _userLocationSymbol;
  Line? _routeLine;
  
  @override
  void initState() {
    super.initState();
    _locationService = GetIt.I<LocationService>();
    
    // Start location updates
    _initializeLocationService();
  }
  
  Future<void> _initializeLocationService() async {
    // Ensure location service is started
    if (!_locationService.isListening) {
      await _locationService.startListening();
    }
    
    // Configure for regular updates
    _locationService.configure(
      accuracy: LocationAccuracy.high,
      updateIntervalMs: 3000, // 3 seconds
    );
    
    // Get initial position
    try {
      final position = await _locationService.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
      
      if (_mapController != null && position != null) {
        _animateToPosition(position);
      }
    } catch (e) {
      // Handle location error
      print('Error getting location: $e');
    }
  }
  
  void _animateToPosition(Position position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: _isInNavigationMode ? 17.0 : MapConfig.DEFAULT_ZOOM,
          tilt: _isInNavigationMode ? MapConfig.NAVIGATION_TILT : MapConfig.DEFAULT_TILT,
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _positionSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Watch the route creation state
    final userRoute = ref.watch(routeCreationProvider);
    
    return Scaffold(
      body: Stack(
        children: [
          // Mapbox map
          _buildMapView(),
          
          // Map controls overlay
          MapControlsWidget(
            onCenterLocationPressed: _centerOnCurrentLocation,
            onLayersPressed: _showMapLayersBottomSheet,
            onBackPressed: () => Navigator.of(context).pop(),
          ),
          
          // Only show the Start Route button if no route is active
          if (userRoute == null)
            StartRouteButton(
              onPressed: _handleStartRoutePressed,
            ),
          
          // Show route details when a route is active
          if (userRoute != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ActiveRouteDetails(
                currentUserRoute: userRoute,
                baseRoute: widget.baseRoute,
                currentPosition: _currentPosition,
                onStopPressed: _handleStopRoutePressed,
                context: context,
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildMapView() {
    return MapboxMap(
      accessToken: MapboxConfig.ACCESS_TOKEN,
      styleString: _selectedMapStyle,
      initialCameraPosition: CameraPosition(
        target: _currentPosition != null 
          ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
          : const LatLng(0, 0), // Default position if location not available yet
        zoom: MapConfig.DEFAULT_ZOOM,
      ),
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      compassEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      onUserLocationUpdated: (userLocation) {
        _onUserLocationUpdated(userLocation);
      },
    );
  }
  
  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    
    // If we already have position, center map on it
    if (_currentPosition != null) {
      _animateToPosition(_currentPosition!);
    }
    
    // If we have a base route, display it on the map
    if (widget.baseRoute != null) {
      _displayBaseRoute(widget.baseRoute!);
    }
    
    // Setup route updates listener if we're actively tracking
    final activeRoute = ref.read(routeCreationProvider);
    if (activeRoute != null) {
      _setupRouteDisplayUpdates();
    }
  }
  
  void _onUserLocationUpdated(UserLocation userLocation) {
    // Store the latest position
    setState(() {
      _currentPosition = Position(
        latitude: userLocation.position.latitude,
        longitude: userLocation.position.longitude,
        timestamp: DateTime.now(),
        accuracy: 0.0, // Default value since we can't get actual accuracy
        altitude: 0.0,
        heading: 0.0, // Default value since we can't get actual heading
        speed: 0.0, // Default value since we can't get actual speed
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
    });
    
    // Update user location marker if in navigation mode
    if (_isInNavigationMode) {
      _updateUserLocationMarker();
    }
  }
  
  Future<void> _updateUserLocationMarker() async {
    if (_mapController == null || _currentPosition == null) return;
    
    // Add or update symbol showing user location
    if (_userLocationSymbol == null) {
      _userLocationSymbol = await _mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          iconImage: 'marker-15', // Use built-in Mapbox marker
          iconSize: 1.5,
          iconColor: '#3E6C51',
        ),
      );
    } else {
      await _mapController!.updateSymbol(
        _userLocationSymbol!,
        SymbolOptions(
          geometry: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }
  }
  
  void _displayBaseRoute(app_models.Route route) {
    // TODO: Extract route points from the route and display on the map
    // This would require the route to have its routePoints loaded
  }
  
  void _setupRouteDisplayUpdates() {
    // Listen to position updates from the route creation provider
    final routeCreationNotifier = ref.read(routeCreationProvider.notifier);
    
    _positionSubscription?.cancel();
    _positionSubscription = routeCreationNotifier.positionStream.listen((_) {
      // Update the route line on the map whenever there's a new point
      _updateRouteLine();
    });
    
    // Initial draw of route line
    _updateRouteLine();
  }
  
  Future<void> _updateRouteLine() async {
    if (_mapController == null) return;
    
    // Get all the points from the route creation provider
    final routeCreationNotifier = ref.read(routeCreationProvider.notifier);
    final points = routeCreationNotifier.committedPoints;
    
    if (points.isEmpty) return;
    
    // Convert GeoPoints to LatLng for Mapbox
    final coordinates = points.map((point) =>
      LatLng(point.latitude!, point.longitude!)
    ).toList();
    
    // Add or update the route line
    if (_routeLine == null) {
      _routeLine = await _mapController!.addLine(
        LineOptions(
          geometry: coordinates,
          lineColor: MapConfig.TRAVELED_PATH_COLOR,
          lineWidth: MapConfig.TRAVELED_PATH_WIDTH,
          lineOpacity: MapConfig.TRAVELED_PATH_OPACITY,
        ),
      );
    } else {
      await _mapController!.updateLine(
        _routeLine!,
        LineOptions(
          geometry: coordinates,
        ),
      );
    }
  }
  
  void _centerOnCurrentLocation() {
    if (_mapController != null && _currentPosition != null) {
      _animateToPosition(_currentPosition!);
    }
  }
  
  Future<void> _showMapLayersBottomSheet() async {
    final selectedStyle = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => MapLayersBottomSheet(
        currentStyle: _selectedMapStyle,
      ),
    );
    
    if (selectedStyle != null && selectedStyle != _selectedMapStyle) {
      // Store the new style preference
      setState(() {
        _selectedMapStyle = selectedStyle;
      });
      
      // For style changes, we need to recreate the map
      // This is the most compatible way across different mapbox_gl versions
      setState(() {});
    }
  }
  
  Future<void> _handleStartRoutePressed() async {
    // Show dialog to choose route type
    final routeType = await showRouteTypeEnumDialog(context);
    
    if (routeType != null) {
      // Start tracking a new route
      final routeCreationNotifier = ref.read(routeCreationProvider.notifier);
      
      if (_currentPosition != null) {
        final startPoint = app_models.GeoPoint(
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
          altitude: _currentPosition!.altitude,
        );
        
        // Using the existing route if provided or creating a new one
        if (widget.baseRoute != null) {
          await routeCreationNotifier.startExistingRoute(widget.baseRoute!, routeType);
        } else {
          await routeCreationNotifier.startNewRoute(routeType, startPoint);
        }
        
        // Setup route display updates
        _setupRouteDisplayUpdates();
        
        // Enter navigation mode
        setState(() {
          _isInNavigationMode = true;
        });
        
        // Center on current location with navigation mode camera settings
        _centerOnCurrentLocation();
      }
    }
  }
  
  Future<void> _handleStopRoutePressed() async {
    // Show confirmation dialog
    final shouldStop = await showStopDialog(context);
    
    if (shouldStop == true) {
      // Stop the route
      final routeCreationNotifier = ref.read(routeCreationProvider.notifier);
      await routeCreationNotifier.stopUserRoute();
      
      // Exit navigation mode
      setState(() {
        _isInNavigationMode = false;
      });
      
      // Cancel updates subscription
      _positionSubscription?.cancel();
      _positionSubscription = null;
      
      // Navigate to the save route screen
      Navigator.of(context).pushNamed('/routes/save');
    }
  }
}

// Create stub for MapLayersBottomSheet if it doesn't exist
class MapLayersBottomSheet extends StatelessWidget {
  final String currentStyle;
  
  const MapLayersBottomSheet({
    Key? key,
    required this.currentStyle,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select Map Style', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildStyleOption(context, 'Outdoors', MapboxConfig.STYLE_OUTDOORS),
          _buildStyleOption(context, 'Satellite', MapboxConfig.STYLE_SATELLITE),
          _buildStyleOption(context, 'Streets', MapboxConfig.STYLE_STANDARD),
          _buildStyleOption(context, 'Navigation', MapboxConfig.STYLE_NAVIGATION),
        ],
      ),
    );
  }
  
  Widget _buildStyleOption(BuildContext context, String name, String styleUrl) {
    final isSelected = currentStyle == styleUrl;
    
    return ListTile(
      title: Text(name),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        Navigator.of(context).pop(styleUrl);
      },
    );
  }
}
