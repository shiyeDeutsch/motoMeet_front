import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';

import '../models/enum.dart';
import '../models/route.dart';
import '../services/locationService.dart';
import '../services/route_creation_service.dart';
import '../constants/app_constants.dart';

/// Provider for route creation state management
final routeCreationProvider =
    StateNotifierProvider<RouteCreationNotifier, UserRoute?>((ref) {
  return RouteCreationNotifier();
});

/// Notifier for managing route creation state
class RouteCreationNotifier extends StateNotifier<UserRoute?> {
  RouteCreationNotifier() : super(null);

  final RouteCreationService _routeCreationService = GetIt.I<RouteCreationService>();
  final LocationService _locationService = GetIt.I<LocationService>();
  StreamSubscription<Position>? _locationUpdatesSubscription;

  // List of threshold-validated points for the current trip
  final List<GeoPoint> _committedPoints = [];

  // Keep track of the user's current location for real-time marker
  Position? _currentPosition;

  // Basic route configuration
  double _distanceFactor = MapConfig.HIKING_THRESHOLD; // Default
  double _pathLength = 0;
  Timer? _timer;
  Duration _routeDuration = const Duration();

  // Reference to the base route
  Route? _baseRoute;

  // Used to force an update (e.g., if we want a time-based commit)
  bool _forceStateUpdate = false;
  
  // Stream controller for position updates - will be used by other components
  final _positionStreamController = StreamController<Position>.broadcast();
  Stream<Position> get positionStream => _positionStreamController.stream;
  
  // Set to track position update listeners
  final Set<Function(Position)> _positionUpdateListeners = {};

  /// Start a new trip on an existing route
  Future<void> startExistingRoute(Route route) async {
    // Cancel anything lingering
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();

    _committedPoints.clear();
    _pathLength = 0;
    _routeDuration = const Duration();
    _baseRoute = route;

    // Decide distance factor based on route type
    _setDistanceFactorFromRouteType(route.routeType);

    // Build a fresh UserRoute
    final userRoute = UserRoute(
      dateTraveled: DateTime.now().toUtc(),
      routeType: route.routeType,
      difficultyLevel: route.difficultyLevel,
      durationMinutes: 0,
      distance: 0,
      elevationGain: 0,
    );
    
    state = userRoute;

    // If we have a starting point from the route, add it
    if (route.startPoint != null) {
      _committedPoints.add(route.startPoint!);
    }

    // Start location updates if not already started
    if (!_locationService.isListening) {
      await _locationService.startListening();
    }
    
    // Configure location service for route tracking
    _locationService.configure(
      accuracy: LocationAccuracy.high,
      updateIntervalMs: 1000, // More frequent updates for navigation (1 second)
    );
    
    // Subscribe to location updates
    _locationUpdatesSubscription =
        _locationService.locationUpdates.listen(_onLocationUpdate);

    // Start a timer to force updates every minute
    _startTimer();
    
    // Save the initial UserRoute to local database
    await _routeCreationService.saveUserRouteToLocalDb(state!);
  }

  /// Start a brand new route (creates both Route and UserRoute)
  Future<void> startNewRoute(RouteType routeType, GeoPoint startPoint) async {
    // Cancel anything lingering
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();

    _committedPoints.clear();
    _pathLength = 0;
    _routeDuration = const Duration();

    // Decide distance factor based on route type
    _setDistanceFactorFromRouteType(routeType);

    // 1. Create a new Route object
    final route = Route(
      name: 'New Route', // Temporary name, will be updated later
      startPoint: startPoint,
      routeType: routeType,
      startDate: DateTime.now().toUtc(),
    );
    
    // 2. Save the Route to server to get an ID
    _baseRoute = await _routeCreationService.saveRouteToServer(route);
    if (_baseRoute == null) {
      // If server save fails, save locally only
      final localRouteId = await _routeCreationService.saveRouteToLocalDb(route);
      route.id = localRouteId;
      _baseRoute = route;
    }
    
    // 3. Create a UserRoute linked to the Route
    final userRoute = UserRoute(
      dateTraveled: DateTime.now().toUtc(),
      routeType: routeType,
      durationMinutes: 0,
      distance: 0,
      elevationGain: 0,
    );
    
    state = userRoute;
    
    // 4. Save the UserRoute to local database
    await _routeCreationService.saveUserRouteToLocalDb(userRoute);
    
    // Add the starting point
    _committedPoints.add(startPoint);

    // Start location updates if not already started
    if (!_locationService.isListening) {
      await _locationService.startListening();
    }
    
    // Configure location service for route tracking with higher frequency
    _locationService.configure(
      accuracy: LocationAccuracy.high,
      updateIntervalMs: 1000, // 1 second updates for navigation
    );
    
    // Subscribe to location updates
    _locationUpdatesSubscription =
        _locationService.locationUpdates.listen(_onLocationUpdate);

    // Start a timer to force updates every minute
    _startTimer();
  }

  /// Helper method to set the distance factor based on route type
  void _setDistanceFactorFromRouteType(RouteType? routeType) {
    if (routeType == null) {
      _distanceFactor = MapConfig.HIKING_THRESHOLD; // Default
      return;
    }
    
    switch (routeType) {
      case RouteType.hiking:
        _distanceFactor = MapConfig.HIKING_THRESHOLD;
        break;
      case RouteType.biking:
        _distanceFactor = MapConfig.BIKING_THRESHOLD;
        break;
      case RouteType.motorcycle:
        _distanceFactor = MapConfig.MOTORCYCLE_THRESHOLD;
        break;
      case RouteType.jeep:
        _distanceFactor = MapConfig.JEEP_THRESHOLD;
        break;
    }
  }

