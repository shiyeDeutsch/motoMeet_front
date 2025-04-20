import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'dart:convert';

import '../constants/map_utilties.dart';
import '../models/route.dart' as app_models;
import '../providers/route_creation_provider.dart';
import '../services/locationService.dart';

import '../models/enum.dart';
import '../screens/mapScreen.dart' show NavigationState;

class MapController {
  final void Function(String message) onError;
  final void Function(NavigationState navState) onNavStateChanged;
  final TickerProvider tickerProvider;
  final WidgetRef ref;
  final app_models.Route? baseRoute;

  MapboxMap? _mapboxMap;
  String currentMapStyle = MapboxStyle.STYLE_OUTDOORS;
  NavigationState _navState = NavigationState.loading;
  bool _isAutoFollowing = true;

  MapController({
    required this.onError,
    required this.onNavStateChanged,
    required this.tickerProvider,
    required this.ref,
    required this.baseRoute,
  }) {}

  CameraOptions get initialCameraOptions => CameraOptions(
        center: Point.fromJson({
          "coordinates": [0.0, 0.0]
        }),
        zoom: MapAnimations.DEFAULT_ZOOM,
        bearing: 0.0,
        pitch: MapConfig.DEFAULT_TILT,
      );

  void dispose() {
    _mapboxMap?.dispose();
  }

  Future<void> onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    try {
      await _requestLocationPermission();
      await _initializeLocationComponent();
      onNavStateChanged(NavigationState.idle);
    } catch (e) {
      onError('Error initializing map: $e');
      onNavStateChanged(NavigationState.idle);
    }
  }

  Future<void> onStyleLoadedCallback(StyleLoadedEventData data) async {
    await _initializeRouteLayersOnMap();
    if (baseRoute != null) {
      await displayExistingRoute();
    }
    final currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      await centerOnLocation(currentLocation);
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

  Future<void> _initializeRouteLayersOnMap() async {
    if (_mapboxMap == null) return;
    final style = _mapboxMap!.style;
    if (!await style.styleSourceExists(MapLayers.USER_ROUTE_SOURCE_ID)) {
      await style.addSource(
          GeoJsonSource(id: MapLayers.USER_ROUTE_SOURCE_ID, lineMetrics: true));
    }
    if (!await style.styleLayerExists(MapLayers.USER_ROUTE_LAYER_ID)) {
      await style.addLayer(
        LineLayer(
          id: MapLayers.USER_ROUTE_LAYER_ID,
          sourceId: MapLayers.USER_ROUTE_SOURCE_ID,
          lineCap: LineCap.ROUND,
          lineJoin: LineJoin.ROUND,
          lineWidth: 4.0,
          lineColor: Colors.red.value,
        ),
      );
    }
    if (!await style.styleSourceExists(MapLayers.BASE_ROUTE_SOURCE_ID)) {
      await style.addSource(
          GeoJsonSource(id: MapLayers.BASE_ROUTE_SOURCE_ID, lineMetrics: true));
    }
    if (!await style.styleLayerExists(MapLayers.BASE_ROUTE_LAYER_ID)) {
      await style.addLayer(
        LineLayer(
          id: MapLayers.BASE_ROUTE_LAYER_ID,
          sourceId: MapLayers.BASE_ROUTE_SOURCE_ID,
          lineCap: LineCap.ROUND,
          lineJoin: LineJoin.ROUND,
          lineWidth: 4.0,
          lineColor: Colors.blue.value,
          lineOpacity: 0.7,
        ),
      );
    }
  }

  Future<void> renderRouteOnMap({
    required List points,
    required String sourceId,
    required Color color,
  }) async {
    if (_mapboxMap == null || points.length < 2) return;
    final coordinates = points.map((p) => [p.longitude!, p.latitude!]).toList();
    final lineString = LineString(
        coordinates: coordinates.map((c) => Position(c[0], c[1])).toList());
    final geoJson = json.encode(lineString);
    final source = await _mapboxMap!.style.getSource(sourceId);
    if (source is GeoJsonSource) {
      source.updateGeoJSON(geoJson);
    }
  }

  Future<void> displayUserCreatedRoute() async {
    final points = ref.read(routeCreationProvider.notifier).committedPoints;
    await renderRouteOnMap(
        points: points,
        sourceId: MapLayers.USER_ROUTE_SOURCE_ID,
        color: Colors.red);
  }

  Future<void> displayExistingRoute() async {
    if (_mapboxMap == null || baseRoute == null) return;
    final route = baseRoute!;
    if (route.startPoint != null) {
      final startPoint = LatLng(
        route.startPoint!.latitude!,
        route.startPoint!.longitude!,
      );
      await flyToCamera(
        longitude: startPoint.longitude,
        latitude: startPoint.latitude,
        zoom: MapAnimations.ZOOM_MOVING,
        pitch: MapConfig.DEFAULT_TILT,
        duration: MapAnimations.ANIMATION_DURATION,
      );
    }
    final routePointsList = route.routePoints.toList();
    if (routePointsList.isNotEmpty) {
      await renderRouteOnMap(
        points: routePointsList.map((p) => p.point!).toList(),
        sourceId: MapLayers.BASE_ROUTE_SOURCE_ID,
        color: Colors.blue,
      );
    }
  }

  void onUserMapInteraction() {
    if (_navState == NavigationState.navigating && _isAutoFollowing) {
      _isAutoFollowing = false;
      onNavStateChanged(_navState);
    }
  }

  Future<void> flyToCamera({
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
      MapAnimationOptions(
          duration: duration ?? MapAnimations.MAP_ANIMATION_DURATION),
    );
  }

  Future<void> centerOnLocation(LatLng location, {double? speed}) async {
    if (_mapboxMap == null) return;
    double zoomLevel = (speed != null && speed > 0)
        ? MapAnimations.ZOOM_MOVING
        : MapAnimations.ZOOM_STATIONARY;
    await flyToCamera(
      longitude: location.longitude,
      latitude: location.latitude,
      zoom: zoomLevel,
      pitch: _navState == NavigationState.navigating
          ? MapConfig.NAVIGATION_TILT
          : MapConfig.DEFAULT_TILT,
    );
  }

  Future<void> followUserLocation(geo.Position position) async {
    if (_mapboxMap == null) return;
    double zoomLevel = (position.speed > 0)
        ? MapAnimations.ZOOM_MOVING
        : MapAnimations.ZOOM_STATIONARY;
    await flyToCamera(
      longitude: position.longitude,
      latitude: position.latitude,
      zoom: zoomLevel,
      pitch: MapConfig.NAVIGATION_TILT,
      bearing: _navState == NavigationState.navigating ? position.heading : 0,
    );
  }

  Future<void> centerOnCurrentLocation() async {
    try {
      final currentPosition = ref.read(userLocationProvider);
      if (currentPosition != null) {
        _isAutoFollowing = true;
        await followUserLocation(currentPosition);
      } else {
        final currentLocation = await LocationService.getCurrentLocation();
        if (currentLocation != null) {
          final position = await geo.Geolocator.getCurrentPosition();
          await centerOnLocation(currentLocation, speed: position.speed);
        }
      }
    } catch (e) {
      onError('Could not get current location: $e');
    }
  }

  void loadStyleURI(String style) {
    currentMapStyle = style;
    _mapboxMap?.loadStyleURI(style);
  }
}
