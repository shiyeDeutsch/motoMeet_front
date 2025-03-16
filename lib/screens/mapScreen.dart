import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:get_it/get_it.dart';
import '../models/route.dart' as app_models;
import '../models/enum.dart';
import '../routing/routes.dart';
import '../services/bottomSheetServices.dart';
import '../services/distanceFormatter.dart';
import '../services/loctionService.dart';
import '../services/userRouteService.dart';
import '../utilities/duration_formatter.dart';
import '../widgets/ExpandablePanel.dart';
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/dialogs/stopRoutedialog.dart';
import '../widgets/wayPointBottomSheet.dart';

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

    // Optionally center the map on the user's current location
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
    // Watch the UserRoute from the userRouteService
    final currentUserRoute = ref.watch(userRouteServiceProvider);
    // Read the userRouteService to get the currentPosition and baseRoute
    final userRouteService = ref.read(userRouteServiceProvider.notifier);
    final currentPosition = userRouteService.currentPosition;
    final baseRoute = userRouteService.baseRoute;

    // Prepare the "committed" polyline from route points
    final committedPoints = userRouteService.committedPoints;

    return Stack(
      children: [
        _buildFlutterMap(committedPoints, currentPosition, baseRoute),
        if (currentUserRoute == null) _buildStartRouteButton(),
        if (currentUserRoute != null) _buildActiveRouteDetails(context, currentUserRoute, baseRoute, currentPosition),
      ],
    );
  }

  Widget _buildFlutterMap(List<app_models.GeoPoint> committedPoints, Position? userPos, app_models.Route? baseRoute) {
    // Convert GeoPoints to LatLng
    final polylinePoints =
        committedPoints.map((gp) => gp.toLatLng()).toList();

    // Current user location marker
    Marker? currentMarker;
    if (userPos != null) {
      currentMarker = Marker(
        point: LatLng(userPos.latitude, userPos.longitude),
        child: const Icon(Icons.location_pin, color: Colors.red),
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
            ..._buildWaypointMarkers(baseRoute?.pointsOfInterest),
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

    // Determine user's current location (or last known)
    final location = await LocationService.getCurrentLocation();
    if (location == null) return;

    final userRouteService = ref.read(userRouteServiceProvider.notifier);

    // Start a new route with that routeType
    userRouteService.startNewRoute(
      routeType,
      app_models.GeoPoint(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
  }
 
  /// Stop the route
  Future<void> _onStopRoutePressed(BuildContext context) async {
    final shouldStop = await showStopDialog(context);
    if (shouldStop == true) {
      // After stopping, you could navigate to the route-saving screen, etc.
      final userRouteService = ref.read(userRouteServiceProvider.notifier);
      await userRouteService.stopUserRoute();

      Navigator.of(context).pushNamed(
        Routes.saveRoute,
        arguments: {'Route': userRouteService.baseRoute, 'UserRoute': ref.read(userRouteServiceProvider)},
      );
    }
  }

  List<Marker> _buildWaypointMarkers(Iterable<app_models.PointOfInterest>? waypoints) {
    if (waypoints == null) return [];
    
    return waypoints.map((waypoint) => Marker(
      point: waypoint.location!.toLatLng(),
      width: 40,
      height: 40,
      child: Icon(
        _getWaypointIcon(waypoint.waypointType!),
        color: Colors.blue,
      ),
    )).toList();
  }

  IconData _getWaypointIcon(WaypointType type) {
    switch (WaypointTypeExtension.getCategory(type)) {
      case WaypointCategory.Natural:
        return Icons.nature;
      case WaypointCategory.Informative:
        return Icons.info;
      case WaypointCategory.Warning:
        return Icons.warning;
      default:
        return Icons.location_on;
    }
  }

  @override
  void dispose() {
    _locationUpdatesSubscription?.cancel();
    super.dispose();
  }
 
  Widget _buildActiveRouteDetails(BuildContext context, app_models.UserRoute currentUserRoute, app_models.Route? baseRoute, Position? currentPosition) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildRouteActionButtons(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMainDetails(currentUserRoute, baseRoute, currentPosition),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainDetails(app_models.UserRoute currentUserRoute, app_models.Route? baseRoute, Position? currentPosition) {
    final userRouteService = ref.read(userRouteServiceProvider.notifier);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailColumn(
          icon: Icons.speed,
          title: 'Speed',
          value: '${currentPosition?.speed?.toStringAsFixed(0) ?? 'N/A'} km/h',
        ),
        _buildDetailColumn(
          icon: Icons.terrain,
          title: 'Elevation',
          value: '${currentPosition?.altitude?.toStringAsFixed(0) ?? 'N/A'} m',
        ),
        _buildDetailColumn(
          icon: Icons.timer,
          title: 'Duration',
          value: DurationFormatter.formatDuration(userRouteService.routeDuration),
        ),
        _buildDetailColumn(
          icon: Icons.alt_route,
          title: 'Distance',
          value: DistanceFormatter.formatDistance(userRouteService.distance),
        ),
      ],
    );
  }

  Widget _buildDetailColumn({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[700]),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey[700])),
        Text(value, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }
  
  Widget _buildRouteActionButtons() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.add_location, color: Colors.black),
            onPressed: () {
              BottomSheetService.showLargeBottomSheet(
                context: context,
                content: WayPointBottomSheet(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Implement share route
            },
          ),
          IconButton(
            icon: const Icon(Icons.pause, color: Colors.black),
            onPressed: () => _onStopRoutePressed(context),
          ),
        ],
      ),
    );
  }
}
