import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'newRoute.g.dart';

@collection
@JsonSerializable()
class Route {
  Id? id;
  String name;
  String? description;
  @Embedded()
  GeoPoint? startPoint;
  @Embedded()
  GeoPoint? endPoint;
  @Embedded()
  RouteType? routeType;
  @Embedded()
  DifficultyLevel? difficultyLevel;
  double? length;
  int? durationMinutes;
  double? elevationGain;
  double? rating;
  bool? isLoop;
  String? country;
  String? region;

  @JsonKey(ignore: true)
  IsarLinks<RoutePoint> routePoints = IsarLinks<RoutePoint>();
  
  @JsonKey(ignore: true)
  IsarLinks<Review> reviews = IsarLinks<Review>();
  
  @JsonKey(ignore: true)
  IsarLinks<Tag> tags = IsarLinks<Tag>();
  
  @JsonKey(ignore: true)
  IsarLinks<UserRoute> userRoutes = IsarLinks<UserRoute>();
  
  @JsonKey(ignore: true)
  IsarLinks<PointOfInterest> pointsOfInterest = IsarLinks<PointOfInterest>();

  Route({
    this.id,
    required this.name,
    this.description,
    this.startPoint,
    this.endPoint,
    this.routeType,
    this.difficultyLevel,
    this.length,
    this.durationMinutes,
    this.elevationGain,
    this.rating,
    this.isLoop,
    this.country,
    this.region,
  });

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);

  Route copyWith({
    Id? id,
    String? name,
    String? description,
    GeoPoint? startPoint,
    GeoPoint? endPoint,
    RouteType? routeType,
    DifficultyLevel? difficultyLevel,
    double? length,
    int? durationMinutes,
    double? elevationGain,
    double? rating,
    bool? isLoop,
    String? country,
    String? region,
  }) {
    return Route(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startPoint: startPoint ?? this.startPoint,
      endPoint: endPoint ?? this.endPoint,
      routeType: routeType ?? this.routeType,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      length: length ?? this.length,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      elevationGain: elevationGain ?? this.elevationGain,
      rating: rating ?? this.rating,
      isLoop: isLoop ?? this.isLoop,
      country: country ?? this.country,
      region: region ?? this.region,
    );
  }
}

@embedded
@JsonSerializable()
class GeoPoint {
  double? latitude;
  double? longitude;
  double? altitude;

  GeoPoint({this.latitude, this.longitude, this.altitude});

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoPointToJson(this);

  GeoPoint copyWith({
    double? latitude,
    double? longitude,
    double? altitude,
  }) {
    return GeoPoint(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
    );
  }
}

@embedded
@JsonSerializable()
class RouteType {
  String? name;

  RouteType({this.name});

  factory RouteType.fromJson(Map<String, dynamic> json) =>
      _$RouteTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RouteTypeToJson(this);

  RouteType copyWith({
    String? name,
  }) {
    return RouteType(
      name: name ?? this.name,
    );
  }
}

@embedded
@JsonSerializable()
class DifficultyLevel {
  String? level;
  String? description;

  DifficultyLevel({this.level, this.description});

  factory DifficultyLevel.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyLevelToJson(this);

  DifficultyLevel copyWith({
    String? level,
    String? description,
  }) {
    return DifficultyLevel(
      level: level ?? this.level,
      description: description ?? this.description,
    );
  }
}

@collection
@JsonSerializable()
class RoutePoint {
  Id? id;
  int? sequenceNumber;
  @Embedded()
  GeoPoint? point;

  RoutePoint({this.id, this.sequenceNumber, this.point});

  factory RoutePoint.fromJson(Map<String, dynamic> json) =>
      _$RoutePointFromJson(json);

  Map<String, dynamic> toJson() => _$RoutePointToJson(this);

  RoutePoint copyWith({
    Id? id,
    int? sequenceNumber,
    GeoPoint? point,
  }) {
    return RoutePoint(
      id: id ?? this.id,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      point: point ?? this.point,
    );
  }
}

