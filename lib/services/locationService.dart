import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../constants/app_constants.dart';

/// A service that provides location updates throughout the app
/// Acts as the single source of truth for location data
class LocationService {
  // Cache the most recent position
  Position? _lastKnownPosition;
  DateTime? _lastUpdateTime;
  
  // StreamController to broadcast location updates
  final StreamController<Position> _locationUpdatesController = 
      StreamController<Position>.broadcast();
  
  // Public stream to listen for location updates
  Stream<Position> get locationUpdates => _locationUpdatesController.stream;
  
  // Subscription for the location updates stream
  StreamSubscription<Position>? _positionSubscription;
  
  // Status tracking
  bool _isListening = false;
  bool get isListening => _isListening;
  
  // Settings
  LocationAccuracy _accuracy = LocationAccuracy.high;
  int _updateIntervalMs = 5000; // 5 seconds by default
  
  /// Change location settings
  void configure({
    LocationAccuracy? accuracy,
    int? updateIntervalMs,
  }) {
    bool needsRestart = false;
    
    if (accuracy != null && accuracy != _accuracy) {
      _accuracy = accuracy;
      needsRestart = _isListening;
    }
    
    if (updateIntervalMs != null && updateIntervalMs != _updateIntervalMs) {
      _updateIntervalMs = updateIntervalMs;
      needsRestart = _isListening;
    }
    
    // Restart listening if we were already listening and settings changed
    if (needsRestart) {
      stopListening();
      startListening();
    }
  }

  /// Get most recent position without waiting, may return null
  Position? get lastKnownPosition => _lastKnownPosition;
  
  /// Check if the last known position is recent enough (within the last 10 seconds)
  bool get hasRecentPosition => 
      _lastKnownPosition != null && 
      _lastUpdateTime != null &&
      DateTime.now().difference(_lastUpdateTime!).inSeconds < 10;

  /// Starts listening to location updates if not already listening
  Future<bool> startListening() async {
    if (_isListening) return true;
    
    try {
      // Ensure location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Location services are disabled.');
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // Get initial position immediately
      try {
        final initialPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: _accuracy,
          timeLimit: const Duration(seconds: 5),
        );
        _updatePosition(initialPosition);
      } catch (e) {
        debugPrint('Error getting initial position: $e');
        // Continue anyway to set up the stream
      }

      // Start listening to location updates
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: _accuracy,
          distanceFilter: 5, // Only update if moved 5 meters
          timeLimit: Duration(milliseconds: _updateIntervalMs),
        ),
      ).listen(
        _updatePosition,
        onError: (error) {
          debugPrint('Location stream error: $error');
          _locationUpdatesController.addError(error);
        },
      );
      
      _isListening = true;
      return true;
    } catch (e) {
      debugPrint('Error starting location updates: $e');
      _locationUpdatesController.addError(e);
      return false;
    }
  }
  
  /// Update position and notify listeners
  void _updatePosition(Position position) {
    _lastKnownPosition = position;
    _lastUpdateTime = DateTime.now();
    _locationUpdatesController.add(position);
  }

  /// Get current position, may use cache if recent enough
  Future<Position> getCurrentPosition({
    bool useCacheIfAvailable = true,
    int maxCacheAgeSeconds = 5,
    Duration? timeout,
  }) async {
    // Return cached position if available and recent enough
    if (useCacheIfAvailable && 
        _lastKnownPosition != null && 
        _lastUpdateTime != null &&
        DateTime.now().difference(_lastUpdateTime!).inSeconds <= maxCacheAgeSeconds) {
      return _lastKnownPosition!;
    }
    
    // Otherwise get fresh position
    try {
      // Ensure location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Location services are disabled.');
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // Fetch the current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: _accuracy,
        timeLimit: timeout ?? const Duration(seconds: 10),
      );
      
      // Update cached position
      _updatePosition(position);
      return position;
    } catch (e) {
      // If we have a cached position, return it as fallback
      if (_lastKnownPosition != null) {
        return _lastKnownPosition!;
      }
      return Future.error(e);
    }
  }
  
  /// Get current location as LatLng
  Future<LatLng> getCurrentLatLng({
    bool useCacheIfAvailable = true,
    int maxCacheAgeSeconds = 5,
  }) async {
    final position = await getCurrentPosition(
      useCacheIfAvailable: useCacheIfAvailable,
      maxCacheAgeSeconds: maxCacheAgeSeconds,
    );
    return LatLng(position.latitude, position.longitude);
  }

  /// Stops listening to location updates
  void stopListening() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    _isListening = false;
  }

  /// Disposes of resources used by the service
  void dispose() {
    stopListening();
    _locationUpdatesController.close();
  }
}
