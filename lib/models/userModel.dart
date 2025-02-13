import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_models.g.dart';

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

  IsarLinks<PersonFollow> followers = IsarLinks<PersonFollow>();
  IsarLinks<PersonFollow> following = IsarLinks<PersonFollow>();
  IsarLinks<GroupMember> groupMemberships = IsarLinks<GroupMember>();
  IsarLinks<Route> createdRoutes = IsarLinks<Route>();
  IsarLinks<Event> createdEvents = IsarLinks<Event>();
  IsarLinks<Notification> notificationsReceived = IsarLinks<Notification>();
  IsarLinks<Reaction> reactions = IsarLinks<Reaction>();
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
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

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
    );
  }
}
@collection
@JsonSerializable()
class PersonFollow {
  Id? id;

  IsarLink<UserInfo> follower = IsarLink<UserInfo>();
  IsarLink<UserInfo> following = IsarLink<UserInfo>();

  DateTime? followedOn;

  PersonFollow({
    this.id,
    this.followedOn,
  });

  factory PersonFollow.fromJson(Map<String, dynamic> json) =>
      _$PersonFollowFromJson(json);

  Map<String, dynamic> toJson() => _$PersonFollowToJson(this);

  PersonFollow copyWith({
    Id? id,
    UserInfo? follower,
    UserInfo? following,
    DateTime? followedOn,
  }) {
    return PersonFollow(
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

  IsarLink<UserInfo> person = IsarLink<UserInfo>();

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