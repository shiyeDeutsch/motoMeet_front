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
import '../services/bottomSheetServices.dart';
import '../services/distanceFormatter.dart';
import '../services/loctionService.dart';
import '../services/routeService.dart';  // The new, refactored RouteService
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
        if (currentRoute?.isActive ?? false) _buildActiveRouteDetails(context, currentRoute,currentPosition),
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
            // Add any other Markers you might have
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

  @override
  void dispose() {
    _locationUpdatesSubscription?.cancel();
    super.dispose();
  }


  Widget _buildActiveRouteDetails(BuildContext context, NewRoute? currentRoute,Position ?currentPosition) {
    // Only show if there's an active route
    if (!(currentRoute?.isActive ?? false)) {
      return const SizedBox.shrink();
    }

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
                  //  _buildDraggableHandle(),
                    _buildMainDetails(currentRoute, currentPosition),
                 //   _buildExpandedDetailsContainer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainDetails(NewRoute? currentRoute,Position ?currentPosition) {
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
          value: '${currentPosition?.altitude ?? 'N/A'} m',
        ),
        _buildDetailColumn(
          icon: Icons.timer,
          title: 'Duration',
          value: DurationFormatter.formatDuration(currentRoute!.routeDuration),
        ),
        _buildDetailColumn(
          icon: Icons.alt_route,
          title: 'Distance',
          value: DistanceFormatter.formatDistance(currentRoute!.length),
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
      child: ExpandablePanel(
        isOpen: true,
        alignment: Alignment.topRight,
        buttons: [
          IconButton(
            icon: const Icon(Icons.add_location, color: Colors.black),
            onPressed: () {
              BottomSheetService.showLargeBottomSheet(
                context: context,
                content:   WayPointBottomSheet(),
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
