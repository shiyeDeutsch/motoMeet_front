import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import '../models/route.dart' as app_models;
import '../models/enum.dart';
import '../routing/routes.dart';
import '../services/bottomSheetServices.dart';
import '../services/distanceFormatter.dart';
import '../services/loctionService.dart';
import '../services/userRouteService.dart';
import '../utilities/duration_formatter.dart';
import '../widgets/dialogs/chooseRouteTypeDialog.dart';
import '../widgets/dialogs/stopRoutedialog.dart';
import '../widgets/wayPointBottomSheet.dart';

// You'll need to get a Mapbox access token from https://account.mapbox.com/
const String MAPBOX_ACCESS_TOKEN = 'pk.eyJ1Ijoiam9zaGRldXRzY2giLCJhIjoiY204Ymt4bDFhMWh1aTJsczVzNDNlcTRpbSJ9.dzh1waA8zdT90jwmyOzpiQ';
const String MAPBOX_STYLE = 'mapbox://styles/mapbox/outdoors-v12';

class MapMarkerScreen extends ConsumerStatefulWidget {
  const MapMarkerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapMarkerScreen> createState() => _MapMarkerScreenState();
}

class _MapMarkerScreenState extends ConsumerState<MapMarkerScreen> with TickerProviderStateMixin {
  MapboxMapController? _mapController;
  StreamSubscription<Position>? _locationUpdatesSubscription;
  bool _isExpanded = false;
  bool _isMapInitialized = false;
  bool _isStyleLoaded = false;
  
  // Animation controllers
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
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
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
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

