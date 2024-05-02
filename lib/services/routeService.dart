import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:motomeetfront/services/httpClient.dart';
import '../main.dart';
import '../models/enum.dart';
import '../models/route.dart';
import 'dart:math' show cos, sqrt, sin, asin;

import '../stateProvider.dart';
import '../utilities/apiEndPoints.dart';
import 'isar/isar_user_info.dart';
import 'isar/reposetory_provider.dart';
import 'loctionService.dart';

class RouteService {
  // RouteService() {
  //   routeState = container.read(routeStateProvider.notifier);
  // }
  final ProviderContainer container =
      providerContainer; // Create a new ProviderContainer
  late RouteState routeState;
  late final NewRoute newRoute;
  StreamSubscription<Position>? _locationUpdatesSubscription;
  RouteTypeEnum? selectedRouteType;
  late double distanceFactor;
  List<GeoPoint> routePoints = <GeoPoint>[];
  Timer? _timer;
  Duration? routeDuration;
  bool forceStateUpdate = false;
  double pathLength = 0;
  late Position endPoint;
  Future<NewRoute?> saveRoute(
      String name, String? description, List<TagEnum>? tags) async {
      final isarService = GetIt.I<RepositoryProvider>().userInfoRepository;
    var user = isarService.getLastSync();
    NewRoute? route = routeState.saveRoute(name, description, tags);
    var json = route!.toJson();
    json["startPointArray"] = json.remove("startPoint");
    json["endPointArray"] = json.remove("endPoint");
    json["routePointsArray"] = json.remove("routePoints");
    json["addedBy"] = user!.id!;
    List<int> routeTagsIds =
        (json['routeTags'] as List<dynamic>).map((tagName) {
      var tagEnumValue = TageEnumExtension.fromString(tagName);
      return TageEnumExtension.getId(tagEnumValue);
    }).toList();
    json.remove('routeTags');
    json['routeTagsIds'] = routeTagsIds;
    try {
      final response = await HttpClient.post(
        uri: EndPoints.addNewRoute,
        body: jsonEncode(json),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
      } else {
        // Handle different status codes or errors as needed
        if (kDebugMode) {
          print('  failed with status code: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      // Log or handle the exception as needed
      if (kDebugMode) {
        print('An error occurred during login: $e');
      }
      return null;
    }
  }

  void startNewRoute(RouteTypeEnum selectedRouteType, GeoPoint startPoint) {
    routePoints = [];
    if (selectedRouteType == RouteTypeEnum.hiking) {
      distanceFactor = 5.0;
    } else if (selectedRouteType == RouteTypeEnum.biking) {
      distanceFactor = 10.0;
    } else {
      distanceFactor = 20.0;
    }
    initStateVariable();
    _startTimer();
    routeState.startNewRoute(startPoint, selectedRouteType);
    routePoints.add(startPoint);
    // Start listening to location updates
    _locationUpdatesSubscription = LocationService.locationUpdates.listen(
      (newLocation) {
        endPoint = newLocation;
        updateState(newLocation);
      },
      onError: (error) {
        // Handle or log any errors encountered
        print("Error receiving location updates: $error");
      },
    );
  }

  void _startTimer() {
    _timer?.cancel(); // Stop any previous timer
    routeDuration = const Duration(minutes: 0);
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      forceStateUpdate = true;
      // Set timer for 1 minutes
      routeDuration = routeDuration! + const Duration(minutes: 1);
    });
  }

  // A method to stop listening to location updates and clear the route
  void stopRoute() {
    // saveRoute();
    _locationUpdatesSubscription
        ?.cancel(); // Stop listening to location updates
    _locationUpdatesSubscription = null;
    // Clear or finalize the routePoints as necessary
    routePoints.clear();
    // Perform any additional cleanup or finalization as needed
    _timer?.cancel();
    _timer = null;
    routeDuration = null;
    LocationService.dispose();
  }

  void updateState(Position position) {
    var distance = calculateDistanceInMeters(routePoints.last.toLatLng(),
        LatLng(position.latitude, position.longitude));
    if (distance >= distanceFactor || forceStateUpdate) {
      pathLength += distance;
      routePoints.add(GeoPoint.fromLatLng(
          LatLng(position.latitude, position.longitude), position.altitude));
      routeState.addRoutePoints(routePoints, routeDuration!, pathLength);
      forceStateUpdate = false;
    }
  }

  double calculateDistanceInMeters(LatLng point1, LatLng point2) {
    var earthRadiusM = 6371000.0; // Earth's radius in meters

    var dLat = _degreesToRadians(point2.latitude - point1.latitude);
    var dLon = _degreesToRadians(point2.longitude - point1.longitude);

    var lat1 = _degreesToRadians(point1.latitude);
    var lat2 = _degreesToRadians(point2.latitude);

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * asin(sqrt(a));

    return earthRadiusM * c; // Return distance in meters
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  void initStateVariable() {
    routeState = container.read(routeStateProvider.notifier);
  }
}
