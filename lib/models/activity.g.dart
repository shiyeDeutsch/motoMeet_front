// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserRecentActivityCollection on Isar {
  IsarCollection<UserRecentActivity> get userRecentActivitys =>
      this.collection();
}

const UserRecentActivitySchema = CollectionSchema(
  name: r'UserRecentActivity',
  id: -3155119119402037086,
  properties: {
    r'activityType': PropertySchema(
      id: 0,
      name: r'activityType',
      type: IsarType.string,
      enumMap: _UserRecentActivityactivityTypeEnumValueMap,
    ),
    r'activityTypeString': PropertySchema(
      id: 1,
      name: r'activityTypeString',
      type: IsarType.string,
    ),
    r'eventId': PropertySchema(
      id: 2,
      name: r'eventId',
      type: IsarType.long,
    ),
    r'groupId': PropertySchema(
      id: 3,
      name: r'groupId',
      type: IsarType.long,
    ),
    r'imageUrl': PropertySchema(
      id: 4,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'isRead': PropertySchema(
      id: 5,
      name: r'isRead',
      type: IsarType.bool,
    ),
    r'message': PropertySchema(
      id: 6,
      name: r'message',
      type: IsarType.string,
    ),
    r'routeId': PropertySchema(
      id: 7,
      name: r'routeId',
      type: IsarType.long,
    ),
    r'targetUserId': PropertySchema(
      id: 8,
      name: r'targetUserId',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 9,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _userRecentActivityEstimateSize,
  serialize: _userRecentActivitySerialize,
  deserialize: _userRecentActivityDeserialize,
  deserializeProp: _userRecentActivityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'user': LinkSchema(
      id: -4552135559912054625,
      name: r'user',
      target: r'UserInfo',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _userRecentActivityGetId,
  getLinks: _userRecentActivityGetLinks,
  attach: _userRecentActivityAttach,
  version: '3.1.0+1',
);

int _userRecentActivityEstimateSize(
  UserRecentActivity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activityType.name.length * 3;
  bytesCount += 3 + object.activityTypeString.length * 3;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userRecentActivitySerialize(
  UserRecentActivity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityType.name);
  writer.writeString(offsets[1], object.activityTypeString);
  writer.writeLong(offsets[2], object.eventId);
  writer.writeLong(offsets[3], object.groupId);
  writer.writeString(offsets[4], object.imageUrl);
  writer.writeBool(offsets[5], object.isRead);
  writer.writeString(offsets[6], object.message);
  writer.writeLong(offsets[7], object.routeId);
  writer.writeLong(offsets[8], object.targetUserId);
  writer.writeDateTime(offsets[9], object.timestamp);
}

UserRecentActivity _userRecentActivityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserRecentActivity(
    activityType: _UserRecentActivityactivityTypeValueEnumMap[
            reader.readStringOrNull(offsets[0])] ??
        RecentActivityType.routeCompleted,
    eventId: reader.readLongOrNull(offsets[2]),
    groupId: reader.readLongOrNull(offsets[3]),
    id: id,
    imageUrl: reader.readStringOrNull(offsets[4]),
    isRead: reader.readBoolOrNull(offsets[5]) ?? false,
    message: reader.readStringOrNull(offsets[6]),
    routeId: reader.readLongOrNull(offsets[7]),
    targetUserId: reader.readLongOrNull(offsets[8]),
    timestamp: reader.readDateTime(offsets[9]),
  );
  return object;
}

P _userRecentActivityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_UserRecentActivityactivityTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          RecentActivityType.routeCompleted) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserRecentActivityactivityTypeEnumValueMap = {
  r'routeCompleted': r'routeCompleted',
  r'routeCreated': r'routeCreated',
  r'eventJoined': r'eventJoined',
  r'eventCreated': r'eventCreated',
  r'groupJoined': r'groupJoined',
  r'groupCreated': r'groupCreated',
  r'followedUser': r'followedUser',
  r'achievement': r'achievement',
  r'comment': r'comment',
  r'like': r'like',
};
const _UserRecentActivityactivityTypeValueEnumMap = {
  r'routeCompleted': RecentActivityType.routeCompleted,
  r'routeCreated': RecentActivityType.routeCreated,
  r'eventJoined': RecentActivityType.eventJoined,
  r'eventCreated': RecentActivityType.eventCreated,
  r'groupJoined': RecentActivityType.groupJoined,
  r'groupCreated': RecentActivityType.groupCreated,
  r'followedUser': RecentActivityType.followedUser,
  r'achievement': RecentActivityType.achievement,
  r'comment': RecentActivityType.comment,
  r'like': RecentActivityType.like,
};

Id _userRecentActivityGetId(UserRecentActivity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _userRecentActivityGetLinks(
    UserRecentActivity object) {
  return [object.user];
}

void _userRecentActivityAttach(
    IsarCollection<dynamic> col, Id id, UserRecentActivity object) {
  object.id = id;
  object.user.attach(col, col.isar.collection<UserInfo>(), r'user', id);
}

extension UserRecentActivityQueryWhereSort
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QWhere> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserRecentActivityQueryWhere
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QWhereClause> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserRecentActivityQueryFilter
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QFilterCondition> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeEqualTo(
    RecentActivityType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeGreaterThan(
    RecentActivityType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeLessThan(
    RecentActivityType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeBetween(
    RecentActivityType lower,
    RecentActivityType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityTypeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityTypeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityTypeString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityTypeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityTypeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityTypeString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityTypeString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeString',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      activityTypeStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityTypeString',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      eventIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'eventId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      eventIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'eventId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      eventIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      eventIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      eventIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      eventIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      groupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      groupIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      groupIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      groupIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      groupIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      groupIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      isReadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRead',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      routeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'routeId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      routeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'routeId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      routeIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      routeIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      routeIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      routeIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      targetUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetUserId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      targetUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetUserId',
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      targetUserIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      targetUserIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      targetUserIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      targetUserIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserRecentActivityQueryObject
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QFilterCondition> {}

extension UserRecentActivityQueryLinks
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QFilterCondition> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      user(FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterFilterCondition>
      userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }
}

extension UserRecentActivityQuerySortBy
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QSortBy> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByActivityTypeString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeString', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByActivityTypeStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeString', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByRouteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByRouteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByTargetUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUserId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByTargetUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUserId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension UserRecentActivityQuerySortThenBy
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QSortThenBy> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByActivityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByActivityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityType', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByActivityTypeString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeString', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByActivityTypeStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeString', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByEventIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByRouteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByRouteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByTargetUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUserId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByTargetUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetUserId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension UserRecentActivityQueryWhereDistinct
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct> {
  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByActivityType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByActivityTypeString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByEventId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventId');
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId');
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByRouteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeId');
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByTargetUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetUserId');
    });
  }

  QueryBuilder<UserRecentActivity, UserRecentActivity, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension UserRecentActivityQueryProperty
    on QueryBuilder<UserRecentActivity, UserRecentActivity, QQueryProperty> {
  QueryBuilder<UserRecentActivity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserRecentActivity, RecentActivityType, QQueryOperations>
      activityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityType');
    });
  }

  QueryBuilder<UserRecentActivity, String, QQueryOperations>
      activityTypeStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeString');
    });
  }

  QueryBuilder<UserRecentActivity, int?, QQueryOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventId');
    });
  }

  QueryBuilder<UserRecentActivity, int?, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<UserRecentActivity, String?, QQueryOperations>
      imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<UserRecentActivity, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }

  QueryBuilder<UserRecentActivity, String?, QQueryOperations>
      messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<UserRecentActivity, int?, QQueryOperations> routeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeId');
    });
  }

  QueryBuilder<UserRecentActivity, int?, QQueryOperations>
      targetUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetUserId');
    });
  }

  QueryBuilder<UserRecentActivity, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecentActivity _$UserRecentActivityFromJson(Map<String, dynamic> json) =>
    UserRecentActivity(
      id: (json['id'] as num?)?.toInt(),
      activityType:
          $enumDecode(_$RecentActivityTypeEnumMap, json['activityType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      message: json['message'] as String?,
      imageUrl: json['imageUrl'] as String?,
      routeId: (json['routeId'] as num?)?.toInt(),
      eventId: (json['eventId'] as num?)?.toInt(),
      groupId: (json['groupId'] as num?)?.toInt(),
      targetUserId: (json['targetUserId'] as num?)?.toInt(),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$UserRecentActivityToJson(UserRecentActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityType': _$RecentActivityTypeEnumMap[instance.activityType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'message': instance.message,
      'imageUrl': instance.imageUrl,
      'routeId': instance.routeId,
      'eventId': instance.eventId,
      'groupId': instance.groupId,
      'targetUserId': instance.targetUserId,
      'isRead': instance.isRead,
    };

const _$RecentActivityTypeEnumMap = {
  RecentActivityType.routeCompleted: 'routeCompleted',
  RecentActivityType.routeCreated: 'routeCreated',
  RecentActivityType.eventJoined: 'eventJoined',
  RecentActivityType.eventCreated: 'eventCreated',
  RecentActivityType.groupJoined: 'groupJoined',
  RecentActivityType.groupCreated: 'groupCreated',
  RecentActivityType.followedUser: 'followedUser',
  RecentActivityType.achievement: 'achievement',
  RecentActivityType.comment: 'comment',
  RecentActivityType.like: 'like',
};
