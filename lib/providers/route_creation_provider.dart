import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:latlong2/latlong.dart';

import '../models/enum.dart';
import '../models/route.dart';
import '../services/locationService.dart';
import '../services/route_creation_service.dart';
import '../constants/map_utilties.dart';

/// Provider for route creation state management
final routeCreationProvider =
    StateNotifierProvider<RouteCreationNotifier, UserRoute?>((ref) {
  return RouteCreationNotifier(ref);
});

/// Provider for real-time user location updates
final userLocationProvider = StateProvider<Position?>((ref) => null);

/// Notifier for managing route creation state
class RouteCreationNotifier extends StateNotifier<UserRoute?> {
  RouteCreationNotifier(this.ref) : super(null);

  final Ref ref;
  final RouteCreationService _routeCreationService =
      GetIt.I<RouteCreationService>();
  StreamSubscription<Position>? _locationUpdatesSubscription;

  // List of threshold-validated points for the current trip
  final List<GeoPoint> _committedPoints = [];

  // Keep track of the user's current location for real-time marker
  Position? _currentPosition;

  // Basic route configuration
  double _distanceFactor = MapConfig.HIKING_THRESHOLD; // Default
  double _pathLength = 0;
  double _elevationGain = 0.0; // Task 3: Add elevation gain tracker
  Timer? _timer;
  Duration _routeDuration = const Duration();

  // Reference to the base route
  Route? _baseRoute;

  // Used to force an update (e.g., if we want a time-based commit)
  bool _forceStateUpdate = false;

  // Keep track of the ID of the UserRoute being actively tracked
  Id? _currentUserRouteId;

  /// Start a new trip on an existing route
  Future<void> startExistingRoute(Route route) async {
    await _resetState();
    _baseRoute = route;
    _setDistanceFactorFromRouteType(route.routeType);

    // Create a new UserRoute for this specific journey
    // Difficulty level is determined *after* the journey
    final userRoute = UserRoute(
      dateTraveled: DateTime.now().toUtc(),
      routeType: route.routeType,
    
      durationMinutes: 0,
      distance: 0,
      elevationGain: 0,
    );

    // Save the initial UserRoute 
    await _routeCreationService.saveUserRouteToLocalDb(userRoute);
    // ID is auto-assigned by Isar upon saving
    _currentUserRouteId = userRoute.id; 
    if (_currentUserRouteId == null) {
      // Handle error: Saving failed or ID not assigned
      if (kDebugMode) {
        print("Error: Failed to get ID for new UserRoute in startExistingRoute");
      }
      await _resetState();
      return;
    }
    state = userRoute; // Update state now that we have the ID

    if (route.startPoint != null) {
      _committedPoints.add(route.startPoint!); 
    }

    _startLocationUpdates();
    _startTimer();
  }

  /// Start a brand new route (creates both Route and UserRoute)
  Future<void> startNewRoute(RouteType routeType, GeoPoint startPoint) async {
    await _resetState();
    _setDistanceFactorFromRouteType(routeType);

    // 1. Create a new Route object (will be finalized later)
    final newBaseRoute = Route(
      name: 'New Route', // Temporary name
      startPoint: startPoint,
      routeType: routeType,
      startDate: DateTime.now().toUtc(),
      // Other fields (length, duration, difficulty, etc.) are set in finalizeBaseRoute
    );

    // Save the initial Route locally to get an ID (server save happens on finalize)
    final localRouteId = await _routeCreationService.saveRouteToLocalDb(newBaseRoute);
    newBaseRoute.id = localRouteId;
    _baseRoute = newBaseRoute;

    // 2. Create a UserRoute for this first journey
    // Difficulty level is determined *after* the journey
    final userRoute = UserRoute(
      dateTraveled: DateTime.now().toUtc(),
      routeType: routeType,
      durationMinutes: 0,
      distance: 0,
      elevationGain: 0,
    );

    // Save the initial UserRoute 
    await _routeCreationService.saveUserRouteToLocalDb(userRoute);
    // ID is auto-assigned by Isar upon saving
    _currentUserRouteId = userRoute.id;
     if (_currentUserRouteId == null) {
      // Handle error: Saving failed or ID not assigned
       if (kDebugMode) {
        print("Error: Failed to get ID for new UserRoute in startNewRoute");
      }
      await _resetState();
      return;
    }
    state = userRoute; // Update state now that we have the ID

    _committedPoints.add(startPoint);
    _startLocationUpdates();
    _startTimer();
  }

