import 'dart:async';
import 'dart:convert';
import 'dart:math' show sin, cos, asin, sqrt, pi;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/enum.dart';
import '../models/route.dart';
import '../services/httpClient.dart';
import '../services/loctionService.dart';
import '../services/isar/reposetory_provider.dart';
import '../utilities/apiEndPoints.dart';

/// Riverpod provider for the RouteService
final routeServiceProvider =
    StateNotifierProvider<RouteService, NewRoute?>((ref) {
  return RouteService();
});

class RouteService extends StateNotifier<NewRoute?> {
  RouteService() : super(null);

  final _repoProvider = GetIt.I<RepositoryProvider>();
  StreamSubscription<Position>? _locationUpdatesSubscription;

  // List of threshold-validated points
  final List<GeoPoint> _committedPoints = [];

  // Keep track of the user’s current location for real-time marker
  Position? _currentPosition;

  // Basic route configuration
  double _distanceFactor = 5.0; // e.g., 5m for hiking
  double _pathLength = 0;
  Timer? _timer;
  Duration _routeDuration = const Duration();

  // Used to force an update (e.g., if we want a time-based commit)
  bool _forceStateUpdate = false;

  /// Start a brand new route
  void startNewRoute(RouteTypeEnum routeType, GeoPoint startPoint) {
    // Cancel anything lingering
    _locationUpdatesSubscription?.cancel();
    _timer?.cancel();

    _committedPoints.clear();
    _pathLength = 0;
    _routeDuration = const Duration();

    // Decide distance factor
    switch (routeType) {
      case RouteTypeEnum.hiking:
        _distanceFactor = 5.0;
        break;
      case RouteTypeEnum.biking:
        _distanceFactor = 10.0;
        break;
      default:
        _distanceFactor = 20.0;
        break;
    }

    // Build a fresh route
    final newRoute = NewRoute(
      isarId: null,
      startDate: DateTime.now().toUtc(),
      endDate: null,
      name: '',
      description: '',
      startPoint: startPoint,
      endPoint: null,
      routeType: RouteType(type: routeType),
      length: 0,
      durationMinutes: 0,
      routePoints: [],
      routeTags: [],
      isActive: true,
      isComplited: false,
      pointOfInterest: null,
      coverImageUrl: '',
      country: '',
      region: '',
      isLoop: false,
      rating: 0,
      natureReserveUrl: '',
      tips: '',
      difficulty: null,
    );
    state = newRoute;

    _committedPoints.add(startPoint);

    // Start location updates
    LocationService.startListening();
    _locationUpdatesSubscription =
        LocationService.locationUpdates.listen(_onLocationUpdate);

    // Optionally start a timer to force updates every minute
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
        GeoPoint.fromLatLng(
          LatLng(newLocation.latitude, newLocation.longitude),
          newLocation.altitude,
        ),
      );
      _updateRouteState();
      _forceStateUpdate = false;
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

  void _updateRouteState() {
    if (state == null) return;
    final updatedPoints = List<GeoPoint>.from(_committedPoints);

    final updated = state!.copyWith(
      routePoints: updatedPoints,
      length: _pathLength,
      endPoint: updatedPoints.last,
      durationMinutes: _routeDuration.inMinutes,
      endDate: DateTime.now().toUtc(),
    );
    state = updated;
  }

  /// Stop the route. No more listening to location updates.
  /// Optionally do final line simplification if desired.
  Future<void> stopRoute() async {
    _locationUpdatesSubscription?.cancel();
    _locationUpdatesSubscription = null;
    _timer?.cancel();
    _timer = null;
    LocationService.dispose();

    if (state == null) return;
   final simplifiedPoints = _douglasPeuckerAlgorithm(state!.routePoints!, 10.0);
    // Mark route as completed
    final finalRoute = state!.copyWith(
      routePoints: simplifiedPoints,
      isActive: false,
      isComplited: true,
      endDate: DateTime.now().toUtc(),
    );

    state = finalRoute;
  }

  /// The public method called from the SaveRouteScreen
  /// 1) Updates the route with the user’s chosen name, description, tags
  /// 2) Calls server-saving method
  Future<NewRoute?> saveRoute(
    String name,
    String? description,
    List<TagEnum>? tags,
  ) async {
    if (state == null) return null;

    // Build a new route with user-supplied data
    final updated = state!.copyWith(
      name: name,
      description: description,
      routeTags: tags ?? [],
    );
    state = updated;

    // Perform the final server save
    final responseRoute = await _saveRouteToServer(updated);
    return responseRoute;
  }

