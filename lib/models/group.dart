import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'userModel.dart';
import 'event.dart';
import 'notification.dart';  // for Reaction class
 
part 'group.g.dart';

@collection
@JsonSerializable()
class Group {
  Id? id;
  String? name;
  String? description;
  String? location;
  bool? isPublic;
  bool? isApprovalRequired;

  @JsonKey(ignore: true)
  IsarLink<UserInfo> creator = IsarLink<UserInfo>();

  @JsonKey(ignore: true)
  IsarLinks<GroupMember> members = IsarLinks<GroupMember>();
  
  @JsonKey(ignore: true)
  IsarLinks<GroupPost> posts = IsarLinks<GroupPost>();
  
  @JsonKey(ignore: true)
  IsarLinks<Event> events = IsarLinks<Event>();
  
  @JsonKey(ignore: true)
  IsarLinks<GroupActivity> groupActivities = IsarLinks<GroupActivity>();

  Group({
    this.id,
    this.name,
    this.description,
    this.location,
    this.isPublic,
    this.isApprovalRequired,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    Id? id,
    String? name,
    String? description,
    String? location,
    bool? isPublic,
    bool? isApprovalRequired,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      isPublic: isPublic ?? this.isPublic,
      isApprovalRequired: isApprovalRequired ?? this.isApprovalRequired,
    );
  }
}

@collection
@JsonSerializable()
class GroupMember {
  Id? id;
  bool? isAdmin;
  bool? canPost;
  bool? isApproved;
  DateTime? joinedOn;

  @JsonKey(ignore: true)
  IsarLink<UserInfo> person = IsarLink<UserInfo>();
  
  @JsonKey(ignore: true)
  IsarLink<Group> group = IsarLink<Group>();

  GroupMember({
    this.id,
    this.isAdmin,
    this.canPost,
    this.isApproved,
    this.joinedOn,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);

  GroupMember copyWith({
    Id? id,
    bool? isAdmin,
    bool? canPost,
    bool? isApproved,
    DateTime? joinedOn,
  }) {
    return GroupMember(
      id: id ?? this.id,
      isAdmin: isAdmin ?? this.isAdmin,
      canPost: canPost ?? this.canPost,
      isApproved: isApproved ?? this.isApproved,
      joinedOn: joinedOn ?? this.joinedOn,
    );
  }
}

@collection
@JsonSerializable()
class GroupActivity {
  Id? id;
  String? activityTypeName;  // Using a simple String instead of embedded type

  GroupActivity({
    this.id,
    this.activityTypeName,
  });

  factory GroupActivity.fromJson(Map<String, dynamic> json) =>
      _$GroupActivityFromJson(json);

  Map<String, dynamic> toJson() => _$GroupActivityToJson(this);

  GroupActivity copyWith({
    Id? id,
    String? activityTypeName,
  }) {
    return GroupActivity(
      id: id ?? this.id,
      activityTypeName: activityTypeName ?? this.activityTypeName,
    );
  }
}

@collection
@JsonSerializable()
class GroupPost {
  Id? id;
  String? content;
  DateTime? createdOn;

  @JsonKey(ignore: true)
  IsarLink<UserInfo> author = IsarLink<UserInfo>();
  
  @JsonKey(ignore: true)
  IsarLink<Group> group = IsarLink<Group>();

  @JsonKey(ignore: true)
  IsarLinks<GroupPostAttachment> attachments = IsarLinks<GroupPostAttachment>();
  
  @JsonKey(ignore: true)
  IsarLinks<GroupPostComment> comments = IsarLinks<GroupPostComment>();
  
  @JsonKey(ignore: true)
  IsarLinks<Reaction> reactions = IsarLinks<Reaction>();

  GroupPost({
    this.id,
    this.content,
    this.createdOn,
  });

  factory GroupPost.fromJson(Map<String, dynamic> json) =>
      _$GroupPostFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPostToJson(this);

  GroupPost copyWith({
    Id? id,
    String? content,
    DateTime? createdOn,
  }) {
    return GroupPost(
      id: id ?? this.id,
      content: content ?? this.content,
      createdOn: createdOn ?? this.createdOn,
    );
  }
}

@collection
@JsonSerializable()
class GroupPostComment {
  Id? id;
  String? content;
  DateTime? createdOn;

  @JsonKey(ignore: true)
  IsarLink<UserInfo> author = IsarLink<UserInfo>();
  
  @JsonKey(ignore: true)
  IsarLink<GroupPost> groupPost = IsarLink<GroupPost>();

  GroupPostComment({
    this.id,
    this.content,
    this.createdOn,
  });

  factory GroupPostComment.fromJson(Map<String, dynamic> json) =>
      _$GroupPostCommentFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPostCommentToJson(this);

  GroupPostComment copyWith({
    Id? id,
    String? content,
    DateTime? createdOn,
  }) {
    return GroupPostComment(
      id: id ?? this.id,
      content: content ?? this.content,
      createdOn: createdOn ?? this.createdOn,
    );
  }
}

@collection
@JsonSerializable()
class GroupPostAttachment {
  Id? id;
  String? fileUrl;
  String? attachmentType;
  DateTime? uploadedOn;

  @JsonKey(ignore: true)
  IsarLink<GroupPost> groupPost = IsarLink<GroupPost>();

  GroupPostAttachment({
    this.id,
    this.fileUrl,
    this.attachmentType,
    this.uploadedOn,
  });

  factory GroupPostAttachment.fromJson(Map<String, dynamic> json) =>
      _$GroupPostAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPostAttachmentToJson(this);

  GroupPostAttachment copyWith({
    Id? id,
    String? fileUrl,
    String? attachmentType,
    DateTime? uploadedOn,
  }) {
    return GroupPostAttachment(
      id: id ?? this.id,
      fileUrl: fileUrl ?? this.fileUrl,
      attachmentType: attachmentType ?? this.attachmentType,
      uploadedOn: uploadedOn ?? this.uploadedOn,
    );
  }
}
