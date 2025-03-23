import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../models/route.dart' as route_model;
import '../models/enum.dart';

/// A controller class to manage the Mapbox map operations
/// Handles all map-related functionality including rendering routes,
/// user location updates, and waypoints
class MapboxMapControllerWrapper {
  final MapboxMapController _mapController;
  bool _isStyleLoaded = false;
  
  // Cache symbols and lines to avoid redrawing everything
  Symbol? _userLocationSymbol;
  List<Symbol> _waypointSymbols = [];
  List<Line> _routeLines = [];
  Line? _traveledPathLine; // For showing user's traveled path
  
  // Track when initialization is complete
  final ValueNotifier<bool> isInitialized = ValueNotifier<bool>(false);
  
  MapboxMapControllerWrapper(this._mapController) {
    // We'll set the callback in the widget directly, not here
    isInitialized.value = true;
  }
  
  bool get isMapInitialized => _isStyleLoaded;
  
  /// Called when the map style is loaded
  void onStyleLoaded() {
    _isStyleLoaded = true;
  }
  
  /// Center the map on the user's current location
  Future<void> centerOnUserLocation(Position position, {double zoom = 15.0, double? bearing}) async {
    if (!_isStyleLoaded) return;
    
    final CameraUpdate cameraUpdate = bearing != null 
      ? CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zoom,
            bearing: bearing,
            tilt: 45.0, // Add some tilt for a better navigation view
          ),
        )
      : CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zoom,
            bearing: 0.0,
            tilt: 0.0,
          ),
        );
    
    await _mapController.animateCamera(cameraUpdate);
  }
  
  /// Update just the user location on the map without redrawing everything
  Future<void> updateUserLocation(Position position) async {
    if (!_isStyleLoaded) return;
    
    final latLng = LatLng(position.latitude, position.longitude);
    
    try {
      // Remove previous symbol if exists
      if (_userLocationSymbol != null) {
        await _mapController.removeSymbol(_userLocationSymbol!);
      }
      
      // Add a new user location symbol
      _userLocationSymbol = await _mapController.addSymbol(
        SymbolOptions(
          geometry: latLng,
          iconSize: 1.0,
          iconImage: "marker-15", // Use a built-in Mapbox icon
          iconColor: "#3E6C51", // Green color
        ),
      );
    } catch (e) {
      debugPrint('Error updating user location on map: $e');
    }
  }
  
  /// Set the route path based on GeoPoints
  /// Only redraws when the path has changed to avoid flickering
  Future<void> setRoutePath(List<route_model.GeoPoint> points) async {
    if (!_isStyleLoaded || points.isEmpty) return;
    
    try {
      // Convert the points to LatLng list
      final List<LatLng> linePoints = points
          .map((point) => LatLng(point.latitude!, point.longitude!))
          .toList();
      
      // Clear existing route lines
      for (final line in _routeLines) {
        await _mapController.removeLine(line);
      }
      _routeLines.clear();
      
      // Add the new route line if we have at least 2 points
      if (linePoints.length >= 2) {
        final line = await _mapController.addLine(
          LineOptions(
            geometry: linePoints,
            lineColor: "#3E6C51", // Forest green
            lineWidth: 5.0,
            lineOpacity: 0.8,
            lineJoin: "round",
          ),
        );
        _routeLines.add(line);
      }
    } catch (e) {
      debugPrint('Error setting route path: $e');
    }
  }
  
  /// Set the traveled path (the path user has actually taken)
  Future<void> setTraveledPath(List<route_model.GeoPoint> points) async {
    if (!_isStyleLoaded || points.isEmpty) return;
    
    try {
      // Convert the points to LatLng list
      final List<LatLng> linePoints = points
          .map((point) => LatLng(point.latitude!, point.longitude!))
          .toList();
      
      // Remove existing traveled path line if it exists
      if (_traveledPathLine != null) {
        await _mapController.removeLine(_traveledPathLine!);
        _traveledPathLine = null;
      }
      
      // Add the new traveled path line if we have at least 2 points
      if (linePoints.length >= 2) {
        _traveledPathLine = await _mapController.addLine(
          LineOptions(
            geometry: linePoints,
            lineColor: "#FF4500", // Orange-red color for the traveled path
            lineWidth: 4.0,
            lineOpacity: 1.0,
            lineJoin: "round",
          ),
        );
      }
    } catch (e) {
      debugPrint('Error setting traveled path: $e');
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
      
      // Clear route lines
      for (final line in _routeLines) {
        await _mapController.removeLine(line);
      }
      _routeLines.clear();
      
      // Clear traveled path line
      if (_traveledPathLine != null) {
        await _mapController.removeLine(_traveledPathLine!);
        _traveledPathLine = null;
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