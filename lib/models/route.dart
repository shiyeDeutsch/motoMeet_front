import 'dart:math';
import 'dart:convert';

class NewRoute {
    String name;
    String description;
    GeoPoint startPoint;
    GeoPoint endPoint;
    RouteType routeType;
    double length;
    Duration duration;
    DifficultyLevel difficultyLevel;
    List<RoutePoint> routePoints;
    List<RouteTag> routeTags;

  NewRoute({
    required this.name,
    required this.description,
    required this.startPoint,
    required this.endPoint,
    required this.routeType,
    required this.length,
    required this.duration,
    required this.difficultyLevel,
    required this.routePoints,
    required this.routeTags,
  });

  factory NewRoute.fromJson(Map<String, dynamic> json) => NewRoute(
        name: json['name'],
        description: json['description'],
        startPoint: GeoPoint.fromJson(json['startPoint']),
        endPoint: GeoPoint.fromJson(json['endPoint']),
        routeType: RouteType.fromJson(json['routeType']),
        length: json['length'].toDouble(),
        duration: Duration(minutes: json['duration'] as int), // Assuming duration is in minutes
        difficultyLevel: DifficultyLevel.fromJson(json['difficultyLevel']),
        routePoints: List<RoutePoint>.from(json['routePoints'].map((x) => RoutePoint.fromJson(x))),
        routeTags: List<RouteTag>.from(json['routeTags'].map((x) => RouteTag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'startPoint': startPoint.toJson(),
        'endPoint': endPoint.toJson(),
        'routeType': routeType.toJson(),
        'length': length,
        'duration': duration.inMinutes, // Assuming you want to store duration in minutes
        'difficultyLevel': difficultyLevel.toJson(),
        'routePoints': List<dynamic>.from(routePoints.map((x) => x.toJson())),
        'routeTags': List<dynamic>.from(routeTags.map((x) => x.toJson())),
      };
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

class RouteType {
  final int id;
  final String name;

  RouteType({
    required this.id,
    required this.name,
  });
  factory RouteType.fromJson(Map<String, dynamic> json) => RouteType(
        id: json['id'],
        name: json['name'],
      );

  // Method for converting a RouteType instance to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
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

class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint({
    required this.latitude,
    required this.longitude,
  });
  factory GeoPoint.fromJson(Map<String, dynamic> json) => GeoPoint(
        latitude: json['latitude'].toDouble(),
        longitude: json['longitude'].toDouble(),
      );

  // Method for converting a GeoPoint instance to a map
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
