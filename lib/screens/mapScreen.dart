import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import '../models/route.dart' as app_models;
import '../models/enum.dart';
import '../providers/route_creation_provider.dart';
import '../routing/routes.dart';
import '../services/bottomSheetServices.dart';
import '../services/distanceFormatter.dart';
import '../services/loctionService.dart';
import '../services/userRouteService.dart';
import '../utilities/duration_formatter.dart';
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/dialogs/stopRoutedialog.dart';
import '../widgets/wayPointBottomSheet.dart';
// Import the newly created widgets
import '../widgets/mapbox_widget.dart';
import '../widgets/map_controls_widget.dart';
import '../widgets/start_route_button.dart';
import '../widgets/active_route_details.dart';
import '../widgets/map_layers_bottom_sheet.dart';

// You'll need to get a Mapbox access token from https://account.mapbox.com/
const String MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoiam9zaGRldXRzY2giLCJhIjoiY204Ymt4bDFhMWh1aTJsczVzNDNlcTRpbSJ9.dzh1waA8zdT90jwmyOzpiQ';
const String MAPBOX_STYLE = 'mapbox://styles/mapbox/outdoors-v12';

class MapMarkerScreen extends ConsumerStatefulWidget {
  const MapMarkerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapMarkerScreen> createState() => _MapMarkerScreenState();
}