  /// Actually save to server (or local DB).
  /// If successful, return the route (or some updated route).
  Future<NewRoute?> _saveRouteToServer(NewRoute route) async {
    final user = _repoProvider.userInfoRepository.getLastSync();
    if (user == null) {
      if (kDebugMode) print('No user found. Cannot save route.');
      return null;
    }

    try {
      // Convert route to JSON
      var jsonPayload = route.toJson();
      // Adjust fields
      jsonPayload["startPointArray"] = jsonPayload.remove("startPoint");
      jsonPayload["endPointArray"] = jsonPayload.remove("endPoint");
      jsonPayload["routePointsArray"] = jsonPayload.remove("routePoints");
      jsonPayload["addedBy"] = user.id;

      // Convert routeTags to IDs if needed by your backend
      List<int> routeTagsIds = (jsonPayload['routeTags'] as List<dynamic>)
          .map((tagName) {
            var tagEnumValue = TageEnumExtension.fromString(tagName);
            return TageEnumExtension.getId(tagEnumValue);
          })
          .toList();
      jsonPayload.remove('routeTags');
      jsonPayload['routeTagsIds'] = routeTagsIds;

      // Fire the request
      final response = await HttpClient.post(
        uri: EndPoints.addNewRoute,
        body: jsonEncode(jsonPayload),
      );

      if (response.statusCode == 201) {
        // Parse the response if the server returns the final route
        if (kDebugMode) print('Route saved successfully on the server.');
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

  /// Douglas-Peucker line simplification (post-processing)
  /// threshold here is in meters; you can tweak as needed
  List<GeoPoint> _douglasPeuckerAlgorithm(List<GeoPoint> points, double epsilon) {
    if (points.length < 3) return points;

    // The DP algorithm typically takes a polyline of [x, y],
    // but we can adapt it easily to lat/lng (or use LatLng directly).
    final result = _dpRecursive(points, epsilon);
    // Ensure start & end always included
    if (result.isEmpty) {
      return points;
    }
    return result;
  }

  List<GeoPoint> _dpRecursive(List<GeoPoint> points, double epsilon) {
    if (points.length < 3) return points;

    double maxDistance = 0;
    int index = 0;

    // Line from first to last
    final start = points.first.toLatLng();
    final end = points.last.toLatLng();

    // Find the point farthest away from the line segment
    for (int i = 1; i < points.length - 1; i++) {
      double distance =
          _perpendicularDistance(points[i].toLatLng(), start, end);
      if (distance > maxDistance) {
        index = i;
        maxDistance = distance;
      }
    }

    // If max distance is greater than epsilon, recursively simplify
    if (maxDistance > epsilon) {
      final left = _dpRecursive(points.sublist(0, index + 1), epsilon);
      final right = _dpRecursive(points.sublist(index, points.length), epsilon);

      // Merge results (drop the duplicate middle point)
      return [...left.sublist(0, left.length - 1), ...right];
    } else {
      // Otherwise all points on the segment can be replaced by the endpoints
      return [points.first, points.last];
    }
  }

  double _perpendicularDistance(LatLng point, LatLng lineStart, LatLng lineEnd) {
    // If lineStart == lineEnd, distance is just to that single point
    final dx = lineEnd.longitude - lineStart.longitude;
    final dy = lineEnd.latitude - lineStart.latitude;
    if (dx == 0 && dy == 0) {
      return _calculateDistanceInMeters(lineStart, point);
    }

    // Project point onto the line
    final t = ((point.longitude - lineStart.longitude) * dx +
            (point.latitude - lineStart.latitude) * dy) /
        (dx * dx + dy * dy);

    // Where does projection fall?
    double tx = lineStart.longitude + (t * dx);
    double ty = lineStart.latitude + (t * dy);

    // If outside segment, clamp to nearest end
    if (t < 0.0) {
      tx = lineStart.longitude;
      ty = lineStart.latitude;
    } else if (t > 1.0) {
      tx = lineEnd.longitude;
      ty = lineEnd.latitude;
    }

    // Return distance from point to that projection
    final proj = LatLng(ty, tx);
    return _calculateDistanceInMeters(point, proj);
  }

  // -----------------------
  //  GETTERS (for the UI)
  // -----------------------
  Position? get currentPosition => _currentPosition;

  // If you need access to the underlying threshold-based points
  List<GeoPoint> get committedPoints => _committedPoints;
}
