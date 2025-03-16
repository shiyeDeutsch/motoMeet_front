import 'dart:async';
import 'dart:convert';
import 'dart:math' show sin, cos, asin, sqrt, pi;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../models/enum.dart';
import '../models/route.dart';
import '../services/httpClient.dart';
import '../services/loctionService.dart';
import 'isar/repository_provider.dart';
import '../utilities/apiEndPoints.dart';

/// Riverpod provider for the UserRouteService
final userRouteServiceProvider =
    StateNotifierProvider<UserRouteService, UserRoute?>((ref) {
  return UserRouteService();
});

/// Service for managing user routes
class UserRouteService extends StateNotifier<UserRoute?> {
  UserRouteService() : super(null);

  final _repoProvider = GetIt.I<RepositoryProvider>();
  StreamSubscription<Position>? _locationUpdatesSubscription;

  // List of threshold-validated points for the current trip
  final List<GeoPoint> _committedPoints = [];

  // Keep track of the user's current location for real-time marker
  Position? _currentPosition;

  // Basic route configuration
  double _distanceFactor = 5.0; // e.g., 5m for hiking
  double _pathLength = 0;
  Timer? _timer;
  Duration _routeDuration = const Duration();

  // Reference to the base route
  Route? _baseRoute;

  // Used to force an update (e.g., if we want a time-based commit)
  bool _forceStateUpdate = false;

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
    if (route.routeType != null) {
      switch (route.routeType!) {
        case RouteType.hiking:
          _distanceFactor = 5.0;
          break;
        case RouteType.biking:
          _distanceFactor = 10.0;
          break;
        case RouteType.motorcycle:
          _distanceFactor = 20.0;
          break;
        case RouteType.jeep:
          _distanceFactor = 30.0;
          break;
      }
    } else {
      _distanceFactor = 10.0; // Default
    }

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

    // Start location updates
    LocationService.startListening();
    _locationUpdatesSubscription =
        LocationService.locationUpdates.listen(_onLocationUpdate);

    // Start a timer to force updates every minute
    _startTimer();
    
