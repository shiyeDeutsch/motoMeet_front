import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:isar/isar.dart';
import 'package:motomeetfront/models/enum.dart';
import '../utilities/isarConverters.dart';
import 'enum.dart';
import 'package:json_annotation/json_annotation.dart';

//  part 'new_route.g.dart'; // Ensure this part directive is included for generated code
part 'route.g.dart';

@collection
class NewRoute {
  Id? isarId;
  String name;
  String? description;
  GeoPoint startPoint;
  GeoPoint? endPoint;
  RouteType? routeType;
  double? length;
  int? durationMinutes;
  // DifficultyLevel difficultyLevel;
  List<GeoPoint>? routePoints;
  @Enumerated(EnumType.name)
  List<TagEnum> routeTags;
  bool isActive;
  bool isComplited;
  DateTime startDate;
  DateTime? endDate;
  List<Waypoint>? pointOfInterest;
  NewRoute({
    required this.isarId,
    required this.name,
    required this.description,
    required this.startPoint,
    required this.endPoint,
    required this.routeType,
    required this.length,
    required this.durationMinutes,
    required this.routePoints,
    required this.routeTags,
    required this.isActive,
    required this.isComplited,
    required this.startDate,
    required this.endDate,
    required this.pointOfInterest,
  });
  @Ignore()
  Duration? get routeDuration {
    if (durationMinutes != null) return Duration(minutes: durationMinutes!);
    return null;
  }

  set routeDuration(Duration? duration) {
    durationMinutes = duration!.inMilliseconds;
  }

