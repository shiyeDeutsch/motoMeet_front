import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_models.g.dart';

@collection
@JsonSerializable()
class Event {
  Id? id;
  String? name;
  String? description;
  bool? isPublic;
  bool? requiresApproval;
  DateTime? startDateTime;
  DateTime? endDateTime;

  IsarLink<UserInfo> creator = IsarLink<UserInfo>();
  IsarLink<Group> group = IsarLink<Group>();

  IsarLinks<EventItem> requiredItems = IsarLinks<EventItem>();
  IsarLinks<EventParticipant> participants = IsarLinks<EventParticipant>();
  IsarLinks<EventStage> stages = IsarLinks<EventStage>();
  IsarLinks<EventActivity> eventActivities = IsarLinks<EventActivity>();

  Event({
    this.id,
    this.name,
    this.description,
    this.isPublic,
    this.requiresApproval,
    this.startDateTime,
    this.endDateTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    Id? id,
    String? name,
    String? description,
    bool? isPublic,
    bool? requiresApproval,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
    );
  }
}

@collection
@JsonSerializable()
class EventStage {
  Id? id;
  String? title;
  String? description;
  DateTime? stageStartTime;
  @Embedded()
  RouteType? route;
  @Enumerated(EnumType.name)
  EventStageType? stageType;
  @Embedded()
  GeoPoint? location;

  IsarLink<Event> event = IsarLink<Event>();

  IsarLinks<EventStageParticipant> stageParticipants =
      IsarLinks<EventStageParticipant>();

  EventStage({
    this.id,
    this.title,
    this.description,
    this.stageStartTime,
    this.route,
    this.stageType,
    this.location,
  });

  factory EventStage.fromJson(Map<String, dynamic> json) =>
      _$EventStageFromJson(json);

  Map<String, dynamic> toJson() => _$EventStageToJson(this);

  EventStage copyWith({
    Id? id,
    String? title,
    String? description,
    DateTime? stageStartTime,
    RouteType? route,
    EventStageType? stageType,
    GeoPoint? location,
  }) {
    return EventStage(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      stageStartTime: stageStartTime ?? this.stageStartTime,
      route: route ?? this.route,
      stageType: stageType ?? this.stageType,
      location: location ?? this.location,
    );
  }
}

enum EventStageType {
  RouteSegment,
  MeetingPoint,
  OvernightStop,
  LunchStop,
  Activity
}

@collection
@JsonSerializable()
class EventParticipant {
  Id? id;
  bool? isApproved;
  bool? isActive;
  DateTime? joinedOn;

  IsarLink<UserInfo> person = IsarLink<UserInfo>();
  IsarLink<Event> event = IsarLink<Event>();

  IsarLinks<EventStageParticipant> stageParticipants =
      IsarLinks<EventStageParticipant>();

  EventParticipant({
    this.id,
    this.isApproved,
    this.isActive,
    this.joinedOn,
  });

  factory EventParticipant.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$EventParticipantToJson(this);

  EventParticipant copyWith({
    Id? id,
    bool? isApproved,
    bool? isActive,
    DateTime? joinedOn,
  }) {
    return EventParticipant(
      id: id ?? this.id,
      isApproved: isApproved ?? this.isApproved,
      isActive: isActive ?? this.isActive,
      joinedOn: joinedOn ?? this.joinedOn,
    );
  }
}

@collection
@JsonSerializable()
class EventStageParticipant {
  Id? id;
  DateTime? startedAt;
  DateTime? finishedAt;
  bool? isCompleted;

  IsarLink<EventStage> eventStage = IsarLink<EventStage>();
  IsarLink<EventParticipant> eventParticipant = IsarLink<EventParticipant>();
  IsarLink<UserRoute> userRoute = IsarLink<UserRoute>();

  EventStageParticipant({
    this.id,
    this.startedAt,
    this.finishedAt,
    this.isCompleted,
  });

  factory EventStageParticipant.fromJson(Map<String, dynamic> json) =>
      _$EventStageParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$EventStageParticipantToJson(this);

  EventStageParticipant copyWith({
    Id? id,
    DateTime? startedAt,
    DateTime? finishedAt,
    bool? isCompleted,
  }) {
    return EventStageParticipant(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

@collection
@JsonSerializable()
class ActivityType {
  Id? id;
  String? name;

  IsarLinks<EventActivity> eventActivities = IsarLinks<EventActivity>();
  IsarLinks<GroupActivity> groupActivities = IsarLinks<GroupActivity>();

  ActivityType({
    this.id,
    this.name,
  });

  factory ActivityType.fromJson(Map<String, dynamic> json) =>
      _$ActivityTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTypeToJson(this);

  ActivityType copyWith({
    Id? id,
    String? name,
  }) {
    return ActivityType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

@collection
@JsonSerializable()
class EventActivity {
  Id? id;
  @Embedded()
  ActivityType? activityType;

  EventActivity({
    this.id,
    this.activityType,
  });

  factory EventActivity.fromJson(Map<String, dynamic> json) =>
      _$EventActivityFromJson(json);

  Map<String, dynamic> toJson() => _$EventActivityToJson(this);

  EventActivity copyWith({
    Id? id,
    ActivityType? activityType,
  }) {
    return EventActivity(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
    );
  }
}

@collection
@JsonSerializable()
class EventItem {
  Id? id;
  String? itemName;
  String? description;
  bool? isAssigned;

  IsarLink<Event> event = IsarLink<Event>();

  EventItem({
    this.id,
    this.itemName,
    this.description,
    this.isAssigned,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) =>
      _$EventItemFromJson(json);

  Map<String, dynamic> toJson() => _$EventItemToJson(this);

  EventItem copyWith({
    Id? id,
    String? itemName,
    String? description,
    bool? isAssigned,
  }) {
    return EventItem(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      isAssigned: isAssigned ?? this.isAssigned,
    );
  }
}
