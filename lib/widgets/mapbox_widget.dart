import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../models/route.dart' as app_models;
import 'package:geolocator/geolocator.dart';
import '../controllers/map_controller.dart';
import '../constants/app_constants.dart';

class MapboxWidget extends StatefulWidget {
  final List<app_models.GeoPoint> committedPoints;
  final Position? userPos;
  final app_models.Route? baseRoute;
  final Function(MapboxMapControllerWrapper) onMapInitialized;
  final Function(dynamic, LatLng) onMapClick;
  final String styleString;

  const MapboxWidget({
    Key? key,
    required this.committedPoints,
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
  
  // Keep track of committed points count to detect changes
  int _lastCommittedPointsCount = 0;

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
      
      // Update map features if we have data
      _updateMapFeatures();
    }
  }
  
  void _updateMapFeatures() {
    if (_controllerWrapper == null || !_isStyleLoaded) return;
    
    // Update route path if we have points
    if (widget.committedPoints.isNotEmpty) {
      _controllerWrapper!.setRoutePath(widget.committedPoints);
      _lastCommittedPointsCount = widget.committedPoints.length;
    }
    
    // Add waypoint markers if we have them
    if (widget.baseRoute?.pointsOfInterest != null) {
      // Convert IsarLinks to a List before passing
      final waypoints = widget.baseRoute!.pointsOfInterest.toList();
      _controllerWrapper!.setWaypoints(waypoints);
    }
    
    // Update user location
    if (widget.userPos != null) {
      _controllerWrapper!.updateUserLocation(widget.userPos!);
      _lastProcessedPosition = widget.userPos;
    }
  }
  
  @override
  void didUpdateWidget(MapboxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // When widget data changes, update the map
    // Only process updates when we have actual changes
    if (!_isStyleLoaded) return;
      
    // Check and update route points if necessary
    if (widget.committedPoints.length != _lastCommittedPointsCount) {
      if (widget.committedPoints.isNotEmpty) {
        _controllerWrapper?.setRoutePath(widget.committedPoints);
        _lastCommittedPointsCount = widget.committedPoints.length;
      }
    }
    
    // Only update user location if it has changed significantly
    if (widget.userPos != null && 
        (_lastProcessedPosition == null || 
         _hasPositionChangedSignificantly(widget.userPos!, _lastProcessedPosition!))) {
      _controllerWrapper?.updateUserLocation(widget.userPos!);
      _lastProcessedPosition = widget.userPos;
    }
    
    // Check if base route or points of interest have changed
    if (widget.baseRoute != oldWidget.baseRoute || 
        (widget.baseRoute?.pointsOfInterest.length != 
         oldWidget.baseRoute?.pointsOfInterest.length)) {
      if (widget.baseRoute?.pointsOfInterest != null) {
        final waypoints = widget.baseRoute!.pointsOfInterest.toList();
        _controllerWrapper?.setWaypoints(waypoints);
      }
    }
    
    // Handle style changes
    if (widget.styleString != oldWidget.styleString) {
      setState(() {
        _isStyleLoaded = false;
      });
      // Style will be updated by the MapboxMap widget itself
      // The onStyleLoadedCallback will be called again
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