  void _onLocationUpdate(Position newLocation) {
    // Update current position regardless of threshold
    _currentPosition = newLocation;
    
    // Broadcast the position update to listeners
    _positionStreamController.add(newLocation);
    
    // Notify any registered listeners
    for (final listener in _positionUpdateListeners) {
      listener(newLocation);
    }

    // Threshold check for adding points to the route
    if (_committedPoints.isEmpty) {
      // First point - just add it
      _committedPoints.add(
        GeoPoint(
          latitude: newLocation.latitude,
          longitude: newLocation.longitude,
          altitude: newLocation.altitude,
        ),
      );
      return;
    }
    
    final lastPoint = _committedPoints.last;
    final distance = _routeCreationService.calculateDistanceInMeters(
      lastPoint.toLatLng(),
      LatLng(newLocation.latitude, newLocation.longitude),
    );

    if (distance >= _distanceFactor || _forceStateUpdate) {
      _pathLength += distance;
      _committedPoints.add(
        GeoPoint(
          latitude: newLocation.latitude,
          longitude: newLocation.longitude,
          altitude: newLocation.altitude,
        ),
      );
      _updateUserRouteState();
      _forceStateUpdate = false;
      
      // Save the point to the database
      _routeCreationService.saveUserRoutePointToLocalDb(
        _committedPoints.last, 
        _committedPoints.length - 1,
        state!.id
      );
    }
  }

  /// Register a listener for position updates
  void addPositionListener(Function(Position) listener) {
    _positionUpdateListeners.add(listener);
  }

  /// Remove a listener for position updates
  void removePositionListener(Function(Position) listener) {
    _positionUpdateListeners.remove(listener);
  }

  /// If you want a time-based forced update, e.g., every 1 minute
  void _startTimer() {
    _timer?.cancel();
    _routeDuration = const Duration();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _forceStateUpdate = true;
      _routeDuration += const Duration(minutes: 1);
    });
  }

  void _updateUserRouteState() {
    if (state == null) return;

    final updated = state!.copyWith(
      distance: _pathLength,
      durationMinutes: _routeDuration.inMinutes,
    );
    state = updated;
    
    // Save the updated UserRoute to local database
    _routeCreationService.saveUserRouteToLocalDb(state!);
  }

  /// Stop the route. No more listening to location updates.
  Future<void> stopUserRoute() async {
    _locationUpdatesSubscription?.cancel();
    _locationUpdatesSubscription = null;
    _timer?.cancel();
    _timer = null;
    
    // Return location service to normal update frequency
    _locationService.configure(
      updateIntervalMs: 5000, // 5 seconds in normal mode
    );
    
    // We don't call LocationService.dispose() here because other parts
    // of the app may still need location updates

    if (state == null) return;
    
    // Mark route as completed with final stats
    final finalUserRoute = state!.copyWith(
      distance: _pathLength,
      durationMinutes: _routeDuration.inMinutes,
    );

    state = finalUserRoute;
    
    // Save the final UserRoute to local database
    await _routeCreationService.saveUserRouteToLocalDb(finalUserRoute);
    
    // Optionally, update the base Route with new information
    if (_baseRoute != null) {
      // Update the base route with end point if it doesn't have one
      if (_baseRoute!.endPoint == null && _committedPoints.isNotEmpty) {
        _baseRoute = _baseRoute!.copyWith(
          endPoint: _committedPoints.last,
          endDate: DateTime.now().toUtc(),
        );
        
        // Save the updated base Route
        await _routeCreationService.updateRouteInLocalDb(_baseRoute!);
        
        // Optionally sync with server
        await _routeCreationService.saveRouteToServer(_baseRoute!);
      }
    }
  }

  /// The public method called from the SaveRouteScreen
  /// Updates the route with the user's chosen name, description, tags
  Future<Route?> finalizeRoute(
    String name,
    String? description,
    List<TagEnum>? tags,
  ) async {
    if (_baseRoute == null) return null;

    // Update the base Route with user-supplied data
    final updatedRoute = _baseRoute!.copyWith(
      name: name,
      description: description,
      // We would need to convert tags to Tag objects and link them
    );
    
    _baseRoute = updatedRoute;
    
    // Save locally
    await _routeCreationService.updateRouteInLocalDb(updatedRoute);
    
    // Save to server
    final serverRoute = await _routeCreationService.saveRouteToServer(updatedRoute);
    return serverRoute ?? updatedRoute;
  }

  /// Add a point of interest to the route
  Future<void> addPointOfInterest(
    GeoPoint location,
    String name,
    String description,
    WaypointType waypointType,
    [String? imageUrl]
  ) async {
    if (_baseRoute == null || _baseRoute!.id == null) return;
    
    await _routeCreationService.addPointOfInterest(
      _baseRoute!.id!,
      location,
      name,
      description,
      waypointType,
      imageUrl
    );
  }

  @override
  void dispose() {
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();
    _positionStreamController.close();
    super.dispose();
  }

  // -----------------------
  //  GETTERS (for the UI)
  // -----------------------
  Position? get currentPosition => _currentPosition;
  List<GeoPoint> get committedPoints => _committedPoints;
  Route? get baseRoute => _baseRoute;
  
  // Computed properties
  Duration get routeDuration => _routeDuration;
  double get distance => _pathLength;
}