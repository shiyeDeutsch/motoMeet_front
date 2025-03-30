import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../models/route.dart' as route_model;
import '../models/enum.dart';
import '../constants/app_constants.dart';

/// A controller class to manage the Mapbox map operations
/// Handles all map-related functionality including rendering routes,
/// user location updates, and waypoints
class MapboxMapControllerWrapper {
  final MapboxMapController _mapController;
  bool _isStyleLoaded = false;
  
  // Cache symbols and lines to avoid redrawing everything
  Symbol? _userLocationSymbol;
  List<Symbol> _waypointSymbols = [];
  List<Line> _baseRouteLines = [];
  Line? _userRoutePathLine;
  
  // Track when initialization is complete
  final ValueNotifier<bool> isInitialized = ValueNotifier<bool>(false);
  
  MapboxMapControllerWrapper(this._mapController) {
    isInitialized.value = true;
  }
  
  bool get isMapInitialized => _isStyleLoaded;
  
  /// Called when the map style is loaded
  void onStyleLoaded() {
    _isStyleLoaded = true;
  }
  
  /// Center the map on the user's current location
  Future<void> centerOnUserLocation(Position position, {double? zoom, double? bearing}) async {
    if (!_isStyleLoaded) return;
    
    final CameraUpdate cameraUpdate = bearing != null 
      ? CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zoom ?? MapConfig.DEFAULT_ZOOM,
            bearing: bearing,
            tilt: MapConfig.NAVIGATION_TILT, // Add tilt for navigation view
          ),
        )
      : CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zoom ?? MapConfig.DEFAULT_ZOOM,
            bearing: 0.0,
            tilt: MapConfig.DEFAULT_TILT,
          ),
        );
    
    await _mapController.animateCamera(cameraUpdate);
  }
  
  /// Update just the user location on the map without redrawing everything
  Future<void> updateUserLocation(Position position) async {
    if (!_isStyleLoaded) return;
    
    final latLng = LatLng(position.latitude, position.longitude);
    
    try {
      // If the symbol already exists, update its position
      if (_userLocationSymbol != null) {
        await _mapController.updateSymbol(
          _userLocationSymbol!,
          SymbolOptions(
            geometry: latLng,
            // Keep other properties the same or update if needed
            // iconSize: 1.0,
            // iconImage: "marker-15",
            // iconColor: MapConfig.ROUTE_COLOR,
          ),
        );
      } else {
        // Otherwise, add a new user location symbol
        _userLocationSymbol = await _mapController.addSymbol(
          SymbolOptions(
            geometry: latLng,
            iconSize: 1.0,
            iconImage: "marker-15", // Use a built-in Mapbox icon
            iconColor: MapConfig.ROUTE_COLOR,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating user location on map: $e');
    }
  }
  
  /// Set the base route path (e.g., the pre-defined route)
  /// Should ideally be called only once when the route is loaded.
  Future<void> setBaseRoutePath(List<route_model.GeoPoint>? points) async {
    if (!_isStyleLoaded) return;
  
    try {
      // Clear existing base route lines first
      if (_baseRouteLines.isNotEmpty) {
        for (final line in _baseRouteLines) {
          await _mapController.removeLine(line);
        }
        _baseRouteLines.clear();
      }
  
      // If points are null or empty, we're done (cleared the path)
      if (points == null || points.isEmpty) return;
  
      // Convert the points to LatLng list
      final List<LatLng> linePoints = points
          .map((point) => LatLng(point.latitude!, point.longitude!))
          .toList();
  
      // Check if we have enough points to draw a line
      if (linePoints.length >= 2) {
        // Add the new base route line(s)
        // Note: Currently adds only one line. If multiple segments are needed, adjust logic.
        final line = await _mapController.addLine(
          LineOptions(
            geometry: linePoints,
            lineColor: MapConfig.ROUTE_COLOR, // Use the base route color
            lineWidth: MapConfig.ROUTE_WIDTH,
            lineOpacity: MapConfig.ROUTE_OPACITY,
            lineJoin: "round",
          ),
        );
        _baseRouteLines.add(line);
      }
    } catch (e) {
      debugPrint('Error setting base route path: $e');
    }
  }
  
  /// Set the user's traveled path (updates dynamically as user moves)
  Future<void> setUserRoutePath(List<route_model.GeoPoint> points) async {
    if (!_isStyleLoaded || points.isEmpty) return;
  
    try {
      // Convert the points to LatLng list
      final List<LatLng> linePoints = points
          .map((point) => LatLng(point.latitude!, point.longitude!))
          .toList();
  
      // Check if we have enough points to draw a line
      if (linePoints.length >= 2) {
        // If a user route path line already exists, update it
        if (_userRoutePathLine != null) {
          await _mapController.updateLine(
            _userRoutePathLine!,
            LineOptions(geometry: linePoints), // Only update geometry
          );
        } else {
          // Otherwise, add a new user route path line
          _userRoutePathLine = await _mapController.addLine(
            LineOptions(
              geometry: linePoints,
              lineColor: MapConfig.TRAVELED_PATH_COLOR, // Use traveled path color
              lineWidth: MapConfig.TRAVELED_PATH_WIDTH,
              lineOpacity: MapConfig.TRAVELED_PATH_OPACITY,
              lineJoin: "round",
            ),
          );
        }
      } else {
        // If not enough points, clear the existing user route path line
        if (_userRoutePathLine != null) {
          await _mapController.removeLine(_userRoutePathLine!);
          _userRoutePathLine = null;
        }
      }
    } catch (e) {
      debugPrint('Error setting user route path: $e');
    }
  }
  
  /// Update waypoints on the map
  /// Only redraws when the waypoints have changed
  Future<void> setWaypoints(List<route_model.PointOfInterest> waypoints) async {
    if (!_isStyleLoaded) return;
    
    try {
      // Clear existing waypoint symbols
      for (final symbol in _waypointSymbols) {
        await _mapController.removeSymbol(symbol);
      }
      _waypointSymbols.clear();
      
      // Add new waypoint symbols
      for (final waypoint in waypoints) {
        if (waypoint.location == null) continue;
        
        final iconImage = _getWaypointIconImage(waypoint.waypointType!);
        
        final symbol = await _mapController.addSymbol(
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
        _waypointSymbols.add(symbol);
      }
    } catch (e) {
      debugPrint('Error setting waypoints: $e');
    }
  }
  
  /// Helper method to get the appropriate icon for a waypoint type
  String _getWaypointIconImage(WaypointType type) {
    // Use built-in Mapbox icons
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
  
  /// Clear all map elements
  Future<void> clearMap() async {
    if (!_isStyleLoaded) return;
    
    try {
      // Clear user location symbol
      if (_userLocationSymbol != null) {
        await _mapController.removeSymbol(_userLocationSymbol!);
        _userLocationSymbol = null;
      }
      
      // Clear waypoint symbols
      for (final symbol in _waypointSymbols) {
        await _mapController.removeSymbol(symbol);
      }
      _waypointSymbols.clear();
      
      // Clear base route lines
      for (final line in _baseRouteLines) {
        await _mapController.removeLine(line);
      }
      _baseRouteLines.clear();
      
      // Clear user traveled path line
      if (_userRoutePathLine != null) {
        await _mapController.removeLine(_userRoutePathLine!);
        _userRoutePathLine = null;
      }
    } catch (e) {
      debugPrint('Error clearing map: $e');
    }
  }
  
  /// Change the map style - Use styleString directly in the MapboxMap widget instead
  Future<void> setMapStyle(String styleString) async {
    _isStyleLoaded = false;
    // We'll use a different approach for changing the style
    // The styleString should be set directly on the MapboxMap widget
  }
  
  /// Dispose resources
  void dispose() {
    // Nothing to dispose specifically in this wrapper
    // The actual MapboxMapController will be disposed by the widget
  }
} 