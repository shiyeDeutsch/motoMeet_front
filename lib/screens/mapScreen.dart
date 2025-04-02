import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

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
  static const String _userLocationSourceId = 'user-location-source';
  static const String _userLocationLayerId = 'user-location-layer';
  
  // Marker for user location
  CircleAnnotationManager? _circleAnnotationManager;
  CircleAnnotation? _userLocationMarker;
  
  // Polyline for route path
  PolylineAnnotationManager? _polylineManager;
  PolylineAnnotation? _routePolyline;

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
      // Create annotation manager for adding markers and polylines
      _circleAnnotationManager = await _mapboxMap!.annotations.createCircleAnnotationManager();
      _polylineManager = await _mapboxMap!.annotations.createPolylineAnnotationManager();
      
      // Get user's current location
      final currentLocation = await LocationService.getCurrentLocation();
      if (currentLocation != null) {
        _centerOnLocation(currentLocation);
        
        // Add user location marker
        await _updateUserLocationMarker(
          currentLocation.latitude, 
          currentLocation.longitude
        );
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

  Future<void> _updateUserLocationMarker(double latitude, double longitude) async {
    if (_mapboxMap == null || _circleAnnotationManager == null) return;

    try {
      // Remove existing marker if any
      if (_userLocationMarker != null) {
        await _circleAnnotationManager!.delete(_userLocationMarker!);
      }
      
      // Create a blue circle for user location
      final options = CircleAnnotationOptions(
        geometry: Point.fromJson({
          "coordinates": [longitude, latitude]
        }),
        circleRadius: 8.0,
        circleColor: Colors.blue.value, // Use Color value instead of string
        circleStrokeWidth: 2.0,
        circleStrokeColor: Colors.white.value, // Use Color value instead of string
      );
      
      _userLocationMarker = await _circleAnnotationManager!.create(options);
    } catch (e) {
      print('Error updating user location marker: $e');
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
    
    // Update user location marker
    _updateUserLocationMarker(position.latitude, position.longitude);
    
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
    if (_mapboxMap == null || _polylineManager == null) return;
    
    try {
      // Get committed points from the route provider using the public getter
      final committedPoints = ref.read(routeCreationProvider.notifier).committedPoints;
      
      // Need at least 2 points to draw a line
      if (committedPoints.length < 2) return;
      
      // Remove existing route line if any
      if (_routePolyline != null) {
        await _polylineManager!.delete(_routePolyline!);
      }
      
      // Convert GeoPoints to map coordinates
      final List<List<double>> coordinates = committedPoints.map((point) => 
        [point.longitude!, point.latitude!]
      ).toList();
      
      // Create a polyline for the route
      final options = PolylineAnnotationOptions(
        geometry: LineString.fromJson({
          "coordinates": coordinates
        }),
        lineWidth: 4.0,
        lineColor: Colors.red.value,
      );
      
      _routePolyline = await _polylineManager!.create(options);
      print('Updated route path with ${committedPoints.length} points');
    } catch (e) {
      print('Error updating route path: $e');
    }
  }

  Future<void> _drawBaseRoute() async {
    if (_mapboxMap == null || widget.baseRoute == null || _polylineManager == null) return;
    
    final route = widget.baseRoute!;
    
    // Center on start point if available
    if (route.startPoint != null) {
      final startPoint = LatLng(
        route.startPoint!.latitude!,
        route.startPoint!.longitude!,
      );
      
      _centerOnLocation(startPoint);
    }
    
    // If we have start and end points, draw a simple line
    if (route.startPoint != null && route.endPoint != null) {
      try {
        final options = PolylineAnnotationOptions(
          geometry: LineString.fromJson({
            "coordinates": [
              [route.startPoint!.longitude!, route.startPoint!.latitude!],
              [route.endPoint!.longitude!, route.endPoint!.latitude!]
            ]
          }),
          lineWidth: 4.0,
          lineColor: Colors.blue.value,
          lineOpacity: 0.7,
        );
        
        await _polylineManager!.create(options);
        print('Drew base route from start to end point');
      } catch (e) {
        print('Error drawing base route: $e');
      }
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
