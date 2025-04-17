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

enum NavigationState { loading, idle, navigating }

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

  // Navigation state
  NavigationState _navState = NavigationState.loading;
  bool _isAutoFollowing = true;

  // Layer & Source IDs
  static const String _userRouteLayerId = 'user-route-layer';
  static const String _userRouteSourceId = 'user-route-source';
  static const String _baseRouteLayerId = 'base-route-layer';
  static const String _baseRouteSourceId = 'base-route-source';

  // Animation controller for route drawing
  AnimationController? _routeAnimationController;

  // Zoom levels and animation durations
  static const double _ZOOM_MOVING = 17.0;
  static const double _ZOOM_STATIONARY = 14.0;
  static const int _ANIMATION_DURATION = 500;
  static const int _MAP_ANIMATION_DURATION = 300;

  late final ProviderSubscription _routeListener;

  @override
  void initState() {
    super.initState();
    _routeAnimationController = AnimationController(
      duration: const Duration(milliseconds: _ANIMATION_DURATION),
      vsync: this,
    );
    _routeListener = ref.listenManual<app_models.UserRoute?>(
      routeCreationProvider,
      (previous, next) {
        if (next != null && _mapboxMap != null) {
          _drawRoute(
            points: ref.read(routeCreationProvider.notifier).committedPoints,
            sourceId: _userRouteSourceId,
            color: Colors.red,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _routeListener.close();
    _routeAnimationController?.dispose();
    _mapboxMap?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRoute = ref.watch(routeCreationProvider);
    final userLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: Stack(
        children: [
          _buildMapView(),
          _buildControls(),
          if (userRoute == null && _navState != NavigationState.loading)
            _buildStartRouteButton(),
          if (userRoute != null)
            _buildActiveRouteDetails(userRoute, userLocation),
          if (_navState == NavigationState.loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildControls() => MapControlsWidget(
    onBackPressed: () => _handleBackPress(context),
    onCenterLocationPressed: _centerOnCurrentLocation,
    onLayersPressed: () => _showMapLayersBottomSheet(context),
  );

  Widget _buildStartRouteButton() => StartRouteButton(
    onPressed: () => _startNewRoute(context),
    label: widget.baseRoute != null ? 'Start Following Route' : 'Start New Route',
  );

  Widget _buildActiveRouteDetails(userRoute, userLocation) => Positioned(
    bottom: 0, left: 0, right: 0,
    child: ActiveRouteDetails(
      currentUserRoute: userRoute,
      baseRoute: widget.baseRoute,
      currentPosition: userLocation,
      onStopPressed: _stopRouteTracking,
      context: context,
    ),
  );

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
      await _requestLocationPermission();
      await _initializeLocationComponent();
      if (!mounted) return;
      setState(() {
        _navState = NavigationState.idle;
      });
    } catch (e) {
      _showError('Error initializing map: $e');
      if (!mounted) return;
      setState(() {
        _navState = NavigationState.idle;
      });
    }
  }

  Future<void> _onStyleLoadedCallback(StyleLoadedEventData data) async {
    await _addRouteLayers();
    if (widget.baseRoute != null) {
      await _drawBaseRoute();
    }
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
    if (_mapboxMap == null) return;
    final style = _mapboxMap!.style;
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

  Future<void> _drawRoute({
    required List points,
    required String sourceId,
    required Color color,
  }) async {
    if (_mapboxMap == null || points.length < 2) return;
    final coordinates = points.map((p) => [p.longitude!, p.latitude!]).toList();
    final lineString = LineString(coordinates: coordinates.map((c) => Position(c[0], c[1])).toList());
    final geoJson = json.encode(lineString);
    final source = await _mapboxMap!.style.getSource(sourceId);
    if (source is GeoJsonSource) {
      source.updateGeoJSON(geoJson);
    }
  }

  void _onUserMapInteraction() {
    if (_navState == NavigationState.navigating && _isAutoFollowing) {
      setState(() {
        _isAutoFollowing = false;
      });
    }
  }

  // Helper to fly the map camera with consistent options
  Future<void> _flyToCamera({
    required double longitude,
    required double latitude,
    required double zoom,
    required double pitch,
    double? bearing,
    int? duration,
  }) async {
    if (_mapboxMap == null) return;
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point.fromJson({
          "coordinates": [longitude, latitude]
        }),
        zoom: zoom,
        pitch: pitch,
        bearing: bearing,
      ),
      MapAnimationOptions(duration: duration ?? _MAP_ANIMATION_DURATION),
    );
  }

  Future<void> _centerOnLocation(LatLng location, {double? speed}) async {
    if (_mapboxMap == null) return;
    double zoomLevel = (speed != null && speed > 0) ? _ZOOM_MOVING : _ZOOM_STATIONARY;
    await _flyToCamera(
      longitude: location.longitude,
      latitude: location.latitude,
      zoom: zoomLevel,
      pitch: _navState == NavigationState.navigating ? MapConfig.NAVIGATION_TILT : MapConfig.DEFAULT_TILT,
    );
  }

  Future<void> _followUserLocation(geo.Position position) async {
    if (_mapboxMap == null) return;
    double zoomLevel = (position.speed > 0) ? _ZOOM_MOVING : _ZOOM_STATIONARY;
    await _flyToCamera(
      longitude: position.longitude,
      latitude: position.latitude,
      zoom: zoomLevel,
      pitch: MapConfig.NAVIGATION_TILT,
      bearing: _navState == NavigationState.navigating ? position.heading : 0,
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
      _showError('Could not get current location: $e');
    }
  }

  Future<void> _drawBaseRoute() async {
    if (_mapboxMap == null || widget.baseRoute == null) return;
    final route = widget.baseRoute!;
    if (route.startPoint != null) {
      final startPoint = LatLng(
        route.startPoint!.latitude!,
        route.startPoint!.longitude!,
      );
      await _flyToCamera(
        longitude: startPoint.longitude,
        latitude: startPoint.latitude,
        zoom: _ZOOM_MOVING,
        pitch: MapConfig.DEFAULT_TILT,
        duration: _ANIMATION_DURATION,
      );
    }
    final routePointsList = route.routePoints.toList();
    if (routePointsList.isNotEmpty) {
      await _drawRoute(
        points: routePointsList.map((p) => p.point!).toList(),
        sourceId: _baseRouteSourceId,
        color: Colors.blue,
      );
    }
  }

  Future<void> _startNewRoute(BuildContext context) async {
    final selectedRouteType = await showRouteTypeEnumDialog(context);
    if (selectedRouteType == null) return;

    try {
      setState(() {
        _navState = NavigationState.loading;
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

      if (!mounted) return;
      setState(() {
        _navState = NavigationState.navigating;
        _isAutoFollowing = true;
      });

      await _drawRoute(
        points: ref.read(routeCreationProvider.notifier).committedPoints,
        sourceId: _userRouteSourceId,
        color: Colors.red,
      );

      final position = await geo.Geolocator.getCurrentPosition();
      await _flyToCamera(
        longitude: currentLocation.longitude,
        latitude: currentLocation.latitude,
        zoom: (position.speed > 0) ? _ZOOM_MOVING : _ZOOM_STATIONARY,
        pitch: MapConfig.NAVIGATION_TILT,
        bearing: position.heading,
        duration: _ANIMATION_DURATION,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _navState = NavigationState.idle;
      });
      _showError('Error starting route: $e');
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
    if (_navState == NavigationState.navigating) {
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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
