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

  // NEW FIELDS
  String? coverImageUrl;
  String? country;
  String? region;
  bool? isLoop;
  double? rating;
  String? natureReserveUrl;
  String? tips;

  @Enumerated(EnumType.name)
  DifficultyEnum? difficulty;

  @Ignore()
  List<Review>? reviews;

  @Ignore()
  List<RouteMedia>? media;

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
    required this.coverImageUrl,
    required this.country,
    required this.region,
    required this.isLoop,
    required this.rating,
    required this.natureReserveUrl,
    required this.tips,
    required this.difficulty,
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
        durationMinutes: json['durationMinutes'],
        coverImageUrl: json['coverImageUrl'],
        country: json['country'],
        region: json['region'],
        isLoop: json['isLoop'],
        rating: json['rating'],
        natureReserveUrl: json['natureReserveUrl'],
        tips: json['tips'],
        difficulty: DifficultyEnum.values.firstWhere((e) => e.name == json['difficulty']),
        routePoints: List<GeoPoint>.from(json['routePoints'].map((x) => GeoPoint.fromJson(x))),
        routeTags: List<TagEnum>.from(json['routeTags'].map((x) => TagEnum.values.firstWhere((e) => e.name == x))),
        pointOfInterest: List<Waypoint>.from(json['pointOfInterest'].map((x) => Waypoint.fromJson(x))),
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
        'coverImageUrl': coverImageUrl,
        'country': country,
        'region': region,
        'isLoop': isLoop,
        'rating': rating,
        'natureReserveUrl': natureReserveUrl,
        'tips': tips,
        'difficulty': difficulty?.name,
        'routePoints': routePoints != null ? List<dynamic>.from(routePoints!.map((x) => x.toJson())) : null,
        'routeTags': List<String>.from(routeTags.map((x) => x.name)),
        'pointOfInterest': pointOfInterest != null ? List<dynamic>.from(pointOfInterest!.map((x) => x.toJson())) : null,
      };

  NewRoute copyWith({
    String? name,
    String? description,
    GeoPoint? startPoint,
    GeoPoint? endPoint,
    RouteType? routeType,
    double? length,
    Duration? duration,
    String? coverImageUrl,
    String? country,
    String? region,
    bool? isLoop,
    double? rating,
    String? natureReserveUrl,
    String? tips,
    DifficultyEnum? difficulty,
    List<GeoPoint>? routePoints,
    List<TagEnum>? routeTags,
    bool? isActive,
    bool? isComplited,
    DateTime? startDate,
    DateTime? endDate,
    int? durationMinutes,
    Id? isarId,
    List<Waypoint>? pointOfInterest,
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
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      country: country ?? this.country,
      region: region ?? this.region,
      isLoop: isLoop ?? this.isLoop,
      rating: rating ?? this.rating,
      natureReserveUrl: natureReserveUrl ?? this.natureReserveUrl,
      tips: tips ?? this.tips,
      difficulty: difficulty ?? this.difficulty,
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

 
 
 class Review {
  final int id;
  final String username;
  final double rating;
  final String comment;
  final DateTime date;
  final int routeId;
 final String review;

Review({
  required this.id,
  required this.username,
  required this.rating,
  required this.comment,
  required this.date,
  required this.routeId,
  required this.review,
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
 
class RouteMedia {
  final String url;     // The URL/path to the image/video
  final String type;    // "image", "video", or "live"
  final String? title;  // Optional: title or caption
  final String? owner;  // Optional: user who uploaded it
  final DateTime? uploadedOn; // When was it uploaded?

  RouteMedia({
    required this.url,
    required this.type,
    this.title,
    this.owner,
    this.uploadedOn,
  });

  factory RouteMedia.fromJson(Map<String, dynamic> json) => RouteMedia(
    url: json['url'],
    type: json['type'],
    title: json['title'],
    owner: json['owner'],
    uploadedOn: json['uploadedOn'] != null
        ? DateTime.parse(json['uploadedOn'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'type': type,
    'title': title,
    'owner': owner,
    'uploadedOn': uploadedOn?.toIso8601String(),
  };
}
class WeatherForecast {
  final DateTime date;
  final double temperature; 
  final double windSpeed;
  final double humidity;
  final double precipitation;
  final String condition; // "Cloudy", "Sunny", etc.

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.precipitation,
    required this.condition,
  });
}
