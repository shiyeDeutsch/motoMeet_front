import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';

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

  // Layer & Source IDs
  final String _userRouteLayerId = 'user-route-layer';
  final String _userRouteSourceId = 'user-route-source';
  final String _baseRouteLayerId = 'base-route-layer';
  final String _baseRouteSourceId = 'base-route-source';

  // Animation controller for route drawing
  AnimationController? _routeAnimationController;
  Animation<double>? _routeAnimation;

  // Zoom levels
  static const double _ZOOM_MOVING = 17.0; // Zoomed-in when moving
  static const double _ZOOM_STATIONARY = 14.0; // Zoomed-out when stationary

  @override
  void initState() {
    super.initState();
    // Initialize animation controller (optional, can be removed if _animateRoute is not used)
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

  // Simplified: Add both route layers robustly (inlined logic)
  Future<void> _addRouteLayers() async {
    if (_mapboxMap == null) return;
    final style = _mapboxMap!.style;
    // User route
    if (!await style.styleSourceExists(_userRouteSourceId)) {
      await style.addSource(GeoJsonSource(id: _userRouteSourceId, lineMetrics: true));
    }
    if (!await style.styleLayerExists(_userRouteLayerId)) {
      await style.addLayer(
        LineLayer(
          id: _userRouteLayerId,
          sourceId: _userRouteSourceId,
          lineCap: LineCap.ROUND,
          lineJoin: LineJoin.ROUND,
          lineWidth: 4.0,
          lineColor: Colors.red.value,
        ),
      );
    }
    // Base route
    if (!await style.styleSourceExists(_baseRouteSourceId)) {
      await style.addSource(GeoJsonSource(id: _baseRouteSourceId, lineMetrics: true));
    }
    if (!await style.styleLayerExists(_baseRouteLayerId)) {
      await style.addLayer(
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
  }

  // Optimized: Update user route path robustly (no try/catch)
  Future<void> _updateUserRoutePath() async {
    if (_mapboxMap == null) return;
    final committedPoints = ref.read(routeCreationProvider.notifier).committedPoints;
    if (committedPoints.length < 2) return;
    final coordinates = committedPoints
        .map((point) => [point.longitude!, point.latitude!])
        .toList();
    final lineString = LineString(coordinates: coordinates.map((c) => Position(c[0], c[1])).toList());
    final geoJson = json.encode(lineString);
    final source = await _mapboxMap!.style.getSource(_userRouteSourceId);
    if (source is GeoJsonSource) {
      source.updateGeoJSON(geoJson);
    }
  }

  void _onUserMapInteraction() {
    // Disable auto-following when user manually interacts with map
    if (_isNavigationMode && _isAutoFollowing) {
      setState(() {
        _isAutoFollowing = false;
      });
    }
  }

  Future<void> _centerOnLocation(LatLng location, {double? speed}) async {
    if (_mapboxMap == null) return;
    double zoomLevel = (speed != null && speed > 0) ? _ZOOM_MOVING : _ZOOM_STATIONARY;
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
    double zoomLevel = (position.speed > 0) ? _ZOOM_MOVING : _ZOOM_STATIONARY;
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
        setState(() {
          _isAutoFollowing = true;
        });
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
          zoom: _ZOOM_MOVING,
          pitch: MapConfig.DEFAULT_TILT,
        ),
        MapAnimationOptions(duration: 500),
      );
    }
    // No try/catch for simplicity
    final routePointsList = route.routePoints.toList();
    if (routePointsList.isNotEmpty) {
      List<List<double>> coordinates = routePointsList
          .map((point) => [point.point!.longitude!, point.point!.latitude!])
          .toList();
      if (coordinates.isNotEmpty) {
        final lineString = LineString.fromJson({"coordinates": coordinates});
        final jsonString = '{"type":"LineString","coordinates":${lineString.coordinates}}';
        final source = await _mapboxMap!.style.getSource(_baseRouteSourceId);
        (source as GeoJsonSource).updateGeoJSON(jsonString);
      }
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
          zoom: (position.speed > 0) ? _ZOOM_MOVING : _ZOOM_STATIONARY,
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
