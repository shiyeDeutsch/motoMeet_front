import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motomeetfront/models/route.dart';
import 'package:motomeetfront/models/userModel.dart';

part 'locationShare.g.dart';

@collection
@JsonSerializable()
class SharedLocation {
  Id? id;
  
  @JsonKey(name: 'userId')
  String? userId;
  
  @JsonKey(name: 'userName')
  String? userName;
  
  @JsonKey(name: 'latitude')
  double? latitude;
  
  @JsonKey(name: 'longitude')
  double? longitude;
  
  @JsonKey(name: 'altitude')
  double? altitude;
  
  @JsonKey(name: 'heading')
  double? heading;
  
  @JsonKey(name: 'speed')
  double? speed;
  
  @JsonKey(name: 'accuracy')
  double? accuracy;
  
  @JsonKey(name: 'lastUpdated')
  DateTime? lastUpdated;
  
  @JsonKey(name: 'sharingSessionId')
  String? sharingSessionId;
  
  @JsonKey(name: 'routeId')
  String? routeId;

  // For UI display and grouping (not persisted)
  @Ignore()
  double? distanceFromUser;
  
  @Ignore()
  @JsonKey(ignore: true)
  IsarLink<UserInfo> user = IsarLink<UserInfo>();

  SharedLocation({
    this.id,
    this.userId,
    this.userName,
    this.latitude,
    this.longitude,
    this.altitude,
    this.heading,
    this.speed,
    this.accuracy,
    this.lastUpdated,
    this.sharingSessionId,
    this.routeId,
    this.distanceFromUser,
  });

  factory SharedLocation.fromJson(Map<String, dynamic> json) =>
      _$SharedLocationFromJson(json);

  Map<String, dynamic> toJson() => _$SharedLocationToJson(this);

  // Helper method to create from a Position
  factory SharedLocation.fromPosition({
    required String userId,
    required String userName,
    required double latitude,
    required double longitude,
    double? altitude,
    double? heading,
    double? speed,
    double? accuracy,
    String? sharingSessionId,
    String? routeId,
  }) {
    return SharedLocation(
      userId: userId,
      userName: userName,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
      heading: heading,
      speed: speed,
      accuracy: accuracy,
      lastUpdated: DateTime.now(),
      sharingSessionId: sharingSessionId,
      routeId: routeId,
    );
  }

  // Convert to GeoPoint for map display
  GeoPoint toGeoPoint() {
    return GeoPoint(
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
    );
  }

  SharedLocation copyWith({
    Id? id,
    String? userId,
    String? userName,
    double? latitude,
    double? longitude,
    double? altitude,
    double? heading,
    double? speed,
    double? accuracy,
    DateTime? lastUpdated,
    String? sharingSessionId,
    String? routeId,
    double? distanceFromUser,
  }) {
    return SharedLocation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      accuracy: accuracy ?? this.accuracy,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      sharingSessionId: sharingSessionId ?? this.sharingSessionId,
      routeId: routeId ?? this.routeId,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }
}

@collection
@JsonSerializable()
class LocationSharingSession {
  Id? id;
  
  @JsonKey(name: 'sessionId')
  String? sessionId;
  
  @JsonKey(name: 'createdById')
  String? createdById;
  
  @JsonKey(name: 'name')
  String? name;
  
  @JsonKey(name: 'routeId')
  String? routeId;
  
  @JsonKey(name: 'startTime')
  DateTime? startTime;
  
  @JsonKey(name: 'endTime')
  DateTime? endTime;
  
  @JsonKey(name: 'isActive')
  bool? isActive;
  
  @JsonKey(name: 'isPublic')
  bool? isPublic;
  
  @JsonKey(name: 'shareCode')
  String? shareCode;
  
  @Ignore()
  @JsonKey(ignore: true)
  IsarLinks<SharedLocation> locations = IsarLinks<SharedLocation>();
  
  @Ignore()
  @JsonKey(ignore: true)
  IsarLink<UserInfo> createdBy = IsarLink<UserInfo>();

  LocationSharingSession({
    this.id,
    this.sessionId,
    this.createdById,
    this.name,
    this.routeId,
    this.startTime,
    this.endTime,
    this.isActive,
    this.isPublic,
    this.shareCode,
  });

  factory LocationSharingSession.fromJson(Map<String, dynamic> json) =>
      _$LocationSharingSessionFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSharingSessionToJson(this);

  LocationSharingSession copyWith({
    Id? id,
    String? sessionId,
    String? createdById,
    String? name,
    String? routeId,
    DateTime? startTime,
    DateTime? endTime,
    bool? isActive,
    bool? isPublic,
    String? shareCode,
  }) {
    return LocationSharingSession(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      createdById: createdById ?? this.createdById,
      name: name ?? this.name,
      routeId: routeId ?? this.routeId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
      isPublic: isPublic ?? this.isPublic,
      shareCode: shareCode ?? this.shareCode,
    );
  }
} 