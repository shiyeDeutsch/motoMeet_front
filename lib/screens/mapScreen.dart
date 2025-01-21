import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:get_it/get_it.dart';

import '../models/enum.dart';
import '../models/route.dart';
import '../routing/routes.dart';
import '../services/loctionService.dart';
import '../services/routeService.dart';  // The new, refactored RouteService
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/dialogs/stopRoutedialog.dart';

class MapMarkerScreen extends ConsumerStatefulWidget {
  const MapMarkerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapMarkerScreen> createState() => _MapMarkerScreenState();
}

class _MapMarkerScreenState extends ConsumerState<MapMarkerScreen>
    with TickerProviderStateMixin {
  // Animated controller for the map
  final MapController _mapController = MapController();
  late final AnimatedMapController _animatedMapController;

  // We no longer keep a local routePoints list, only a local marker if needed.
  StreamSubscription<Position>? _locationUpdatesSubscription;

  // For expanding the bottom sheet
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    // Initialize animated controller
    _animatedMapController =
        AnimatedMapController(vsync: this, mapController: _mapController);

    // Optionally center the map on the user’s current location
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final LatLng? location = await LocationService.getCurrentLocation();
      if (location != null) {
        _animatedMapController.animateTo(
          dest: location,
          zoom: 13.5,
          rotation: 0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Watch the entire route (NewRoute?) from the routeService
    final currentRoute = ref.watch(routeServiceProvider);
    // 2. Read the routeService to get the currentPosition
    final routeService = ref.read(routeServiceProvider.notifier);
    final currentPosition = routeService.currentPosition;

    // Prepare the “committed” polyline from route points
    final committedPoints = currentRoute?.routePoints ?? [];

    return Stack(
      children: [
        _buildFlutterMap(committedPoints, currentPosition),
        if (!(currentRoute?.isActive ?? false)) _buildStartRouteButton(),
        if (currentRoute?.isActive ?? false) _buildActiveRouteDetails(context, currentRoute),
      ],
    );
  }

  Widget _buildFlutterMap(List<GeoPoint> committedPoints, Position? userPos) {
    // Convert GeoPoints to LatLng
    final polylinePoints =
        committedPoints.map((gp) => gp.toLatLng()).toList();

    // Current user location marker
    Marker? currentMarker;
    if (userPos != null) {
      currentMarker = Marker(
        point: LatLng(userPos.latitude, userPos.longitude),
        child:  const Icon(Icons.location_pin, color: Colors.red),
      );
    }

    return FlutterMap(
      mapController: _animatedMapController.mapController,
      options: MapOptions(
        zoom: 13.0,
      ),
      children: [
        // Base map
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        // Polyline for the route
        PolylineLayer(
          polylines: [
            Polyline(
              points: polylinePoints,
              strokeWidth: 5,
              color: Colors.blueAccent,
            ),
          ],
        ),
        // Markers: user + any other markers
        MarkerLayer(
          markers: [
            if (currentMarker != null) currentMarker,
            ..._buildWaypointMarkers(currentRoute?.pointOfInterest),
          ],
        ),
      ],
    );
  }

  Widget _buildStartRouteButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _onPressStartRoute,
          child: const Text('Start New Route'),
        ),
      ),
    );
  }

  /// Start a new route
  Future<void> _onPressStartRoute() async {
    // Show the choose route type dialog
    final routeType = await showRouteTypeEnumDialog(context);
    if (routeType == null) return;

    // Determine user’s current location (or last known)
    final location = await LocationService.getCurrentLocation();
    if (location == null) return;

    final routeService = ref.read(routeServiceProvider.notifier);

    // Start a new route with that routeType
    routeService.startNewRoute(
      routeType,
      GeoPoint.fromLatLng(location, null),
    );
  }

  Widget _buildActiveRouteDetails(BuildContext context, NewRoute? currentRoute) {
    if (currentRoute == null) return const SizedBox.shrink();

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Info (distance, time, etc.)
            Text(
              'Distance: ${(currentRoute.length ?? 0 / 1000).toStringAsFixed(2)} km',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Duration: ${currentRoute.durationMinutes} min',
              style: const TextStyle(color: Colors.white),
            ),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white),
                  onPressed: () => _onStopRoutePressed(context),
                ),
                IconButton(
                  icon: const Icon(Icons.add_location, color: Colors.white),
                  onPressed: () {
                    // e.g., add waypoint
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // share logic
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Stop the route
  Future<void> _onStopRoutePressed(BuildContext context) async {
    final shouldStop = await showStopDialog(context);
    if (shouldStop == true) {
      // After stopping, you could navigate to the route-saving screen, etc.
      final routeService = ref.read(routeServiceProvider.notifier);
      await routeService.stopRoute();

      Navigator.of(context).pushNamed(
        Routes.saveRoute,
        arguments: {'newRoute': ref.read(routeServiceProvider)},
      );
    }
  }

 List<Marker> _buildWaypointMarkers(List<Waypoint>? waypoints) {
  return waypoints?.map((waypoint) => Marker(
    point: waypoint.location!.toLatLng(),
    width: 40,
    height: 40,
    child: Icon(
      _getWaypointIcon(waypoint.type!),
      color: Colors.blue,
    ),
  )).toList() ?? [];
}

_getWaypointIcon(WaypointType type) {
  switch (getCategory(type)) {
    case WaypointCategory.Natural:
      return Icons.nature;
    case WaypointCategory.Informative:
      return Icons.info;
    case WaypointCategory.Warning:
      return Icons.warning;
    default:
      return Icons.location_on;
  }

  @override
  void dispose() {
    _locationUpdatesSubscription?.cancel();
    super.dispose();
  }
}