  factory NewRoute.fromJson(Map<String, dynamic> json) => NewRoute(
        isarId: json['isarId'],
        name: json['name'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        isActive: json['isActive'],
        isComplited: json['isComplited'],
        description: json['description'],
        startPoint: GeoPoint.fromJson(json['startPoint']),
        endPoint: GeoPoint.fromJson(json['endPoint']),
        routeType: RouteType.fromJson(json['routeType']),
        length: json['length'].toDouble(),
        durationMinutes:
            json['durationMinutes'], // Assuming duration is in minutes
        // difficultyLevel: DifficultyLevel.fromJson(json['difficultyLevel']),
        routePoints: List<GeoPoint>.from(
            json['routePoints'].map((x) => RoutePoint.fromJson(x))),
        routeTags: List<TagEnum>.from(
            json['routeTags'].map((x) => TageEnumExtension.fromString(x))),
        pointOfInterest:List<Waypoint>.from(
            json['pointOfInterest'].map((x) => Waypoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,

        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'isComplited': isComplited,
        'isActive': isActive,

        'startPoint': startPoint.toJson(),
        'endPoint': endPoint?.toJson(),
        'routeType': routeType?.toJson(),
        'length': length,
        'durationMinutes': durationMinutes,
        //'difficultyLevel': difficultyLevel.toJson(),
        'routePoints': routePoints != null
            ? List<dynamic>.from(routePoints!.map((x) => x.toJson()))
            : null,
        'routeTags': List<String>.from(routeTags.map((x) => x.name)),
      };
  NewRoute copyWith({
    String? name,
    String? description,
    GeoPoint? startPoint,
    GeoPoint? endPoint,
    RouteType? routeType,
    double? length,
    Duration? duration,
    DifficultyLevel? difficultyLevel,
    List<GeoPoint>? routePoints,
    List<TagEnum>? routeTags,
    bool? isActive,
    bool? isComplited,
    DateTime? startDate,
    DateTime? endDate,
    int? durationMinutes,
    Id? isarId,
    List<Waypoint>?pointOfInterest,
  }) {
    return NewRoute(
      isarId: isarId ?? this.isarId,
      name: name ?? this.name,
      isComplited: isComplited ?? this.isComplited,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      startPoint: startPoint ?? this.startPoint,
      endPoint: endPoint ?? this.endPoint,
      routeType: routeType ?? this.routeType,
      length: length ?? this.length,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      // difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      routePoints: routePoints ?? this.routePoints,
      routeTags: routeTags ?? this.routeTags,
      pointOfInterest: pointOfInterest ?? this.pointOfInterest,
    );
  }
}

@embedded
class Waypoint {
  final GeoPoint? location;
  final String imageUrl;
  final String name;
  final String description;
  @Enumerated(EnumType.name)
  final WaypointType? type;
  Waypoint({
    this.location,
    this.imageUrl = '',
    this.name = '',
    this.description = '',
    this.type,
  });

  // Method for converting a Waypoint instance to a map
  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'imageUrl': imageUrl,
        'name': name,
        'description': description,
        'type': type!.name,
      };

  // Factory constructor for creating a Waypoint instance from a map
  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        location: json['location'] != null
            ? GeoPoint.fromJson(json['location'])
            : null,
        imageUrl: json['imageUrl'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        type: json['type'] != null
            ? json['type'].map((x) => WaypointTypeExtension.fromString(x))
            : null,
      );
}

class Route {
  final int id;
  final int addedBy;
  final DateTime addedOn;
  final DateTime editOn;
  final String name;
  final String description;
  final GeoPoint startPoint;
  final GeoPoint endPoint;
  final int difficultyLevelId;
  final List<RouteType> routeTypes;
  final double length;
  final Duration duration;
  final double elevationGain;
  final double rating;
  // final DifficultyLevel difficultyLevel;
  final List<RoutePoint> routePoints;
  final List<RouteTag> routeTags;

  Route({
    required this.id,
    required this.addedBy,
    required this.addedOn,
    required this.editOn,
    required this.name,
    required this.description,
    required this.startPoint,
    required this.endPoint,
    required this.difficultyLevelId,
    required this.routeTypes,
    required this.length,
    required this.duration,
    required this.elevationGain,
    required this.rating,
    // required this.difficultyLevel,
    required this.routePoints,
    required this.routeTags,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json['id'],
        addedBy: json['addedBy'],
        addedOn: DateTime.parse(json['addedOn']),
        editOn: DateTime.parse(json['editOn']),
        name: json['name'],
        description: json['description'],
        startPoint: GeoPoint.fromJson(json['startPoint']),
        endPoint: GeoPoint.fromJson(json['endPoint']),
        difficultyLevelId: json['difficultyLevelId'],
        routeTypes: List<RouteType>.from(
            json['routeTypes'].map((x) => RouteType.fromJson(x))),
        length: json['length'].toDouble(),
        duration: Duration(
            minutes: json['duration']
                as int), // Assuming duration is stored in minutes in JSON
        elevationGain: json['elevationGain'].toDouble(),
        rating: json['rating'].toDouble(),
        // difficultyLevel: DifficultyLevel.fromJson(json['difficultyLevel']),
        routePoints: List<RoutePoint>.from(
            json['routePoints'].map((x) => RoutePoint.fromJson(x))),
        routeTags: List<RouteTag>.from(
            json['routeTags'].map((x) => RouteTag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'addedBy': addedBy,
        'addedOn': addedOn.toIso8601String(),
        'editOn': editOn.toIso8601String(),
        'name': name,
        'description': description,
        'startPoint': startPoint.toJson(),
        'endPoint': endPoint.toJson(),
        'difficultyLevelId': difficultyLevelId,
        'routeTypes': List<dynamic>.from(routeTypes.map((x) => x.toJson())),
        'length': length,
        'duration': duration
            .inMinutes, // Assuming you want to store duration in minutes
        'elevationGain': elevationGain,
        'rating': rating,
        // 'difficultyLevel': difficultyLevel.toJson(),
        'routePoints': List<dynamic>.from(routePoints.map((x) => x.toJson())),
        'routeTags': List<dynamic>.from(routeTags.map((x) => x.toJson())),
      };
}

class RoutePoint {
  final int id;
  final int routeId;
  final int sequenceNumber;
  final GeoPoint point;

  RoutePoint({
    required this.id,
    required this.routeId,
    required this.sequenceNumber,
    required this.point,
  });

  factory RoutePoint.fromJson(Map<String, dynamic> json) => RoutePoint(
        id: json['id'],
        routeId: json['routeId'],
        sequenceNumber: json['sequenceNumber'],
        // Ensure your GeoPoint class has a fromJson method similar to this one
        point: GeoPoint.fromJson(json['point']),
      );

  // Method for converting a RoutePoint instance to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'routeId': routeId,
        'sequenceNumber': sequenceNumber,
        // Ensure your GeoPoint class has a toJson method similar to this one
        'point': point.toJson(),
      };
}

class DifficultyLevel {
  final int id;
  final String level;
  final String description;
  final List<Route> routes;

  DifficultyLevel({
    required this.id,
    required this.level,
    required this.description,
    required this.routes,
  });

  // Factory constructor for creating a new DifficultyLevel instance from a map structure
  factory DifficultyLevel.fromJson(Map<String, dynamic> json) =>
      DifficultyLevel(
        id: json['id'],
        level: json['level'],
        description: json['description'],
        // Ensure your Route class has a fromJson constructor similar to this one
        routes: List<Route>.from(json['routes'].map((x) => Route.fromJson(x))),
      );

  // Method for converting a DifficultyLevel instance to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'level': level,
        'description': description,
        // Ensure your Route class has a toJson method similar to this one
        'routes': List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Review {
  final int id;
  final String username;
  final double rating;
  final String comment;
  final DateTime date;
  final int routeId;
  final Route route;

  Review({
    required this.id,
    required this.username,
    required this.rating,
    required this.comment,
    required this.date,
    required this.routeId,
    required this.route,
  });
}

@embedded
class RouteType {
  // final int id;
  @Enumerated(EnumType.name)
  final RouteTypeEnum? type;

  RouteType({
    //  required this.id,
    this.type,
  });
  factory RouteType.fromJson(Map<String, dynamic> json) => RouteType(
        //    id: json['id'],
        type: json['type'],
      );

  // Method for converting a RouteType instance to a map
  Map<String, dynamic> toJson() => {
        //   'id': id,
        'name': type?.name,
      };
}

class RouteTag {
  final int routeId;
  final Route route;
  final int tagId;
  final Tag tag;

  RouteTag({
    required this.routeId,
    required this.route,
    required this.tagId,
    required this.tag,
  });

  // Factory constructor for creating a new RouteTag instance from a map structure
  factory RouteTag.fromJson(Map<String, dynamic> json) => RouteTag(
        routeId: json['routeId'],
        // Ensure your Route class has a fromJson constructor
        route: Route.fromJson(json['route']),
        tagId: json['tagId'],
        // Ensure your Tag class has a fromJson constructor
        tag: Tag.fromJson(json['tag']),
      );

  // Method for converting a RouteTag instance to a map
  Map<String, dynamic> toJson() => {
        'routeId': routeId,
        // Ensure your Route class has a toJson method
        'route': route.toJson(),
        'tagId': tagId,
        // Ensure your Tag class has a toJson method
        'tag': tag.toJson(),
      };
}

class Tag {
  final int id;
  final String name;
  final List<RouteTag> routeTags;

  Tag({
    required this.id,
    required this.name,
    required this.routeTags,
  });
  // Factory constructor for creating a new Tag instance from a map structure
  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'],
        name: json['name'],
        // Ensure your RouteTag class has a fromJson constructor
        routeTags: List<RouteTag>.from(
            json['routeTags'].map((x) => RouteTag.fromJson(x))),
      );

  // Method for converting a Tag instance to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        // Ensure your RouteTag class has a toJson method
        'routeTags': List<dynamic>.from(routeTags.map((x) => x.toJson())),
      };
}

@embedded
class GeoPoint {
  final double? latitude;
  final double? longitude;
  final double? altitude;

  GeoPoint({
    this.latitude,
    this.longitude,
    this.altitude,
  });
  factory GeoPoint.fromJson(Map<String, dynamic> json) => GeoPoint(
        latitude: json['latitude'].toDouble(),
        longitude: json['longitude'].toDouble(),
        altitude: json['altitude'].toDouble() ?? false,
      );
  factory GeoPoint.fromLatLng(LatLng latLng, double? altitude) => GeoPoint(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      altitude: altitude);
  // Method for converting a GeoPoint instance to a map
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'altitude': altitude,
      };
  LatLng toLatLng() {
    return LatLng(latitude!, longitude!);
  }
}
