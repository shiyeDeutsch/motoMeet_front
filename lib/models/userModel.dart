import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'group.dart';
import 'newRoute.dart';
import 'notification.dart';

part 'userModel.g.dart';

@collection
@JsonSerializable()
class UserInfo {
  Id? id;
  String? username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  DateTime? addedOn;
  DateTime? editOn;
  String? profilePictureUrl;
  String? bio;
  String? address;
  String? email;
  int? countryId;
  double? totalDistance;
  String? token; // Add token field back

  @JsonKey(ignore: true)
  IsarLinks<UserInfoFollow> followers = IsarLinks<UserInfoFollow>();
  
  @JsonKey(ignore: true)
  IsarLinks<UserInfoFollow> following = IsarLinks<UserInfoFollow>();
  
  @JsonKey(ignore: true)
  IsarLinks<GroupMember> groupMemberships = IsarLinks<GroupMember>();
  
  @JsonKey(ignore: true)
  IsarLinks<Route> createdRoutes = IsarLinks<Route>();
  
  @JsonKey(ignore: true)
  IsarLinks<Event> createdEvents = IsarLinks<Event>();
  
  @JsonKey(ignore: true)
  IsarLinks<Notification> notificationsReceived = IsarLinks<Notification>();
  
  @JsonKey(ignore: true)
  IsarLinks<Reaction> reactions = IsarLinks<Reaction>();
  
  @JsonKey(ignore: true)
  IsarLinks<Favorite> favorites = IsarLinks<Favorite>();

  UserInfo({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.addedOn,
    this.editOn,
    this.profilePictureUrl,
    this.bio,
    this.address,
    this.email,
    this.countryId,
    this.totalDistance,
    this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo copyWith({
    Id? id,
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? addedOn,
    DateTime? editOn,
    String? profilePictureUrl,
    String? bio,
    String? address,
    String? email,
    int? countryId,
    double? totalDistance,
    String? token,
  }) {
    return UserInfo(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addedOn: addedOn ?? this.addedOn,
      editOn: editOn ?? this.editOn,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      email: email ?? this.email,
      countryId: countryId ?? this.countryId,
      totalDistance: totalDistance ?? this.totalDistance,
      token: token ?? this.token,
    );
  }
}

@collection
@JsonSerializable()
class UserInfoFollow {
  Id? id;

  @JsonKey(ignore: true)
  IsarLink<UserInfo> follower = IsarLink<UserInfo>();
  
  @JsonKey(ignore: true)
  IsarLink<UserInfo> following = IsarLink<UserInfo>();

  DateTime? followedOn;

  UserInfoFollow({
    this.id,
    this.followedOn,
  });

  factory UserInfoFollow.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFollowFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoFollowToJson(this);

  UserInfoFollow copyWith({
    Id? id,
    UserInfo? follower,
    UserInfo? following,
    DateTime? followedOn,
  }) {
    return UserInfoFollow(
      id: id ?? this.id,
      followedOn: followedOn ?? this.followedOn,
    );
  }
}

@collection
@JsonSerializable()
class Favorite {
  Id? id;
  String? type;
  String? itemId;
  DateTime? addedAt;

  @JsonKey(ignore: true)
  IsarLink<UserInfo> user = IsarLink<UserInfo>();  // Changed from UserInfo to user

  Favorite({
    this.id,
    this.type,
    this.itemId,
    this.addedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);

  Favorite copyWith({
    Id? id,
    String? type,
    String? itemId,
    DateTime? addedAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      type: type ?? this.type,
      itemId: itemId ?? this.itemId,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
