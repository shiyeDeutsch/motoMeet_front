import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/route.dart';

part 'activity.g.dart';

enum ActivityType {
  routeCompleted,
  routeCreated,
  eventJoined,
  eventCreated,
  groupJoined,
  groupCreated,
  followedUser,
  achievement,
  comment,
  like,
}

@collection
@JsonSerializable()
class UserActivity {
  Id? id;
  @Enumerated(EnumType.name)
  final ActivityType activityType;
  final DateTime timestamp;
  final String? message;
  final String? imageUrl;
  
  // Foreign keys/IDs
  final int? routeId;
  final int? eventId;
  final int? groupId;
  final int? targetUserId;
  
  // Whether this activity has been read/viewed by the user
  final bool isRead;
  
  @JsonKey(ignore: true)
  IsarLink<UserInfo> user = IsarLink<UserInfo>();

  UserActivity({
    this.id,
    required this.activityType,
    required this.timestamp,
    this.message,
    this.imageUrl,
    this.routeId,
    this.eventId,
    this.groupId,
    this.targetUserId,
    this.isRead = false,
  });

  factory UserActivity.fromJson(Map<String, dynamic> json) => 
    _$UserActivityFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivityToJson(this);

  String get activityTypeString {
    switch (activityType) {
      case ActivityType.routeCompleted:
        return 'completed a route';
      case ActivityType.routeCreated:
        return 'created a new route';
      case ActivityType.eventJoined:
        return 'joined an event';
      case ActivityType.eventCreated:
        return 'created an event';
      case ActivityType.groupJoined:
        return 'joined a group';
      case ActivityType.groupCreated:
        return 'created a group';
      case ActivityType.followedUser:
        return 'started following';
      case ActivityType.achievement:
        return 'earned an achievement';
      case ActivityType.comment:
        return 'commented on';
      case ActivityType.like:
        return 'liked';
      default:
        return 'did something';
    }
  }

  String getActionText(String userName) {
    return '$userName ${activityTypeString}';
  }
}


