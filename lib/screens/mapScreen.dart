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
  bool _isLoading = true;
  bool _isNavigationMode = false;
  bool _isAutoFollowing = true; // Track if map is auto-following user
  double _userSetZoomLevel = MapConfig.DEFAULT_ZOOM; // Track user-set zoom level
  bool _userHasManuallyZoomed = false; // Track if user has manually zoomed
  
  // Annotation managers
  CircleAnnotationManager? _circleAnnotationManager;
  CircleAnnotation? _userLocationMarker;
  PolylineAnnotationManager? _polylineManager;
  PolylineAnnotation? _routePolyline;

  // Last processed position to avoid duplicate updates
  geo.Position? _lastProcessedPosition;

  @override
  void dispose() {
    _mapboxMap?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user route and route notifier
    final userRoute = ref.watch(routeCreationProvider);
    final routeNotifier = ref.watch(routeCreationProvider.notifier);
    final currentPosition = routeNotifier.currentPosition;
    
    // Only update map UI if position changed and we're recording
    if (currentPosition != null && userRoute != null) {
      final bool positionChanged = _lastProcessedPosition == null || 
          _lastProcessedPosition!.latitude != currentPosition.latitude ||
          _lastProcessedPosition!.longitude != currentPosition.longitude;
          
      if (positionChanged) {
        _lastProcessedPosition = currentPosition;
        
        // Use post-frame callback to ensure the map is ready
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateUserLocationMarker(currentPosition.latitude, currentPosition.longitude);
          
          if (_isNavigationMode && _isAutoFollowing) {
            _followUserLocation(currentPosition);
          }
          
          _updateUserRoutePath();
        });
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          _buildMapView(),
          
          MapControlsWidget(
            onBackPressed: () => _handleBackPress(context),
            onCenterLocationPressed: _centerOnCurrentLocation,
            onLayersPressed: () => _showMapLayersBottomSheet(context),
          ),
          
          if (userRoute == null && !_isLoading)
            StartRouteButton(
              onPressed: () => _startNewRouteFlow(context),
              label: widget.baseRoute != null ? 'Start Following Route' : 'Start New Route',
            ),
          
          if (userRoute != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ActiveRouteDetails(
                currentUserRoute: userRoute,
                baseRoute: widget.baseRoute,
                currentPosition: currentPosition,
                onStopPressed: _stopRouteTracking,
                context: context,
              ),
            ),
            
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
          center: Point.fromJson({"coordinates": [0.0, 0.0]}),
          zoom: MapConfig.DEFAULT_ZOOM,
          bearing: 0.0,
          pitch: MapConfig.DEFAULT_TILT,
        ),
        onScrollListener: (_) => _onUserMapInteraction(),
        onZoomListener: (_) => _updateUserZoomLevel(),
      ),
    );
  }

  void _onUserMapInteraction() {
    // Disable auto-following when user manually interacts with the map
    if (_isNavigationMode && _isAutoFollowing) {
      setState(() {
        _isAutoFollowing = false;
      });
    }
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    
    try {
      _circleAnnotationManager = await _mapboxMap!.annotations.createCircleAnnotationManager();
      _polylineManager = await _mapboxMap!.annotations.createPolylineAnnotationManager();
      
      // Initialize default zoom level
      _userSetZoomLevel = MapConfig.DEFAULT_ZOOM;
      
      final currentLocation = await LocationService.getCurrentLocation();
      if (currentLocation != null) {
        // Get position for speed
        final position = await geo.Geolocator.getCurrentPosition();
        _centerOnLocation(currentLocation, speed: position.speed);
        await _updateUserLocationMarker(
          currentLocation.latitude, 
          currentLocation.longitude
        );
      }
      
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
      if (_userLocationMarker != null) {
        await _circleAnnotationManager!.delete(_userLocationMarker!);
      }
      
      final options = CircleAnnotationOptions(
        geometry: Point.fromJson({"coordinates": [longitude, latitude]}),
        circleRadius: 5.0,
        circleColor: Colors.blue.toARGB32(),
        circleStrokeWidth: 2.0,
        circleStrokeColor: Colors.white.toARGB32(),
      );
      
      _userLocationMarker = await _circleAnnotationManager!.create(options);
    } catch (e) {
      print('Error updating user location marker: $e');
    }
  }

  Future<void> _centerOnLocation(LatLng location, {double? speed}) async {
    if (_mapboxMap == null) return;
    
    // Use dynamic zoom based on speed if available and not manually zoomed
    double zoomLevel;
    if (speed != null && !_userHasManuallyZoomed && _isAutoFollowing) {
      zoomLevel = _getZoomLevelBasedOnSpeed(speed);
    } else {
      zoomLevel = _userSetZoomLevel;
    }
    
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({"coordinates": [location.longitude, location.latitude]}),
        zoom: zoomLevel,
        pitch: _isNavigationMode ? MapConfig.NAVIGATION_TILT : MapConfig.DEFAULT_TILT,
      ),
      MapAnimationOptions(duration: 500),
    );
  }

  Future<void> _centerOnCurrentLocation() async {
    try {
      final currentPosition = ref.read(routeCreationProvider.notifier).currentPosition;
      if (currentPosition != null) {
        // Use the position from the provider if available (when tracking a route)
        final location = LatLng(currentPosition.latitude, currentPosition.longitude);
        
        // Reset to auto-follow mode and determine zoom based on speed
        setState(() {
          _isAutoFollowing = true;
          _userHasManuallyZoomed = false;
        });
        
        // Center with dynamic zoom level
        await _mapboxMap!.flyTo(
          CameraOptions(
            center: Point.fromJson({"coordinates": [location.longitude, location.latitude]}),
            zoom: _getZoomLevelBasedOnSpeed(currentPosition.speed),
            pitch: _isNavigationMode ? MapConfig.NAVIGATION_TILT : MapConfig.DEFAULT_TILT,
          ),
          MapAnimationOptions(duration: 500),
        );
      } else {
        // Otherwise get the current location and use Geolocator for speed
        final currentLocation = await LocationService.getCurrentLocation();
        if (currentLocation != null) {
          final position = await geo.Geolocator.getCurrentPosition();
          _centerOnLocation(currentLocation, speed: position.speed);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not get current location: $e')),
      );
    }
  }

  Future<void> _startNewRouteFlow(BuildContext context) async {
    final selectedRouteType = await showRouteTypeEnumDialog(context);
    if (selectedRouteType == null) return;
    
    try {
      setState(() {
        _isLoading = true;
      });
      
      final currentLocation = await LocationService.getCurrentLocation();
      if (currentLocation == null) {
        throw Exception('Could not get current location');
      }

      final startPoint = app_models.GeoPoint(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );
      
      if (widget.baseRoute != null) {
        await ref.read(routeCreationProvider.notifier).startExistingRoute(widget.baseRoute!);
      } else {
        await ref.read(routeCreationProvider.notifier).startNewRoute(selectedRouteType, startPoint);
      }
      
      setState(() {
        _isLoading = false;
        _isNavigationMode = true;
        _isAutoFollowing = true;
        _userHasManuallyZoomed = false; // Reset manual zoom flag
      });
      
      // After starting navigation, center on the current location with speed-based zoom
      // Get latest position for speed and heading
      final position = await geo.Geolocator.getCurrentPosition();
      await _mapboxMap!.flyTo(
        CameraOptions(
          center: Point.fromJson({"coordinates": [currentLocation.longitude, currentLocation.latitude]}),
          zoom: _getZoomLevelBasedOnSpeed(position.speed),
          pitch: MapConfig.NAVIGATION_TILT,
          bearing: position.heading,
        ),
        MapAnimationOptions(duration: 500),
      );
      
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting route: $e')),
      );
    }
  }

  Future<void> _followUserLocation(geo.Position position) async {
    if (_mapboxMap == null) return;
    
    // Get zoom level based on speed if auto-following is enabled
    double zoomLevel = _isAutoFollowing && !_userHasManuallyZoomed
        ? _getZoomLevelBasedOnSpeed(position.speed)
        : _userSetZoomLevel;
    
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({"coordinates": [position.longitude, position.latitude]}),
        zoom: zoomLevel,
        pitch: MapConfig.NAVIGATION_TILT,
        bearing: position.heading,
      ),
      MapAnimationOptions(duration: 300),
    );
  }

  // Get the appropriate zoom level based on current speed
  double _getZoomLevelBasedOnSpeed(double speedMps) {
    return SpeedThresholds.getZoomForSpeed(speedMps);
  }

  Future<void> _updateUserRoutePath() async {
    if (_mapboxMap == null || _polylineManager == null) return;
    
    try {
      final committedPoints = ref.read(routeCreationProvider.notifier).committedPoints;
      
      if (committedPoints.length < 2) return;
      
      if (_routePolyline != null) {
        await _polylineManager!.delete(_routePolyline!);
      }
      
      final List<List<double>> coordinates = committedPoints.map((point) => 
        [point.longitude!, point.latitude!]
      ).toList();
      
      final options = PolylineAnnotationOptions(
        geometry: LineString.fromJson({"coordinates": coordinates}),
        lineWidth: 4.0,
        lineColor: Colors.red.value,
      );
      
      _routePolyline = await _polylineManager!.create(options);
    } catch (e) {
      print('Error updating route path: $e');
    }
  }

  Future<void> _drawBaseRoute() async {
    if (_mapboxMap == null || widget.baseRoute == null || _polylineManager == null) return;
    
    final route = widget.baseRoute!;
    
    if (route.startPoint != null) {
      final startPoint = LatLng(
        route.startPoint!.latitude!,
        route.startPoint!.longitude!,
      );
      
      // Use a default zoom that works for viewing full routes
      await _mapboxMap!.flyTo(
        CameraOptions(
          center: Point.fromJson({"coordinates": [startPoint.longitude, startPoint.latitude]}),
          zoom: SpeedThresholds.ZOOM_BIKING, // Middle-range zoom good for route overview
          pitch: MapConfig.DEFAULT_TILT,
        ),
        MapAnimationOptions(duration: 500),
      );
    }
    
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
      } catch (e) {
        print('Error drawing base route: $e');
      }
    }
  }

  void _showMapLayersBottomSheet(BuildContext context) {
    // Disable auto-following when user opens map layers
    if (_isNavigationMode) {
      setState(() {
        _isAutoFollowing = false;
      });
    }
    
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
    final shouldStop = await showStopDialog(context);
    if (shouldStop != true) return;
    
    await ref.read(routeCreationProvider.notifier).stopUserRoute();
    
    final userRoute = ref.read(routeCreationProvider);
    final baseRoute = ref.read(routeCreationProvider.notifier).baseRoute;
    
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
    final userRoute = ref.read(routeCreationProvider);
    if (userRoute != null) {
      _stopRouteTracking();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _updateUserZoomLevel() async {
    if (_mapboxMap != null) {
      try {
        // Get current camera state to retrieve the zoom level
        CameraState cameraState = await _mapboxMap!.getCameraState();
        setState(() {
          _userSetZoomLevel = cameraState.zoom;
          _userHasManuallyZoomed = true; // Mark that user has manually zoomed
        });
        
        // This doesn't affect auto-following since it's only the zoom that changed
      } catch (e) {
        print('Error getting zoom level: $e');
      }
    }
  }
}