    // Save the initial UserRoute to local database
    await _saveUserRouteToLocalDb();
  }

  /// Start a brand new route (creates both Route and UserRoute)
  Future<void> startNewRoute(RouteType routeType, GeoPoint startPoint) async {
    // Cancel anything lingering
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();

    _committedPoints.clear();
    _pathLength = 0;
    _routeDuration = const Duration();

    // Decide distance factor
    switch (routeType) {
      case RouteType.hiking:
        _distanceFactor = 5.0;
        break;
      case RouteType.biking:
        _distanceFactor = 10.0;
        break;
      case RouteType.motorcycle:
        _distanceFactor = 20.0;
        break;
      case RouteType.jeep:
        _distanceFactor = 30.0;
        break;
    }

    // 1. Create a new Route object
    final route = Route(
      name: 'New Route', // Temporary name, will be updated later
      startPoint: startPoint,
      routeType: routeType,
      startDate: DateTime.now().toUtc(),
    );
    
    // 2. Save the Route to server to get an ID
    final savedRoute = await _saveRouteToServer(route);
    if (savedRoute == null) {
      // If server save fails, save locally only
      final localRouteId = await _repoProvider.routeRepository.add(route);
      route.id = localRouteId;
    }
    
    _baseRoute = savedRoute ?? route;
    
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
    await _saveUserRouteToLocalDb();
    
    // Add the starting point
    _committedPoints.add(startPoint);

    // Start location updates
    LocationService.startListening();
    _locationUpdatesSubscription =
        LocationService.locationUpdates.listen(_onLocationUpdate);

    // Start a timer to force updates every minute
    _startTimer();
  }

  void _onLocationUpdate(Position newLocation) {
    _currentPosition = newLocation;

    // Threshold check
    final lastPoint = _committedPoints.last;
    final distance = _calculateDistanceInMeters(
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
      _saveUserRoutePointToLocalDb(_committedPoints.last, _committedPoints.length - 1);
    }
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
    _saveUserRouteToLocalDb();
  }

  /// Stop the route. No more listening to location updates.
  Future<void> stopUserRoute() async {
    _locationUpdatesSubscription?.cancel();
    _locationUpdatesSubscription = null;
    _timer?.cancel();
    _timer = null;
    LocationService.dispose();

    if (state == null) return;
    
    // Mark route as completed with final stats
    final finalUserRoute = state!.copyWith(
      distance: _pathLength,
      durationMinutes: _routeDuration.inMinutes,
    );

    state = finalUserRoute;
    
    // Save the final UserRoute to local database
    await _saveUserRouteToLocalDb();
    
    // Optionally, update the base Route with new information
    if (_baseRoute != null) {
      // Update the base route with end point if it doesn't have one
      if (_baseRoute!.endPoint == null && _committedPoints.isNotEmpty) {
        _baseRoute = _baseRoute!.copyWith(
          endPoint: _committedPoints.last,
          endDate: DateTime.now().toUtc(),
        );
        
        // Save the updated base Route
        await _repoProvider.routeRepository.update(_baseRoute!);
        
        // Optionally sync with server
        await _saveRouteToServer(_baseRoute!);
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
    await _repoProvider.routeRepository.update(updatedRoute);
    
    // Save to server
    final serverRoute = await _saveRouteToServer(updatedRoute);
    return serverRoute ?? updatedRoute;
  }

  /// Save Route to server
  Future<Route?> _saveRouteToServer(Route route) async {
    final user = _repoProvider.userInfoRepository.getLastSync();
    if (user == null) {
      if (kDebugMode) print('No user found. Cannot save route.');
      return null;
    }

    try {
      // Convert route to JSON
      var jsonPayload = route.toJson();
      
      // Add user ID
      jsonPayload["addedBy"] = user.id;

      // Fire the request
      final response = await HttpClient.post(
        uri: ApiEndpoints.routes,
        body: jsonEncode(jsonPayload),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Parse the response if the server returns the final route
        if (kDebugMode) print('Route saved successfully on the server.');
        
        // Parse the response to get the server-assigned ID
        final responseJson = jsonDecode(response.body);
        if (responseJson['id'] != null) {
          route = route.copyWith(id: responseJson['id']);
          
          // Update the local copy with the server ID
          await _repoProvider.routeRepository.update(route);
        }
        
        return route;
      } else {
        if (kDebugMode) {
          print('Route saving failed. Status: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving route to server: $e');
      }
      return null;
    }
  }

  /// Save UserRoute to local database
  Future<void> _saveUserRouteToLocalDb() async {
    if (state == null) return;
    
    try {
      if (state!.id == null) {
        // New UserRoute
        final id = await _repoProvider.userRouteRepository.add(state!);
        state = state!.copyWith(id: id);
      } else {
        // Update existing UserRoute
        await _repoProvider.userRouteRepository.update(state!);
      }
      
      // Link to the base Route if available
      if (_baseRoute != null && _baseRoute!.id != null) {
        // This would require additional code to establish the link in Isar
        // For now, we'll just note that this should happen
        if (kDebugMode) print('Linking UserRoute to Route ID: ${_baseRoute!.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving UserRoute to local database: $e');
      }
    }
  }

  /// Save a UserRoutePoint to local database
  Future<void> _saveUserRoutePointToLocalDb(GeoPoint point, int sequenceNumber) async {
    if (state == null || state!.id == null) return;
    
    try {
      final userRoutePoint = UserRoutePoint(
        point: point,
        sequenceNumber: sequenceNumber,
      );
      
      final id = await _repoProvider.userRoutePointRepository.add(userRoutePoint);
      
      // This would require additional code to establish the link in Isar
      // For now, we'll just note that this should happen
      if (kDebugMode) print('Added UserRoutePoint ID: $id for UserRoute ID: ${state!.id}');
    } catch (e) {
      if (kDebugMode) {
        print('Error saving UserRoutePoint to local database: $e');
      }
    }
  }

  /// Add a point of interest to the route
  Future<void> addPointOfInterest(
    GeoPoint location,
    String name,
    String description,
    WaypointType waypointType,
    [String? imageUrl]
  ) async {
    if (_baseRoute == null) return;
    
    try {
      final poi = PointOfInterest(
        location: location,
        name: name,
        description: description,
        waypointType: waypointType,
        imageUrl: imageUrl,
      );
      
      final id = await _repoProvider.pointOfInterestRepository.add(poi);
      
      // This would require additional code to establish the link in Isar
      // For now, we'll just note that this should happen
      if (kDebugMode) print('Added PointOfInterest ID: $id for Route ID: ${_baseRoute!.id}');
      
      // Optionally sync with server
      // This would require an API endpoint for adding points of interest
    } catch (e) {
      if (kDebugMode) {
        print('Error adding point of interest: $e');
      }
    }
  }

  /// Calculate distance in meters
  double _calculateDistanceInMeters(LatLng point1, LatLng point2) {
    const earthRadiusM = 6371000.0;
    var dLat = _degreesToRadians(point2.latitude - point1.latitude);
    var dLon = _degreesToRadians(point2.longitude - point1.longitude);
    var lat1 = _degreesToRadians(point1.latitude);
    var lat2 = _degreesToRadians(point2.latitude);

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * asin(sqrt(a));
    return earthRadiusM * c;
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180.0;

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