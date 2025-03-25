import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get_it/get_it.dart';
import '../models/route.dart' as route_model;
import '../models/locationShare.dart';
import '../services/location_sharing_service.dart';
import 'map_controller.dart';
import '../constants/app_constants.dart';

/// Enum for various navigation events
enum NavigationEvent {
  navigationStarted,
  navigationStopped,
  positionUpdated,
  offRoute,
  approachingWaypoint,
  arrivedAtDestination,
  locationSharingStarted,
  locationSharingStopped,
  newSharedLocationsReceived,
}

/// A controller to handle real-time navigation features
/// Manages dynamic zoom based on speed, camera tracking, and path visualization
class NavigationController {
  // Reference to the map controller
  final MapboxMapControllerWrapper _mapController;
  
  // Navigation state
  bool _isNavigating = false;
  bool _isTrackingUser = true;
  
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
  
  // Location sharing
  LocationSharingService? _locationSharingService;
  String? _activeSharingSessionId;
  bool _isLocationSharingEnabled = false;
  StreamSubscription? _sharedLocationsSubscription;
  List<SharedLocation> _sharedLocations = [];
  
  NavigationController(this._mapController) {
    // Try to get location sharing service from GetIt if available
    try {
      _locationSharingService = GetIt.I<LocationSharingService>();
      
      // Listen for shared locations
      _sharedLocationsSubscription = _locationSharingService?.sharedLocations.listen((locations) {
        _sharedLocations = locations;
        _navigationEventController.add(NavigationEvent.newSharedLocationsReceived);
      });
    } catch (e) {
      debugPrint('Location sharing service not available: $e');
    }
  }
  
  /// Start navigation with optional route to follow
  void startNavigation({List<route_model.GeoPoint>? route}) {
    if (_isNavigating) return;
    
    _isNavigating = true;
    _isTrackingUser = true;
    _currentRoute = route;
    _traveledPath.clear();
    
    // Notify listeners
    _navigationEventController.add(NavigationEvent.navigationStarted);
  }
  
  /// Process position update from RouteCreationProvider
  void updatePosition(Position position) {
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
      
      // Update camera if tracking is enabled
      if (_isTrackingUser && _mapController.isMapInitialized) {
        _updateCameraPosition(position);
      }
    }
  }
  
  /// Stop the current navigation session
  void stopNavigation() {
    if (!_isNavigating) return;
    
    _isNavigating = false;
    
    // Stop location sharing if it's enabled
    stopLocationSharing();
    
    // Notify listeners
    _navigationEventController.add(NavigationEvent.navigationStopped);
  }
  
  /// Toggle user tracking
  void toggleTracking(bool isTracking) {
    _isTrackingUser = isTracking;
  }
  
  /// Start sharing location with others
  Future<bool> startLocationSharing({String? name, String? routeId}) async {
    if (_locationSharingService == null) {
      debugPrint('Location sharing service not available');
      return false;
    }
    
    try {
      final sessionId = await _locationSharingService!.startSharing(
        name: name,
        routeId: routeId,
        isPublic: true,
      );
      
      if (sessionId != null) {
        _activeSharingSessionId = sessionId;
        _isLocationSharingEnabled = true;
        
        // Notify listeners
        _navigationEventController.add(NavigationEvent.locationSharingStarted);
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error starting location sharing: $e');
      return false;
    }
  }
  
  /// Stop sharing location
  Future<bool> stopLocationSharing() async {
    if (_locationSharingService == null || !_isLocationSharingEnabled) {
      return true;
    }
    
    try {
      final result = await _locationSharingService!.stopSharing();
      
      if (result) {
        _isLocationSharingEnabled = false;
        _activeSharingSessionId = null;
        _sharedLocations = [];
        
        // Notify listeners
        _navigationEventController.add(NavigationEvent.locationSharingStopped);
      }
      
      return result;
    } catch (e) {
      debugPrint('Error stopping location sharing: $e');
      return false;
    }
  }
  
  /// Join an existing location sharing session
  Future<bool> joinLocationSharingSession(String sessionId) async {
    if (_locationSharingService == null) {
      debugPrint('Location sharing service not available');
      return false;
    }
    
    try {
      final result = await _locationSharingService!.joinSession(sessionId);
      
      if (result) {
        _activeSharingSessionId = sessionId;
        _isLocationSharingEnabled = true;
        
        // Notify listeners
        _navigationEventController.add(NavigationEvent.locationSharingStarted);
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error joining location sharing session: $e');
      return false;
    }
  }
  
  /// Get all currently shared locations
  List<SharedLocation> getSharedLocations() {
    return List.unmodifiable(_sharedLocations);
  }
  
  /// Update the camera position based on current location and speed
  Future<void> _updateCameraPosition(Position position) async {
    if (!_isNavigating || !_isTrackingUser || !_mapController.isMapInitialized) {
      return;
    }

    try {
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
  
  /// Check if location sharing is enabled
  bool get isLocationSharingEnabled => _isLocationSharingEnabled;
  
  /// Get active sharing session ID, if any
  String? get activeSharingSessionId => _activeSharingSessionId;
  
  /// Dispose resources
  void dispose() {
    _navigationEventController.close();
    _sharedLocationsSubscription?.cancel();
    stopLocationSharing();
  }
} 