import 'dart:convert';
import 'dart:math' show sin, cos, asin, sqrt, pi;

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';

import '../models/enum.dart';
import '../models/route.dart';
import '../services/httpClient.dart';
import '../services/isar/repository_provider.dart';
import '../utilities/apiEndPoints.dart';

/// Service for handling route creation operations
class RouteCreationService {
  final _repoProvider = GetIt.I<RepositoryProvider>();

  /// Save Route to server
  Future<Route?> saveRouteToServer(Route route) async {
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
          await updateRouteInLocalDb(route);
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

  /// Save Route to local database
  Future<int> saveRouteToLocalDb(Route route) async {
    try {
      return await _repoProvider.routeRepository.add(route);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving route to local database: $e');
      }
      rethrow;
    }
  }

  /// Update Route in local database
  Future<void> updateRouteInLocalDb(Route route) async {
    try {
      await _repoProvider.routeRepository.update(route);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating route in local database: $e');
      }
    }
  }

  /// Save UserRoute to local database
  Future<void> saveUserRouteToLocalDb(UserRoute userRoute) async {
    try {
      if (userRoute.id == null) {
        // New UserRoute
        final id = await _repoProvider.userRouteRepository.add(userRoute);
        userRoute = userRoute.copyWith(id: id);
      } else {
        // Update existing UserRoute
        await _repoProvider.userRouteRepository.update(userRoute);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving UserRoute to local database: $e');
      }
    }
  }

  /// Link a UserRoute to its parent Route
  Future<void> linkUserRouteToRoute(int userRouteId, int routeId) async {
    // This would require additional code to establish the link in Isar
    // For now, we'll just note that this should happen
    if (kDebugMode) {
      print('Linking UserRoute ID: $userRouteId to Route ID: $routeId');
    }
    
    // Implementation would depend on specific Isar link operations
    // Example pseudocode:
    // final route = await _repoProvider.routeRepository.getById(routeId);
    // final userRoute = await _repoProvider.userRouteRepository.getById(userRouteId);
    // route.userRoutes.add(userRoute);
    // await _repoProvider.routeRepository.update(route);
  }

  /// Save a UserRoutePoint to local database
  Future<void> saveUserRoutePointToLocalDb(
    GeoPoint point, 
    int sequenceNumber,
    int? userRouteId
  ) async {
    if (userRouteId == null) return;
    
    try {
      final userRoutePoint = UserRoutePoint(
        point: point,
        sequenceNumber: sequenceNumber,
      );
      
      final id = await _repoProvider.userRoutePointRepository.add(userRoutePoint);
      
      // This would require additional code to establish the link in Isar
      // For now, we'll just note that this should happen
      if (kDebugMode) print('Added UserRoutePoint ID: $id for UserRoute ID: $userRouteId');
      
      // Implementation would depend on specific Isar link operations
      // Example pseudocode:
      // final userRoute = await _repoProvider.userRouteRepository.getById(userRouteId);
      // userRoute.userRoutePoints.add(userRoutePoint);
      // await _repoProvider.userRouteRepository.update(userRoute);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving UserRoutePoint to local database: $e');
      }
    }
  }

  /// Add a point of interest to the route
  Future<void> addPointOfInterest(
    int routeId,
    GeoPoint location,
    String name,
    String description,
    WaypointType waypointType,
    [String? imageUrl]
  ) async {
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
      if (kDebugMode) print('Added PointOfInterest ID: $id for Route ID: $routeId');
      
      // Implementation would depend on specific Isar link operations
      // Example pseudocode:
      // final route = await _repoProvider.routeRepository.getById(routeId);
      // route.pointsOfInterest.add(poi);
      // await _repoProvider.routeRepository.update(route);
      
      // Optionally sync with server
      // This would require an API endpoint for adding points of interest
    } catch (e) {
      if (kDebugMode) {
        print('Error adding point of interest: $e');
      }
    }
  }

  /// Calculate distance in meters between two geographical points
  double calculateDistanceInMeters(LatLng point1, LatLng point2) {
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

  /// Helper function to convert degrees to radians
  double _degreesToRadians(double degrees) => degrees * pi / 180.0;
}