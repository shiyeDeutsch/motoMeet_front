import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/models/event.dart';
// import 'package:motomeetfront/models/route.dart';
import 'package:motomeetfront/models/enum.dart';

part 'UserRecentActivity.g.dart';



@collection
@JsonSerializable()
class UserRecentActivity {
  Id? id;
  @Enumerated(EnumType.name)
  final RecentActivityType activityType;
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

  UserRecentActivity({
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

  factory UserRecentActivity.fromJson(Map<String, dynamic> json) => 
    _$UserRecentActivityFromJson(json);

  Map<String, dynamic> toJson() => _$UserRecentActivityToJson(this);

  String get activityTypeString {
    switch (RecentActivityType) {
      case RecentActivityType.routeCompleted:
        return 'completed a route';
      case RecentActivityType.routeCreated:
        return 'created a new route';
      case RecentActivityType.eventJoined:
        return 'joined an event';
      case RecentActivityType.eventCreated:
        return 'created an event';
      case RecentActivityType.groupJoined:
        return 'joined a group';
      case RecentActivityType.groupCreated:
        return 'created a group';
      case RecentActivityType.followedUser:
        return 'started following';
      case RecentActivityType.achievement:
        return 'earned an achievement';
      case RecentActivityType.comment:
        return 'commented on';
      case RecentActivityType.like:
        return 'liked';
      default:
        return 'did something';
    }
  }

  String getActionText(String userName) {
    return '$userName ${activityTypeString}';
  }
}


