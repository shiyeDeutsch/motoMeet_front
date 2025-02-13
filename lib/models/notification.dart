import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

 
@collection
@JsonSerializable()
class Notification {
  Id? id;
  String? type;
  String? content;
  DateTime? sentAt;
  bool? isRead;

  IsarLink<UserInfo> recipient = IsarLink<UserInfo>();
  IsarLink<UserInfo> actor = IsarLink<UserInfo>();

  Notification({
    this.id,
    this.type,
    this.content,
    this.sentAt,
    this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification copyWith({
    Id? id,
    String? type,
    String? content,
    DateTime? sentAt,
    bool? isRead,
  }) {
    return Notification(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
    );
  }
}

@collection
@JsonSerializable()
class Reaction {
  Id? id;
  String? type;
  DateTime? reactedAt;

  IsarLink<UserInfo> person = IsarLink<UserInfo>();
  IsarLink<GroupPost> groupPost = IsarLink<GroupPost>();

  Reaction({
    this.id,
    this.type,
    this.reactedAt,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionToJson(this);

  Reaction copyWith({
    Id? id,
    String? type,
    DateTime? reactedAt,
  }) {
    return Reaction(
      id: id ?? this.id,
      type: type ?? this.type,
      reactedAt: reactedAt ?? this.reactedAt,
    );
  }
}
