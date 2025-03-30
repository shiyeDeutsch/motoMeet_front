import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../models/route.dart' as app_models;
import 'package:geolocator/geolocator.dart';
import '../controllers/map_controller.dart';
import '../constants/app_constants.dart';

class MapboxWidget extends StatefulWidget {
  // Renamed for clarity: userRoutePoints represents the path the user has actually traveled.
  final List<app_models.GeoPoint> userRoutePoints;
  final Position? userPos;
  final app_models.Route? baseRoute; // The predefined base route to display
  final Function(MapboxMapControllerWrapper) onMapInitialized;
  final Function(dynamic, LatLng) onMapClick;
  final String styleString;

  const MapboxWidget({
    Key? key,
    required this.userRoutePoints, // Updated parameter name
    this.userPos,
    this.baseRoute,
    required this.onMapInitialized,
    required this.onMapClick,
    required this.styleString,
  }) : super(key: key);

  @override
  State<MapboxWidget> createState() => _MapboxWidgetState();
}

class _MapboxWidgetState extends State<MapboxWidget> {
  MapboxMapControllerWrapper? _controllerWrapper;
  bool _isStyleLoaded = false;
  
  // Keep track of the last user position to avoid unnecessary updates
  Position? _lastProcessedPosition;
  
  // Keep track of user route points count to detect changes
  int _lastUserRoutePointsCount = 0;
  // Keep track of base route to detect changes
  app_models.Route? _lastProcessedBaseRoute;

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: MapboxConfig.ACCESS_TOKEN,
      styleString: widget.styleString,
      initialCameraPosition: CameraPosition(
        target: widget.userPos != null 
            ? LatLng(widget.userPos!.latitude, widget.userPos!.longitude) 
            : const LatLng(0, 0), // Will be updated once we get user location
        zoom: MapConfig.DEFAULT_ZOOM,
      ),
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoaded,
      // Disable built-in location tracking to avoid crashes
      myLocationEnabled: false,
      myLocationTrackingMode: MyLocationTrackingMode.None,
      myLocationRenderMode: MyLocationRenderMode.NORMAL,
      compassEnabled: true,
      compassViewPosition: CompassViewPosition.TopRight,
      attributionButtonPosition: AttributionButtonPosition.BottomLeft,
      onMapClick: widget.onMapClick,
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    _controllerWrapper = MapboxMapControllerWrapper(controller);
    widget.onMapInitialized(_controllerWrapper!);
  }

  void _onStyleLoaded() {
    setState(() {
      _isStyleLoaded = true;
    });
    
    if (_controllerWrapper != null) {
      _controllerWrapper!.onStyleLoaded();
      
      // Draw initial map features
      _drawInitialMapFeatures();
    }
  }
  
  // Called only when the style is loaded initially
  void _drawInitialMapFeatures() {
    if (_controllerWrapper == null || !_isStyleLoaded) return;
    
    // Draw the base route path (if provided)
    if (widget.baseRoute?.routePoints != null) {
      // Convert List<RoutePoint> to List<GeoPoint>
      final basePointsGeo = widget.baseRoute!.routePoints
          .map((rp) => app_models.GeoPoint(latitude: rp.point!.latitude, longitude: rp.point!.longitude)) // Assuming RoutePoint structure
          .toList();
      _controllerWrapper!.setBaseRoutePath(basePointsGeo);
      _lastProcessedBaseRoute = widget.baseRoute; // Track that we processed this base route
    }
    
    // Draw the initial user traveled path (if any points exist already)
    if (widget.userRoutePoints.isNotEmpty) {
      _controllerWrapper!.setUserRoutePath(widget.userRoutePoints);
      _lastUserRoutePointsCount = widget.userRoutePoints.length;
    }
    
    // Add waypoint markers (if provided)
    if (widget.baseRoute?.pointsOfInterest != null) {
      final waypoints = widget.baseRoute!.pointsOfInterest.toList();
      _controllerWrapper!.setWaypoints(waypoints);
    }
    
    // Update user location marker
    if (widget.userPos != null) {
      _controllerWrapper!.updateUserLocation(widget.userPos!);
      _lastProcessedPosition = widget.userPos;
    }
  }
  
  @override
  void didUpdateWidget(MapboxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Only process updates if the style is loaded and controller exists
    if (_controllerWrapper == null || !_isStyleLoaded) return;
      
    // Check and update USER'S TRAVELED PATH (dynamic)
    if (widget.userRoutePoints.length != _lastUserRoutePointsCount) {
      _controllerWrapper!.setUserRoutePath(widget.userRoutePoints); // Use setUserRoutePath
      _lastUserRoutePointsCount = widget.userRoutePoints.length;
    }
    
    // Check and update the BASE ROUTE PATH (static, only if baseRoute changed)
    if (widget.baseRoute != _lastProcessedBaseRoute) {
      // Pass route points or null if baseRoute is null or has no points
      // Convert List<RoutePoint> to List<GeoPoint>?
      final basePointsGeo = widget.baseRoute?.routePoints
          .map((rp) => app_models.GeoPoint(latitude: rp.point!.latitude, longitude: rp.point!.longitude)) // Assuming RoutePoint structure
          .toList(); 
      _controllerWrapper!.setBaseRoutePath(basePointsGeo); 
      _lastProcessedBaseRoute = widget.baseRoute;

      // Update waypoints if base route changed
      if (widget.baseRoute?.pointsOfInterest != null) {
        final waypoints = widget.baseRoute!.pointsOfInterest.toList();
        _controllerWrapper!.setWaypoints(waypoints);
      } else {
        // Clear waypoints if the new base route has none
        _controllerWrapper!.setWaypoints([]);
      }
    }

    // Only update user location marker if it has changed significantly
    if (widget.userPos != null && 
        (_lastProcessedPosition == null || 
         _hasPositionChangedSignificantly(widget.userPos!, _lastProcessedPosition!))) {
      _controllerWrapper!.updateUserLocation(widget.userPos!);
      _lastProcessedPosition = widget.userPos;
    }
    
    // Handle style changes
    if (widget.styleString != oldWidget.styleString) {
      setState(() {
        _isStyleLoaded = false;
        _lastProcessedBaseRoute = null; // Reset processed base route on style change
      });
      // Style will be updated by the MapboxMap widget itself
      // The onStyleLoadedCallback will be called again, triggering _drawInitialMapFeatures
    }
  }
  
  // Helper method to avoid unnecessary position updates
  // Only update if position has changed by at least 1 meter
  bool _hasPositionChangedSignificantly(Position newPos, Position oldPos) {
    const minDistanceThreshold = 1.0; // 1 meter
    
    final distance = Geolocator.distanceBetween(
      newPos.latitude, 
      newPos.longitude, 
      oldPos.latitude, 
      oldPos.longitude
    );
    
    return distance >= minDistanceThreshold;
  }
}