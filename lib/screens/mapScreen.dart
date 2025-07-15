import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';

import '../constants/map_utilties.dart';
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
import '../services/map_controller.dart';

enum NavigationState { loading, idle, navigating }

class MapScreen extends ConsumerStatefulWidget {
  final app_models.Route? baseRoute;

  const MapScreen({Key? key, this.baseRoute}) : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen>
    with TickerProviderStateMixin {
  late final MapController _mapController;

  // Navigation state
  NavigationState _navState = NavigationState.loading;

  @override
  void initState() {
    super.initState();
    LocationService.startListening();
    _mapController = MapController(
      onError: _showError,
      onNavStateChanged: (navState) => setState(() => _navState = navState),
      tickerProvider: this,
      ref: ref,
      baseRoute: widget.baseRoute,
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRoute = ref.watch(routeCreationProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userRoute != null) {
        _mapController.displayUserCreatedRoute();
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          _buildMapView(),
          _buildControls(),
          if (userRoute == null && _navState != NavigationState.loading)
            _buildStartRouteButton(),
          if (userRoute != null) _buildActiveRouteDetails(userRoute),
          if (_navState == NavigationState.loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildControls() => MapControlsWidget(
        onBackPressed: () => _handleBackPress(context),
        onCenterLocationPressed: _mapController.centerOnCurrentLocation,
        onLayersPressed: () => _showMapLayersBottomSheet(context),
      );

  Widget _buildStartRouteButton() => StartRouteButton(
        onPressed: () => _startNewRoute(context),
        label: widget.baseRoute != null
            ? 'Start Following Route'
            : 'Start New Route',
      );

  Widget _buildActiveRouteDetails(userRoute) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: StreamBuilder<geo.Position>(
            stream: LocationService.locationUpdates,
            builder: (context, snapshot) {
              //if (snapshot.connectionState == ConnectionState.) {
                final position = snapshot.data;
                return ActiveRouteDetails(
                  currentUserRoute: userRoute,
                  baseRoute: widget.baseRoute,
                  currentPosition: position,
                  onStopPressed: _stopRouteTracking,
                  context: context,
                );
            //  }
          //    return const SizedBox.shrink();
            }),
      );

  Widget _buildMapView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: MapWidget(
        key: const ValueKey("mapWidget"),
        styleUri: _mapController.currentMapStyle,
        onMapCreated: _mapController.onMapCreated,
        onStyleLoadedListener: _mapController.onStyleLoadedCallback,
        cameraOptions: _mapController.initialCameraOptions,
        onScrollListener: (_) => _mapController.onUserMapInteraction(),
      ),
    );
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
        await ref.read(routeCreationProvider.notifier).startExistingRoute(
            widget.baseRoute!, selectedRouteType, startPoint);
      } else {
        await ref
            .read(routeCreationProvider.notifier)
            .startNewRoute(selectedRouteType, startPoint);
      }

      if (!mounted) return;
      setState(() {
        _navState = NavigationState.navigating;
      });

      await _mapController.displayUserCreatedRoute();

      final position = await geo.Geolocator.getCurrentPosition();
      await _mapController.flyToCamera(
        longitude: currentLocation.longitude,
        latitude: currentLocation.latitude,
        zoom: (position.speed > 0)
            ? MapAnimations.ZOOM_MOVING
            : MapAnimations.ZOOM_STATIONARY,
        pitch: MapConfig.NAVIGATION_TILT,
        bearing: position.heading,
        duration: MapAnimations.ANIMATION_DURATION,
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
    BottomSheetService.showSmallBottomSheet(
      context: context,
      content: MapLayersBottomSheet(
        onMapStyleSelected: (style) {
          _mapController.loadStyleURI(style);
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
