import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get_it/get_it.dart';
import '../models/route.dart' as route_model;
import 'map_controller.dart';
import '../constants/app_constants.dart';
import '../services/locationService.dart';

/// Enum for various navigation events
enum NavigationEvent {
  navigationStarted,
  navigationStopped,
  positionUpdated,
  offRoute,
  approachingWaypoint,
  arrivedAtDestination,
}

/// A controller to handle real-time navigation features
/// Manages dynamic zoom based on speed, camera tracking, and path visualization
class NavigationController {
  // Reference to the map controller
  final MapboxMapControllerWrapper _mapController;
  
  // Location service from GetIt
  final LocationService _locationService = GetIt.I<LocationService>();
  
  // Navigation state
  bool _isNavigating = false;
  bool _isTrackingUser = true;
  
  // Timer for updating the camera based on user movement
  Timer? _cameraUpdateTimer;
  
  // List to store the traveled path during navigation
  final List<route_model.GeoPoint> _traveledPath = [];
  
  // Speeds and zoom levels (in meters per second)
  // Map speed ranges to appropriate zoom levels
  final Map<double, double> _speedZoomLevels = {
    SpeedThresholds.STATIONARY: 18.0,      // Stationary: very close zoom
    SpeedThresholds.WALKING: 17.0,         // Walking: close zoom
    SpeedThresholds.RUNNING: 16.0,         // Running/slow biking: medium-close zoom
    SpeedThresholds.BIKING: 15.0,          // Biking: medium zoom
    SpeedThresholds.SLOW_DRIVING: 14.0,    // Slow driving: medium-far zoom
    SpeedThresholds.MEDIUM_DRIVING: 13.0,  // Medium driving: far zoom
    SpeedThresholds.FAST_DRIVING: 12.0,    // Fast driving: very far zoom
  };
  
  // The route that is being followed, if any
  List<route_model.GeoPoint>? _currentRoute;
  
  // Stream controller for navigation events
  final _navigationEventController = StreamController<NavigationEvent>.broadcast();
  Stream<NavigationEvent> get navigationEvents => _navigationEventController.stream;
  
  // Subscription to location updates
  StreamSubscription<Position>? _locationSubscription;
  
  NavigationController(this._mapController) {
    // Configure location service for navigation (more frequent updates)
    _locationService.configure(
      accuracy: LocationAccuracy.high,
      updateIntervalMs: 1000, // 1 second updates during navigation
    );
  }
  
  /// Start navigation with optional route to follow
  Future<void> startNavigation({List<route_model.GeoPoint>? route}) async {
    if (_isNavigating) return;
    
    _isNavigating = true;
    _isTrackingUser = true;
    _currentRoute = route;
    _traveledPath.clear();
    
    // Ensure location service is active
    if (!_locationService.isListening) {
      await _locationService.startListening();
    }
    
    // Start listening to location updates
    _locationSubscription = _locationService.locationUpdates.listen(_onLocationUpdate);
    
    // Start periodic camera updates
    _startCameraUpdates();
    
    // Notify listeners
    _navigationEventController.add(NavigationEvent.navigationStarted);
  }
  
  /// Process incoming location updates
  void _onLocationUpdate(Position position) {
    // Only process updates if we're navigating
    if (!_isNavigating) return;
    
    // Add to traveled path - only if we've moved a significant distance
    if (_traveledPath.isEmpty || _calculateDistance(_traveledPath.last, position) > 2.0) {
      _traveledPath.add(route_model.GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
        altitude: position.altitude,
      ));
      
      // Update the traveled path line on the map
      _mapController.setTraveledPath(_traveledPath);
      
      // Notify about position update
      _navigationEventController.add(NavigationEvent.positionUpdated);
    }
  }
  
  /// Stop the current navigation session
  Future<void> stopNavigation() async {
    if (!_isNavigating) return;
    
    _isNavigating = false;
    
    // Stop location updates
    _locationSubscription?.cancel();
    _locationSubscription = null;
    
    // Return location service to normal update frequency
    _locationService.configure(updateIntervalMs: 5000); // 5 seconds in normal mode
    
    _stopCameraUpdates();
    
    // Notify listeners
    _navigationEventController.add(NavigationEvent.navigationStopped);
  }
  
  /// Toggle user tracking
  void toggleTracking(bool isTracking) {
    _isTrackingUser = isTracking;
  }
  
  /// Start periodic camera updates based on user location
  void _startCameraUpdates() {
    _cameraUpdateTimer?.cancel();
    _cameraUpdateTimer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      _updateCameraPosition();
    });
  }
  
  /// Stop camera updates
  void _stopCameraUpdates() {
    _cameraUpdateTimer?.cancel();
    _cameraUpdateTimer = null;
  }
  
  /// Update the camera position based on current location and speed
  Future<void> _updateCameraPosition() async {
    if (!_isNavigating || !_isTrackingUser || !_mapController.isMapInitialized) {
      return;
    }

    try {
      // Get current position from location service instead of direct Geolocator call
      final position = await _locationService.getCurrentPosition(
        useCacheIfAvailable: true,
        maxCacheAgeSeconds: 2,
        timeout: const Duration(seconds: 2),
      );
      
      // Calculate appropriate zoom level based on speed
      final double speed = position.speed; // in meters per second
      final double zoomLevel = _calculateZoomLevel(speed);
      
      // Update camera position with appropriate zoom
      await _mapController.centerOnUserLocation(
        position,
        zoom: zoomLevel,
        bearing: position.heading,
      );
      
    } catch (e) {
      debugPrint('Error updating camera position: $e');
    }
  }
  
  /// Calculate the appropriate zoom level based on speed
  double _calculateZoomLevel(double speedMps) {
    // Find the closest speed bracket
    double zoom = _speedZoomLevels[SpeedThresholds.STATIONARY]!; // Default zoom level (stationary)
    
    // Find the appropriate zoom level for this speed
    for (final entry in _speedZoomLevels.entries) {
      if (speedMps >= entry.key) {
        zoom = entry.value;
      } else {
        break; // Stop once we've found the right bracket
      }
    }
    
    return zoom;
  }
  
  /// Calculate distance between a GeoPoint and a Position in meters
  double _calculateDistance(route_model.GeoPoint point, Position position) {
    return Geolocator.distanceBetween(
      point.latitude!,
      point.longitude!,
      position.latitude,
      position.longitude,
    );
  }
  
  /// Get the traveled path so far
  List<route_model.GeoPoint> get traveledPath => List.unmodifiable(_traveledPath);
  
  /// Dispose resources
  void dispose() {
    _stopCameraUpdates();
    _locationSubscription?.cancel();
    _navigationEventController.close();
  }
} 