  /// Helper to reset state variables before starting a route
  Future<void> _resetState() async {
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();
    _committedPoints.clear();
    _pathLength = 0;
    _elevationGain = 0.0;
    _routeDuration = const Duration();
    _baseRoute = null;
    state = null;
    _currentUserRouteId = null;
    _currentPosition = null;
    _forceStateUpdate = false;
  }

  /// Helper to start location listening
  void _startLocationUpdates() {
    LocationService.startListening();
    _locationUpdatesSubscription =
        LocationService.locationUpdates.listen(_onLocationUpdate);
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
    _currentPosition = newLocation;
    ref.read(userLocationProvider.notifier).state = newLocation;

    if (state == null || _currentUserRouteId == null) return; // Don't process if not tracking

    final currentGeoPoint = GeoPoint(
      latitude: newLocation.latitude,
      longitude: newLocation.longitude,
      altitude: newLocation.altitude,
    );

    bool shouldCommit = false;
    GeoPoint? lastPoint;

    if (_committedPoints.isNotEmpty) {
      lastPoint = _committedPoints.last;
      final distance = _routeCreationService.calculateDistanceInMeters(
        lastPoint.toLatLng(),
        LatLng(newLocation.latitude, newLocation.longitude),
      );
      if (distance >= _distanceFactor || _forceStateUpdate) {
        _pathLength += distance;
        shouldCommit = true;
      }
    } else {
      // Commit the very first point
      shouldCommit = true;
    }

    if (shouldCommit) {
      // Calculate elevation gain if possible
      if (lastPoint?.altitude != null && currentGeoPoint.altitude != null) {
        final altitudeDifference = currentGeoPoint.altitude! - lastPoint!.altitude!;
        if (altitudeDifference > 0) {
          _elevationGain += altitudeDifference;
        }
      }

      _committedPoints.add(currentGeoPoint);
      _updateUserRouteState(); // Update state with new point, distance, and gain
      _forceStateUpdate = false;

      // Save the point associated with the *active* UserRoute ID
      _routeCreationService.saveUserRoutePointToLocalDb(
          _committedPoints.last, _committedPoints.length - 1, _currentUserRouteId!);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _routeDuration = const Duration();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (state == null) { // Stop timer if tracking stopped
        _timer?.cancel();
        return;
      }
      _forceStateUpdate = true;
      _routeDuration += const Duration(minutes: 1);
      if (_currentPosition != null) {
         // Force an update check which might commit the point
        _onLocationUpdate(_currentPosition!); 
      }
    });
  }

  void _updateUserRouteState() {
    if (state == null) return;

    // Update the local state holder
    final updated = state!.copyWith(
        distance: _pathLength,
        durationMinutes: _routeDuration.inMinutes,
        elevationGain: _elevationGain,
        // routePoints are managed in _committedPoints and saved via UserRoutePoint
        );
    state = updated; // This state reflects the *current* journey progress

    // Save progress to the specific UserRoute being tracked
    if (_currentUserRouteId != null) {
       // We update the existing UserRoute record in DB, 
       // no need to pass points here as they are saved separately
      _routeCreationService.saveUserRouteToLocalDb(state!); 
    }
  }

  /// Stop the route tracking. Finalizes the UserRoute stats.
  Future<UserRoute?> stopUserRoute() async {
    _locationUpdatesSubscription?.cancel();
    _locationUpdatesSubscription = null;
    _timer?.cancel();
    _timer = null;
    LocationService.dispose();

    if (state == null || _currentUserRouteId == null) return null;

    // Mark UserRoute state as completed with final stats
    final finalUserRouteState = state!.copyWith(
      distance: _pathLength,
      durationMinutes: _routeDuration.inMinutes,
      elevationGain: _elevationGain,
    );
    state = finalUserRouteState;

    // Save the final UserRoute stats to the database
    await _routeCreationService.saveUserRouteToLocalDb(finalUserRouteState);

    // Update base route end point/date ONLY if not already set
    if (_baseRoute != null) {
      if (_baseRoute!.endPoint == null && _committedPoints.isNotEmpty) {
        _baseRoute = _baseRoute!.copyWith(
          endPoint: _committedPoints.last,
          endDate: DateTime.now().toUtc(),
        );
        await _routeCreationService.updateRouteInLocalDb(_baseRoute!); 
      }
    }
    
    // Return the completed UserRoute state (which includes the ID)
    // The difficulty will be added later via updateUserRouteDifficulty
    final completedUserRoute = state; 

    // Don't clear state here, SaveRouteScreen needs it
    // _resetState(); // Move reset to finalize/update methods
    
    return completedUserRoute; 
  }

  /// Finalizes a NEW base route after the first trip. 
  /// Called from SaveRouteScreen ONLY for initial creation.
  Future<Route?> finalizeBaseRoute(
    String name,
    String? description,
    DifficultyLevel? difficultyLevel, // Chosen by first user
    bool? isLoop, // Chosen by first user
  ) async {
    // Needs the completed UserRoute state for stats and the baseRoute reference
    if (_baseRoute == null || state == null) return null;

    final completedUserRoute = state!; // UserRoute from the first journey

    // Update the base Route with user input and final stats from first trip
    final finalBaseRoute = _baseRoute!.copyWith(
      name: name,
      description: description,
      difficultyLevel: difficultyLevel, 
      isLoop: isLoop, 
      length: completedUserRoute.distance, 
      durationMinutes: completedUserRoute.durationMinutes,
      elevationGain: completedUserRoute.elevationGain, 
      // Ensure endDate is also set if not already
      endDate: _baseRoute!.endDate ?? DateTime.now().toUtc(), 
    );

    _baseRoute = finalBaseRoute; // Update local reference

    // Save final base route locally
    await _routeCreationService.updateRouteInLocalDb(finalBaseRoute);

    // Save final base route to server
    final serverRoute =
        await _routeCreationService.saveRouteToServer(finalBaseRoute);
    
    await _resetState(); // Clean up state after finalizing

    return serverRoute ?? finalBaseRoute;
  }

  /// Updates the difficulty level of a specific completed UserRoute.
  /// Called from SaveRouteScreen after any trip (new or existing).
  Future<void> updateUserRouteDifficulty(
      Id userRouteId, 
      DifficultyLevel? difficultyLevel
  ) async {
     if (difficultyLevel == null) return; // Or handle error

    // Fetch the specific UserRoute from the database using the service method
    final userRoute = await _routeCreationService.getUserRouteById(userRouteId);
    if (userRoute == null) {
       if (kDebugMode) print("Error: Could not find UserRoute with ID $userRouteId to update difficulty");
      return; // Or handle error
    }

    // Update its difficulty level
    final updatedUserRoute = userRoute.copyWith(difficultyLevel: difficultyLevel);

    // Save the update back to the database
    await _routeCreationService.saveUserRouteToLocalDb(updatedUserRoute);

    // Optionally: If this was the *first* trip on a *new* route, 
    // we might also want to update the baseRoute's difficulty here?
    // This depends on whether baseRoute difficulty should reflect the first user's assessment.
    // Current logic in finalizeBaseRoute already handles this for the first trip.

    await _resetState(); // Clean up state after updating difficulty
  }

  /// Add a point of interest to the route (associates with base route)
  Future<void> addPointOfInterest(GeoPoint location, String name,
      String description, WaypointType waypointType,
      [String? imageUrl]) async {
    if (_baseRoute == null || _baseRoute!.id == null) return;
    await _routeCreationService.addPointOfInterest(
        _baseRoute!.id!, location, name, description, waypointType, imageUrl);
  }

  @override
  void dispose() {
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();
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
  double get elevationGain => _elevationGain; // Expose elevation gain
}