class _MapMarkerScreenState extends ConsumerState<MapMarkerScreen>
    with TickerProviderStateMixin {
  MapboxMapController? _mapController;
  bool _isMapInitialized = false;
  bool _isStyleLoaded = false;
  Symbol? _userLocationSymbol;

  // Animation controllers
  late AnimationController _pulseController;

  // UI state
  bool _isBottomSheetVisible = true;
  double _bottomSheetHeight = 120.0;

  @override
  void initState() {
    super.initState();

    // Setup pulse animation for user location
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  // Flag to track if we're following user location
  bool _isTrackingUser = true;

  @override
  Widget build(BuildContext context) {
    // Watch the UserRoute from the userRouteService
    final currentUserRoute = ref.watch(routeCreationProvider);
    // Read the userRouteService to get the currentPosition and baseRoute
    final userRouteService = ref.read(routeCreationProvider.notifier);
    final currentPosition = userRouteService.currentPosition;
    final baseRoute = userRouteService.baseRoute;

    // Prepare the "committed" polyline from route points
    final committedPoints = userRouteService.committedPoints;

    return Scaffold(
      body: Stack(
        children: [
          // Use the extracted MapboxWidget
          MapboxWidget(
            committedPoints: committedPoints,
            userPos: currentPosition,
            baseRoute: baseRoute,
            onMapCreated: _onMapCreated,
            onStyleLoaded: _onStyleLoaded,
            onMapClick: (point, coordinates) {
              // Deselect tracking when user interacts with the map
              setState(() {
                _isTrackingUser = false;
              });
            },
          ),

          // Use the extracted MapControlsWidget
          MapControlsWidget(
            onCenterLocationPressed: () {
              _centerOnUserLocation();
            },
            onLayersPressed: _toggleMapLayers,
            onToggleBottomSheetPressed: _toggleBottomSheet,
            isBottomSheetVisible: _isBottomSheetVisible,
          ),

          // Use the extracted StartRouteButton
          if (currentUserRoute == null)
            StartRouteButton(onPressed: _onPressStartRoute),

          // Use the extracted ActiveRouteDetails
          if (currentUserRoute != null)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: _isBottomSheetVisible ? 0 : -_bottomSheetHeight,
              left: 0,
              right: 0,
              child: ActiveRouteDetails(
                context: context,
                currentUserRoute: currentUserRoute,
                baseRoute: baseRoute,
                currentPosition: currentPosition,
                onStopPressed: () => _onStopRoutePressed(context),
              ),
            ),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    setState(() {
      _isMapInitialized = true;
    });

    // Center map on user's location once we have it
    _centerOnUserLocation();
  }

  void _onStyleLoaded() {
    setState(() {
      _isStyleLoaded = true;
    });

    // Add route line and waypoints once style is loaded
    _updateMapFeatures();

    // Update user location on map if available
    final userPosition =
        ref.read(routeCreationProvider.notifier).currentPosition;
    if (userPosition != null) {
      _updateUserLocationOnMap(userPosition);
    }
  }

  Future<void> _centerOnUserLocation() async {
    try {
      final latLng = await LocationService.getCurrentLocation();
      if (latLng != null && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(latLng.latitude, latLng.longitude),
              zoom: 15.0,
              bearing: 0.0,
              tilt: 0.0,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error centering on user location: $e');
    }
    // Re-enable tracking
    setState(() {
      _isTrackingUser = true;
    });
  }

  void _updateMapFeatures() {
    if (!_isMapInitialized || !_isStyleLoaded || _mapController == null) return;

    final userRouteService = ref.read(routeCreationProvider.notifier);
    final committedPoints = userRouteService.committedPoints;
    final baseRoute = userRouteService.baseRoute;

    // Clear existing route lines
    _mapController!.clearLines();

    // Add route line if we have points
    if (committedPoints.isNotEmpty) {
      _addRouteLine(committedPoints);
    }

    // Add waypoint markers
    if (baseRoute?.pointsOfInterest != null) {
      _addWaypointMarkers(baseRoute!.pointsOfInterest);
    }

    // Update user location on map
    final userPosition = userRouteService.currentPosition;
      
    if (userPosition != null) {
      _updateUserLocationOnMap(userPosition);
    } else {
      // If userPosition is null, try to get it from LocationService
      LocationService.getCurrentLocation().then((latLng) {
        if (latLng != null && mounted) {
          final position = Position(
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          );
          _updateUserLocationOnMap(position);
        }
      }).catchError((error) {
        print('Error getting user location: $error');
      });
    }
  }

  void _updateUserLocationOnMap(Position position) async {
    if (_mapController == null || !_isStyleLoaded) return;

    final latLng = LatLng(position.latitude, position.longitude);

    // Check for location permissions first
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission required for tracking')),
        );
        return;
      }
    }

    // Remove previous symbol if exists
    if (_userLocationSymbol != null) {
      await _mapController!.removeSymbol(_userLocationSymbol!);
    }

    // Add new user location symbol
    try {
      _userLocationSymbol = await _mapController!.addSymbol(
        SymbolOptions(
          geometry: latLng,
          iconSize: 1.0,
          iconImage: "marker-15", // Use a built-in Mapbox icon
          iconColor: "#3E6C51", // Green color
        ),
      );

      // If we're tracking the user, update camera
      if (_isTrackingUser) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
      }
    } catch (e) {
      print('Error updating user location on map: $e');
    }
  }

  void _addRouteLine(List<app_models.GeoPoint> points) {
    if (points.length < 2 || _mapController == null) return;

    final List<LatLng> linePoints = points
        .map((point) => LatLng(point.latitude!, point.longitude!))
        .toList();

    _mapController!.addLine(
      LineOptions(
        geometry: linePoints,
        lineColor: "#3E6C51", // Forest green from the adventure theme
        lineWidth: 5.0,
        lineOpacity: 0.8,
        lineJoin: "round",
      ),
    );
  }

  Future<void> _addWaypointMarkers(
      Iterable<app_models.PointOfInterest> waypoints) async {
    if (_mapController == null) return;

    for (final waypoint in waypoints) {
      if (waypoint.location == null) continue;

      final iconImage = _getWaypointIconImage(waypoint.waypointType!);

      await _mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(
              waypoint.location!.latitude!, waypoint.location!.longitude!),
          iconImage: iconImage,
          iconSize: 1.2,
          textField: waypoint.name,
          textOffset: const Offset(0, 1.5),
          textColor: "#000000",
          textHaloColor: "#FFFFFF",
          textHaloWidth: 1.0,
        ),
      );
    }
  }

  String _getWaypointIconImage(WaypointType type) {
    // Use built-in Mapbox icons instead of custom ones to avoid resource issues
    switch (WaypointTypeExtension.getCategory(type)) {
      case WaypointCategory.Natural:
        return "mountain-15";
      case WaypointCategory.Informative:
        return "information-15";
      case WaypointCategory.Warning:
        return "danger-15";
      default:
        return "marker-15";
    }
  }

  void _toggleMapLayers() {
    // Show a modal bottom sheet with map style options using the new widget
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MapLayersBottomSheet(
        onMapStyleSelected: (styleString) {
          if (_mapController != null) {
            // Store current camera position
            final cameraPosition = _mapController!.cameraPosition;

            // Update map style
           // _mapController!.setStyleString(styleString);

            // After style changes, we need to reinitialize some state
            setState(() {
              _isStyleLoaded = false;
            });

            // Restore camera position after style is loaded
            if (cameraPosition != null) {
              _mapController!.animateCamera(
                CameraUpdate.newCameraPosition(cameraPosition),
              );
            }
          }
        },
      ),
    );
  }

  void _toggleBottomSheet() {
    setState(() {
      _isBottomSheetVisible = !_isBottomSheetVisible;
    });
  }

  /// Start a new route
  Future<void> _onPressStartRoute() async {
    // Show the choose route type dialog
    final routeType = await showRouteTypeEnumDialog(context);
    if (routeType == null) return;

    final userRouteService = ref.read(routeCreationProvider.notifier);
    final userPosition = userRouteService.currentPosition;

    // If we don't have current position from UserRouteService, try with LocationService
    if (userPosition == null) {
      try {
        final latLng = await LocationService.getCurrentLocation();
        if (latLng == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not determine your location')),
          );
          return;
        }

        // Start a new route with the current location
        userRouteService.startNewRoute(
          routeType,
          app_models.GeoPoint(
            latitude: latLng.latitude,
            longitude: latLng.longitude,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not determine your location')),
        );
        return;
      }
    } else {
      // Start a new route with the current position from UserRouteService
      userRouteService.startNewRoute(
        routeType,
        app_models.GeoPoint(
          latitude: userPosition.latitude,
          longitude: userPosition.longitude,
        ),
      );
    }

    // Update map features to show the initial point
    _updateMapFeatures();

    // Ensure we're tracking the user
    setState(() {
      _isTrackingUser = true;
    });
  }

  /// Stop the route
  Future<void> _onStopRoutePressed(BuildContext context) async {
    final shouldStop = await showStopDialog(context);
    if (shouldStop == true) {
      // Stop the route in the service
      final userRouteService = ref.read(routeCreationProvider.notifier);
      await userRouteService.stopUserRoute();

      // Store references to route and userRoute before navigation
      final baseRoute = userRouteService.baseRoute;
      final userRoute = ref.read(routeCreationProvider);

      // Navigate to save screen
      Navigator.of(context).pushNamed(
        Routes.saveRoute,
        arguments: {'Route': baseRoute, 'UserRoute': userRoute},
      );
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}