@collection
@JsonSerializable()
class Review {
  Id? id;
  String? username;
  double? rating;
  String? comment;
  DateTime? date;

  Review({this.id, this.username, this.rating, this.comment, this.date});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  Review copyWith({
    Id? id,
    String? username,
    double? rating,
    String? comment,
    DateTime? date,
  }) {
    return Review(
      id: id ?? this.id,
      username: username ?? this.username,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
    );
  }
}

@collection
@JsonSerializable()
class Tag {
  Id? id;
  String? name;

  Tag({this.id, this.name});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  Tag copyWith({
    Id? id,
    String? name,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

@collection
@JsonSerializable()
class UserRoute {
  Id? id;
  @Embedded()
  DifficultyLevel? difficultyLevel;
  @Embedded()
  RouteType? routeType;
  DateTime? dateTraveled;
  int? durationMinutes;
  double? distance;
  double? elevationGain;

  @JsonKey(ignore: true)
  IsarLinks<UserRoutePoint> userRoutePoints = IsarLinks<UserRoutePoint>();

  UserRoute({
    this.id,
    this.difficultyLevel,
    this.routeType,
    this.dateTraveled,
    this.durationMinutes,
    this.distance,
    this.elevationGain,
  });

  factory UserRoute.fromJson(Map<String, dynamic> json) =>
      _$UserRouteFromJson(json);

  Map<String, dynamic> toJson() => _$UserRouteToJson(this);

  UserRoute copyWith({
    Id? id,
    DifficultyLevel? difficultyLevel,
    RouteType? routeType,
    DateTime? dateTraveled,
    int? durationMinutes,
    double? distance,
    double? elevationGain,
  }) {
    return UserRoute(
      id: id ?? this.id,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      routeType: routeType ?? this.routeType,
      dateTraveled: dateTraveled ?? this.dateTraveled,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      distance: distance ?? this.distance,
      elevationGain: elevationGain ?? this.elevationGain,
    );
  }
}

@collection
@JsonSerializable()
class UserRoutePoint {
  Id? id;
  int? sequenceNumber;
  @Embedded()
  GeoPoint? point;

  UserRoutePoint({this.id, this.sequenceNumber, this.point});

  factory UserRoutePoint.fromJson(Map<String, dynamic> json) =>
      _$UserRoutePointFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoutePointToJson(this);

  UserRoutePoint copyWith({
    Id? id,
    int? sequenceNumber,
    GeoPoint? point,
  }) {
    return UserRoutePoint(
      id: id ?? this.id,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      point: point ?? this.point,
    );
  }
}

@collection
@JsonSerializable()
class PointOfInterest {
  Id? id;
  @Embedded()
  GeoPoint? location;
  String? imageUrl;
  String? name;
  String? description;
  @Enumerated(EnumType.name)
  WaypointType? waypointType;

  PointOfInterest({
    this.id,
    this.location,
    this.imageUrl,
    this.name,
    this.description,
    this.waypointType,
  });

  factory PointOfInterest.fromJson(Map<String, dynamic> json) =>
      _$PointOfInterestFromJson(json);

  Map<String, dynamic> toJson() => _$PointOfInterestToJson(this);

  PointOfInterest copyWith({
    Id? id,
    GeoPoint? location,
    String? imageUrl,
    String? name,
    String? description,
    WaypointType? waypointType,
  }) {
    return PointOfInterest(
      id: id ?? this.id,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      waypointType: waypointType ?? this.waypointType,
    );
  }
}

enum WaypointType {
  Lake,
  Cliff,
  Waterfall,
  WaterSpring,
  River,
  MountainPeak,
  Forest,
  Meadow,
  Cave,
  Valley,
  Beach,
  Glacier,
  Volcano,
  HistoricalSite,
  VisitorCenter,
  Viewpoint,
  Museum,
  CulturalSite,
  EducationalTrail,
  ParkOffice,
  SteepDrop,
  SlipperyPath,
  HighTide,
  WildlifeSighting,
  FloodingArea,
  Rockfall,
  RestrictedArea
}