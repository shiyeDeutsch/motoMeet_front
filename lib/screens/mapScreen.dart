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

class _MapScreenState extends ConsumerState<MapScreen> with TickerProviderStateMixin {
  // Map controller
  MapboxMap? _mapboxMap;

  // Map style
  String _currentMapStyle = MapboxConfig.STYLE_OUTDOORS;

  // State tracking
  bool _isLoading = true;
  bool _isNavigationMode = false;
  bool _isAutoFollowing = true;
  double _userSetZoomLevel = MapConfig.DEFAULT_ZOOM;

  // Camera constraints
  final _defaultEdgeInsets = MbxEdgeInsets(top: 100, left: 100, bottom: 100, right: 100);

  // Layer & Source IDs
  final String _userRouteLayerId = 'user-route-layer';
  final String _userRouteSourceId = 'user-route-source';
  final String _baseRouteLayerId = 'base-route-layer';
  final String _baseRouteSourceId = 'base-route-source';

  // Animation controller for route drawing
  AnimationController? _routeAnimationController;
  Animation<double>? _routeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _routeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _routeAnimationController?.dispose();
    _mapboxMap?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch providers for reactive updates
    final userRoute = ref.watch(routeCreationProvider);
    final userLocation = ref.watch(userLocationProvider);

    // Update map when userLocation changes
    if (userLocation != null && _mapboxMap != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_isNavigationMode && _isAutoFollowing) {
          _followUserLocation(userLocation);
        }
      });
    }

    // Listen for route updates and update the path
    ref.listen<app_models.UserRoute?>(
      routeCreationProvider, 
      (previous, next) {
        if (next != null && _mapboxMap != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateUserRoutePath();
    });
        }
      }
    );

    return Scaffold(
      body: Stack(
        children: [
          // Map Widget
          _buildMapView(),
          
          // Controls overlay
          MapControlsWidget(
            onBackPressed: () => _handleBackPress(context),
            onCenterLocationPressed: _centerOnCurrentLocation,
            onLayersPressed: () => _showMapLayersBottomSheet(context),
          ),
          
          // Route action button
          if (userRoute == null && !_isLoading)
            StartRouteButton(
              onPressed: () => _startNewRouteFlow(context),
              label: widget.baseRoute != null
                  ? 'Start Following Route'
                  : 'Start New Route',
            ),
          
          // Active route details
          if (userRoute != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ActiveRouteDetails(
                currentUserRoute: userRoute,
                baseRoute: widget.baseRoute,
                currentPosition: userLocation,
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
        onStyleLoadedListener: _onStyleLoadedCallback,
        cameraOptions: CameraOptions(
          center: Point.fromJson({
            "coordinates": [0.0, 0.0]
          }),
          zoom: MapConfig.DEFAULT_ZOOM,
          bearing: 0.0,
          pitch: MapConfig.DEFAULT_TILT,
        ),
        onScrollListener: (_) => _onUserMapInteraction(),
      ),
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    try {
      // Request location permissions
      await _requestLocationPermission();

      // Initialize location component
      await _initializeLocationComponent();

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

  Future<void> _onStyleLoadedCallback(StyleLoadedEventData data) async {
    // Add necessary sources and layers
    await _addRouteLayers();
    
    // If base route exists, draw it
    if (widget.baseRoute != null) {
      await _drawBaseRoute();
    }

    // Get and center on user's location
    final currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      await _centerOnLocation(currentLocation);
    }
  }

  Future<void> _requestLocationPermission() async {
    await geo.Geolocator.requestPermission();
  }

  Future<void> _initializeLocationComponent() async {
    await _mapboxMap?.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        puckBearingEnabled: true,
        showAccuracyRing: true,
        accuracyRingColor: Colors.blue.withOpacity(0.1).value,
        accuracyRingBorderColor: Colors.blue.value,
        pulsingEnabled: true,
        pulsingColor: Colors.blue.value,
        pulsingMaxRadius: 50,
        locationPuck: LocationPuck(
          locationPuck2D: DefaultLocationPuck2D(
            topImage: null,
            bearingImage: null,
            shadowImage: null,
            scaleExpression: null,
          ),
        ),
      ),
    );
  }

  Future<void> _addRouteLayers() async {
    // Add source and layer for user route
    await _mapboxMap?.style.addSource(
      GeoJsonSource(id: _userRouteSourceId, lineMetrics: true),
    );
    
    await _mapboxMap?.style.addLayer(
      LineLayer(
        id: _userRouteLayerId,
        sourceId: _userRouteSourceId,
        lineCap: LineCap.ROUND,
        lineJoin: LineJoin.ROUND,
        lineWidth: 4.0,
        lineColor: Colors.red.value,
      ),
    );

    // Add source and layer for base route
    await _mapboxMap?.style.addSource(
      GeoJsonSource(id: _baseRouteSourceId, lineMetrics: true),
    );
    
    await _mapboxMap?.style.addLayer(
      LineLayer(
        id: _baseRouteLayerId,
        sourceId: _baseRouteSourceId,
        lineCap: LineCap.ROUND,
        lineJoin: LineJoin.ROUND,
        lineWidth: 4.0,
        lineColor: Colors.blue.value,
        lineOpacity: 0.7,
      ),
    );
  }

  void _onUserMapInteraction() {
    // Disable auto-following when user manually interacts with map
    if (_isNavigationMode && _isAutoFollowing) {
      setState(() {
        _isAutoFollowing = false;
      });
    }
  }

  void _onCameraChanged(CameraChangedEventData event) {
    // Update user set zoom level when camera updates
    if (_mapboxMap != null) {
      _mapboxMap!.getCameraState().then((cameraState) {
        _userSetZoomLevel = cameraState.zoom;
      });
    }
  }

  Future<void> _centerOnLocation(LatLng location, {double? speed}) async {
    if (_mapboxMap == null) return;

    // Determine zoom level based on speed (if provided)
    double zoomLevel;
    if (speed != null && _isAutoFollowing) {
      zoomLevel = _getZoomLevelBasedOnSpeed(speed);
    } else {
      zoomLevel = _userSetZoomLevel;
    }

    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({
          "coordinates": [location.longitude, location.latitude]
        }),
        zoom: zoomLevel,
        pitch: _isNavigationMode
            ? MapConfig.NAVIGATION_TILT
            : MapConfig.DEFAULT_TILT,
      ),
      MapAnimationOptions(duration: 300),
    );
  }

  Future<void> _followUserLocation(geo.Position position) async {
    if (_mapboxMap == null) return;

    // Determine zoom level based on speed
    double zoomLevel = _isAutoFollowing 
        ? _getZoomLevelBasedOnSpeed(position.speed) 
        : _userSetZoomLevel;

    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({
          "coordinates": [position.longitude, position.latitude]
        }),
        zoom: zoomLevel,
        pitch: MapConfig.NAVIGATION_TILT,
        bearing: _isNavigationMode ? position.heading : 0,
      ),
      MapAnimationOptions(duration: 300),
    );
  }

  Future<void> _centerOnCurrentLocation() async {
    try {
      final currentPosition = ref.read(userLocationProvider);
      
      if (currentPosition != null) {
        // Reset auto-follow mode
        setState(() {
          _isAutoFollowing = true;
        });

        // Center map on current position
        await _followUserLocation(currentPosition);
      } else {
        final currentLocation = await LocationService.getCurrentLocation();
        if (currentLocation != null) {
          final position = await geo.Geolocator.getCurrentPosition();
          await _centerOnLocation(currentLocation, speed: position.speed);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not get current location: $e')),
      );
    }
  }

  double _getZoomLevelBasedOnSpeed(double speedMps) {
    return SpeedThresholds.getZoomForSpeed(speedMps);
  }

  Future<void> _updateUserRoutePath() async {
    if (_mapboxMap == null) return;

    try {
      final committedPoints = ref.read(routeCreationProvider.notifier).committedPoints;
      
      if (committedPoints.length < 2) return;

      final List<List<double>> coordinates = committedPoints
          .map((point) => [point.longitude!, point.latitude!])
          .toList();

      final lineString = LineString.fromJson({"coordinates": coordinates});
      final jsonString = '{"type":"LineString","coordinates":${lineString.coordinates}}';
      
      // Update the GeoJSON source
      final source = await _mapboxMap!.style.getSource(_userRouteSourceId);
      (source as GeoJsonSource).updateGeoJSON(jsonString);

      // Animate the line (optional)
      _animateRoute();
    } catch (e) {
      print('Error updating route path: $e');
    }
  }

  void _animateRoute() {
    // Reset animation controller
    _routeAnimationController?.reset();
    
    // Configure animation
    _routeAnimation = Tween<double>(begin: 0, end: 1.0).animate(_routeAnimationController!)
      ..addListener(() {
        _mapboxMap?.style.setStyleLayerProperty(
          _userRouteLayerId, 
          "line-trim-offset", 
          [0, _routeAnimation?.value ?? 1.0]
        );
      });
    
    // Start animation
    _routeAnimationController?.forward();
  }

  Future<void> _drawBaseRoute() async {
    if (_mapboxMap == null || widget.baseRoute == null) return;

    final route = widget.baseRoute!;

    // Center map on route start point
    if (route.startPoint != null) {
      final startPoint = LatLng(
        route.startPoint!.latitude!,
        route.startPoint!.longitude!,
      );

      await _mapboxMap!.flyTo(
        CameraOptions(
          center: Point.fromJson({
            "coordinates": [startPoint.longitude, startPoint.latitude]
          }),
          zoom: SpeedThresholds.ZOOM_BIKING,
          pitch: MapConfig.DEFAULT_TILT,
        ),
        MapAnimationOptions(duration: 500),
      );
    }

    try {
      // Get route points
      final routePointsList = route.routePoints.toList();

      if (routePointsList.isNotEmpty) {
        List<List<double>> coordinates = routePointsList
            .map((point) => [point.point!.longitude!, point.point!.latitude!])
            .toList();

        if (coordinates.isNotEmpty) {
          final lineString = LineString.fromJson({"coordinates": coordinates});
          final jsonString = '{"type":"LineString","coordinates":${lineString.coordinates}}';
          
          // Update the GeoJSON source
          final source = await _mapboxMap!.style.getSource(_baseRouteSourceId);
          (source as GeoJsonSource).updateGeoJSON(jsonString);
        }
      }
    } catch (e) {
      print('Error drawing base route: $e');
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
        await ref
            .read(routeCreationProvider.notifier)
            .startExistingRoute(widget.baseRoute!);
      } else {
        await ref
            .read(routeCreationProvider.notifier)
            .startNewRoute(selectedRouteType, startPoint);
      }

      setState(() {
        _isLoading = false;
        _isNavigationMode = true;
        _isAutoFollowing = true;
      });

      // Initialize the route path
      await _updateUserRoutePath();

      // Get latest position for speed and heading
      final position = await geo.Geolocator.getCurrentPosition();
      await _mapboxMap!.flyTo(
        CameraOptions(
          center: Point.fromJson({
            "coordinates": [currentLocation.longitude, currentLocation.latitude]
          }),
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
}