    return Scaffold(
      body: Stack(
        children: [
          _buildMapbox(committedPoints, currentPosition, baseRoute),
          _buildMapControls(),
          if (currentUserRoute == null) _buildStartRouteButton(),
          if (currentUserRoute != null) 
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: _isBottomSheetVisible ? 0 : -_bottomSheetHeight,
              left: 0,
              right: 0,
              child: _buildActiveRouteDetails(context, currentUserRoute, baseRoute, currentPosition),
            ),
        ],
      ),
    );
  }

  Widget _buildMapbox(List<app_models.GeoPoint> committedPoints, Position? userPos, app_models.Route? baseRoute) {
    return MapboxMap(
      accessToken: MAPBOX_ACCESS_TOKEN,
      styleString: MAPBOX_STYLE,
      initialCameraPosition: const CameraPosition(
        target: LatLng(0, 0), // Will be updated once we get user location
        zoom: 13.0,
      ),
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoaded,
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
      myLocationRenderMode: MyLocationRenderMode.COMPASS,
      compassEnabled: true,
      compassViewPosition: CompassViewPosition.TopRight,
      attributionButtonPosition: AttributionButtonPosition.BottomLeft,
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
  }
  
  void _updateMapFeatures() {
    if (!_isMapInitialized || !_isStyleLoaded || _mapController == null) return;
    
    final userRouteService = ref.read(userRouteServiceProvider.notifier);
    final committedPoints = userRouteService.committedPoints;
    final baseRoute = userRouteService.baseRoute;
    
    // Clear existing route lines and markers
    _mapController!.clearLines();
    _mapController!.clearSymbols();
    
    // Add route line if we have points
    if (committedPoints.isNotEmpty) {
      _addRouteLine(committedPoints);
    }
    
    // Add waypoint markers
    if (baseRoute?.pointsOfInterest != null) {
      _addWaypointMarkers(baseRoute!.pointsOfInterest);
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
  
  Future<void> _addWaypointMarkers(Iterable<app_models.PointOfInterest> waypoints) async {
    if (_mapController == null) return;
    
    for (final waypoint in waypoints) {
      if (waypoint.location == null) continue;
      
      final iconImage = _getWaypointIconImage(waypoint.waypointType!);
      
      await _mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(
            waypoint.location!.latitude!, 
            waypoint.location!.longitude!
          ),
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
    // Note: You'll need to add these icons to your Mapbox style
    // or use built-in Mapbox icons
    switch (WaypointTypeExtension.getCategory(type)) {
      case WaypointCategory.Natural:
        return "mountain";
      case WaypointCategory.Informative:
        return "information";
      case WaypointCategory.Warning:
        return "danger";
      default:
        return "marker";
    }
  }

  Widget _buildMapControls() {
    return Positioned(
      top: 50.0,
      right: 16.0,
      child: Column(
        children: [
          _buildMapControlButton(
            icon: Icons.my_location,
            onPressed: _centerOnUserLocation,
            tooltip: 'Center on my location',
          ),
          const SizedBox(height: 12),
          _buildMapControlButton(
            icon: Icons.layers,
            onPressed: _toggleMapLayers,
            tooltip: 'Map layers',
          ),
          const SizedBox(height: 12),
          _buildMapControlButton(
            icon: _isBottomSheetVisible ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            onPressed: _toggleBottomSheet,
            tooltip: _isBottomSheetVisible ? 'Hide details' : 'Show details',
          ),
        ],
      ),
    );
  }
  
  Widget _buildMapControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: tooltip,
        color: const Color(0xFF3E6C51), // Forest green from adventure theme
      ),
    );
  }
  
  void _toggleMapLayers() {
    // Show a modal bottom sheet with map style options
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildMapLayersSheet(),
    );
  }
  
  Widget _buildMapLayersSheet() {
    final mapStyles = [
      {'name': 'Outdoors', 'style': 'mapbox://styles/mapbox/outdoors-v12'},
      {'name': 'Satellite', 'style': 'mapbox://styles/mapbox/satellite-streets-v12'},
      {'name': 'Navigation', 'style': 'mapbox://styles/mapbox/navigation-day-v1'},
      {'name': 'Dark', 'style': 'mapbox://styles/mapbox/dark-v11'},
    ];
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Map Style',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...mapStyles.map((style) => ListTile(
            title: Text(style['name']!),
            onTap: () {
              if (_mapController != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _mapController!.cameraPosition!.target,
                      zoom: _mapController!.cameraPosition!.zoom,
                    ),
                  ),
                );
              }
              Navigator.pop(context);
            },
            trailing: style['style'] == MAPBOX_STYLE 
                ? const Icon(Icons.check, color: Color(0xFF3E6C51))
                : null,
          )),
        ],
      ),
    );
  }
  
  void _toggleBottomSheet() {
    setState(() {
      _isBottomSheetVisible = !_isBottomSheetVisible;
    });
  }

  Widget _buildStartRouteButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: ElevatedButton(
          onPressed: _onPressStartRoute,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E6C51), // Forest green
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow),
              SizedBox(width: 8),
              Text(
                'Start New Route',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
    
    // Update map features
    _updateMapFeatures();
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

  @override
  void dispose() {
    _locationUpdatesSubscription?.cancel();
    _pulseController.dispose();
    _mapController?.dispose();
    super.dispose();
  }
 
  Widget _buildActiveRouteDetails(BuildContext context, app_models.UserRoute currentUserRoute, app_models.Route? baseRoute, Position? currentPosition) {
    return Container(
      height: _bottomSheetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle for dragging
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailItem(
                    icon: Icons.speed,
                    title: 'Speed',
                    value: '${currentPosition?.speed != null ? (currentPosition!.speed * 3.6).toStringAsFixed(0) : 'N/A'} km/h',
                    color: const Color(0xFF3E6C51),
                  ),
                  _buildDetailItem(
                    icon: Icons.terrain,
                    title: 'Elevation',
                    value: '${currentPosition?.altitude?.toStringAsFixed(0) ?? 'N/A'} m',
                    color: const Color(0xFFD59F33),
                  ),
                  _buildDetailItem(
                    icon: Icons.timer,
                    title: 'Duration',
                    value: DurationFormatter.formatDuration(ref.read(userRouteServiceProvider.notifier).routeDuration),
                    color: const Color(0xFFE76F51),
                  ),
                  _buildDetailItem(
                    icon: Icons.alt_route,
                    title: 'Distance',
                    value: DistanceFormatter.formatDistance(ref.read(userRouteServiceProvider.notifier).distance),
                    color: const Color(0xFF1976D2),
                  ),
                ],
              ),
            ),
          ),
          _buildRouteActionButtons(),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
  
  Widget _buildRouteActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.add_location,
            label: 'Add Waypoint',
            onPressed: () {
              BottomSheetService.showLargeBottomSheet(
                context: context,
                content: WayPointBottomSheet(),
              );
            },
            color: const Color(0xFF3E6C51),
          ),
          _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onPressed: () {
              // Implement share route
            },
            color: const Color(0xFF1976D2),
          ),
          _buildActionButton(
            icon: Icons.stop,
            label: 'Stop',
            onPressed: () => _onStopRoutePressed(context),
            color: const Color(0xFFE76F51),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
