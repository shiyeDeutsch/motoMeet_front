// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupCollection on Isar {
  IsarCollection<Group> get groups => this.collection();
}

const GroupSchema = CollectionSchema(
  name: r'Group',
  id: -2045556087275737047,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'isApprovalRequired': PropertySchema(
      id: 1,
      name: r'isApprovalRequired',
      type: IsarType.bool,
    ),
    r'isPublic': PropertySchema(
      id: 2,
      name: r'isPublic',
      type: IsarType.bool,
    ),
    r'location': PropertySchema(
      id: 3,
      name: r'location',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _groupEstimateSize,
  serialize: _groupSerialize,
  deserialize: _groupDeserialize,
  deserializeProp: _groupDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'creator': LinkSchema(
      id: -7395452267381115218,
      name: r'creator',
      target: r'UserInfo',
      single: true,
    ),
    r'members': LinkSchema(
      id: -1731925964168662176,
      name: r'members',
      target: r'GroupMember',
      single: false,
    ),
    r'posts': LinkSchema(
      id: 1259791978371361727,
      name: r'posts',
      target: r'GroupPost',
      single: false,
    ),
    r'events': LinkSchema(
      id: -9052877860303119490,
      name: r'events',
      target: r'Event',
      single: false,
    ),
    r'groupActivities': LinkSchema(
      id: -4426600340820096756,
      name: r'groupActivities',
      target: r'GroupActivity',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _groupGetId,
  getLinks: _groupGetLinks,
  attach: _groupAttach,
  version: '3.1.0+1',
);

int _groupEstimateSize(
  Group object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groupSerialize(
  Group object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeBool(offsets[1], object.isApprovalRequired);
  writer.writeBool(offsets[2], object.isPublic);
  writer.writeString(offsets[3], object.location);
  writer.writeString(offsets[4], object.name);
}

Group _groupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Group(
    description: reader.readStringOrNull(offsets[0]),
    id: id,
    isApprovalRequired: reader.readBoolOrNull(offsets[1]),
    isPublic: reader.readBoolOrNull(offsets[2]),
    location: reader.readStringOrNull(offsets[3]),
    name: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _groupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupGetId(Group object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groupGetLinks(Group object) {
  return [
    object.creator,
    object.members,
    object.posts,
    object.events,
    object.groupActivities
  ];
}

void _groupAttach(IsarCollection<dynamic> col, Id id, Group object) {
  object.id = id;
  object.creator.attach(col, col.isar.collection<UserInfo>(), r'creator', id);
  object.members
      .attach(col, col.isar.collection<GroupMember>(), r'members', id);
  object.posts.attach(col, col.isar.collection<GroupPost>(), r'posts', id);
  object.events.attach(col, col.isar.collection<Event>(), r'events', id);
  object.groupActivities.attach(
      col, col.isar.collection<GroupActivity>(), r'groupActivities', id);
}

extension GroupQueryWhereSort on QueryBuilder<Group, Group, QWhere> {
  QueryBuilder<Group, Group, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupQueryWhere on QueryBuilder<Group, Group, QWhereClause> {
  QueryBuilder<Group, Group, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Group, Group, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Group, Group, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Group, Group, QAfterWhereClause> idBetween(
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

extension GroupQueryFilter on QueryBuilder<Group, Group, QFilterCondition> {
  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Group, Group, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Group, Group, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Group, Group, QAfterFilterCondition> isApprovalRequiredIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isApprovalRequired',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition>
      isApprovalRequiredIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isApprovalRequired',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> isApprovalRequiredEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isApprovalRequired',
        value: value,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> isPublicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPublic',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> isPublicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPublic',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> isPublicEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublic',
        value: value,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension GroupQueryObject on QueryBuilder<Group, Group, QFilterCondition> {}

extension GroupQueryLinks on QueryBuilder<Group, Group, QFilterCondition> {
  QueryBuilder<Group, Group, QAfterFilterCondition> creator(
      FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'creator');
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> creatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'creator', 0, true, 0, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> members(
      FilterQuery<GroupMember> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'members');
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> membersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'members', length, true, length, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> membersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'members', 0, true, 0, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> membersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'members', 0, false, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> membersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'members', 0, true, length, include);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> membersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'members', length, include, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> membersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'members', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> posts(
      FilterQuery<GroupPost> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'posts');
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> postsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'posts', length, true, length, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> postsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'posts', 0, true, 0, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> postsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'posts', 0, false, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> postsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'posts', 0, true, length, include);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> postsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'posts', length, include, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> postsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'posts', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> events(
      FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'events');
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> eventsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', length, true, length, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> eventsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', 0, true, 0, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> eventsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', 0, false, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> eventsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', 0, true, length, include);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> eventsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', length, include, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> eventsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'events', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> groupActivities(
      FilterQuery<GroupActivity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'groupActivities');
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition>
      groupActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', length, true, length, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition> groupActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', 0, true, 0, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition>
      groupActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', 0, false, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition>
      groupActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', 0, true, length, include);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition>
      groupActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'groupActivities', length, include, 999999, true);
    });
  }

  QueryBuilder<Group, Group, QAfterFilterCondition>
      groupActivitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'groupActivities', lower, includeLower, upper, includeUpper);
    });
  }
}

extension GroupQuerySortBy on QueryBuilder<Group, Group, QSortBy> {
  QueryBuilder<Group, Group, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByIsApprovalRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApprovalRequired', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByIsApprovalRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApprovalRequired', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension GroupQuerySortThenBy on QueryBuilder<Group, Group, QSortThenBy> {
  QueryBuilder<Group, Group, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByIsApprovalRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApprovalRequired', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByIsApprovalRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApprovalRequired', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Group, Group, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension GroupQueryWhereDistinct on QueryBuilder<Group, Group, QDistinct> {
  QueryBuilder<Group, Group, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Group, Group, QDistinct> distinctByIsApprovalRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isApprovalRequired');
    });
  }

  QueryBuilder<Group, Group, QDistinct> distinctByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublic');
    });
  }

  QueryBuilder<Group, Group, QDistinct> distinctByLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Group, Group, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension GroupQueryProperty on QueryBuilder<Group, Group, QQueryProperty> {
  QueryBuilder<Group, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Group, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Group, bool?, QQueryOperations> isApprovalRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isApprovalRequired');
    });
  }

  QueryBuilder<Group, bool?, QQueryOperations> isPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublic');
    });
  }

  QueryBuilder<Group, String?, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<Group, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupMemberCollection on Isar {
  IsarCollection<GroupMember> get groupMembers => this.collection();
}

const GroupMemberSchema = CollectionSchema(
  name: r'GroupMember',
  id: 5247470741765498699,
  properties: {
    r'canPost': PropertySchema(
      id: 0,
      name: r'canPost',
      type: IsarType.bool,
    ),
    r'isAdmin': PropertySchema(
      id: 1,
      name: r'isAdmin',
      type: IsarType.bool,
    ),
    r'isApproved': PropertySchema(
      id: 2,
      name: r'isApproved',
      type: IsarType.bool,
    ),
    r'joinedOn': PropertySchema(
      id: 3,
      name: r'joinedOn',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _groupMemberEstimateSize,
  serialize: _groupMemberSerialize,
  deserialize: _groupMemberDeserialize,
  deserializeProp: _groupMemberDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'person': LinkSchema(
      id: -2129367709144664733,
      name: r'person',
      target: r'UserInfo',
      single: true,
    ),
    r'group': LinkSchema(
      id: 9060026938098965741,
      name: r'group',
      target: r'Group',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _groupMemberGetId,
  getLinks: _groupMemberGetLinks,
  attach: _groupMemberAttach,
  version: '3.1.0+1',
);

int _groupMemberEstimateSize(
  GroupMember object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _groupMemberSerialize(
  GroupMember object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.canPost);
  writer.writeBool(offsets[1], object.isAdmin);
  writer.writeBool(offsets[2], object.isApproved);
  writer.writeDateTime(offsets[3], object.joinedOn);
}

GroupMember _groupMemberDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupMember(
    canPost: reader.readBoolOrNull(offsets[0]),
    id: id,
    isAdmin: reader.readBoolOrNull(offsets[1]),
    isApproved: reader.readBoolOrNull(offsets[2]),
    joinedOn: reader.readDateTimeOrNull(offsets[3]),
  );
  return object;
}

P _groupMemberDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupMemberGetId(GroupMember object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groupMemberGetLinks(GroupMember object) {
  return [object.person, object.group];
}

void _groupMemberAttach(
    IsarCollection<dynamic> col, Id id, GroupMember object) {
  object.id = id;
  object.person.attach(col, col.isar.collection<UserInfo>(), r'person', id);
  object.group.attach(col, col.isar.collection<Group>(), r'group', id);
}

extension GroupMemberQueryWhereSort
    on QueryBuilder<GroupMember, GroupMember, QWhere> {
  QueryBuilder<GroupMember, GroupMember, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupMemberQueryWhere
    on QueryBuilder<GroupMember, GroupMember, QWhereClause> {
  QueryBuilder<GroupMember, GroupMember, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<GroupMember, GroupMember, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterWhereClause> idBetween(
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

extension GroupMemberQueryFilter
    on QueryBuilder<GroupMember, GroupMember, QFilterCondition> {
  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      canPostIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canPost',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      canPostIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canPost',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> canPostEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canPost',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      isAdminIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isAdmin',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      isAdminIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isAdmin',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> isAdminEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAdmin',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      isApprovedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isApproved',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      isApprovedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isApproved',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      isApprovedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isApproved',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      joinedOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'joinedOn',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      joinedOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'joinedOn',
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> joinedOnEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      joinedOnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'joinedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition>
      joinedOnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'joinedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> joinedOnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'joinedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GroupMemberQueryObject
    on QueryBuilder<GroupMember, GroupMember, QFilterCondition> {}

extension GroupMemberQueryLinks
    on QueryBuilder<GroupMember, GroupMember, QFilterCondition> {
  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> person(
      FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'person');
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> personIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'person', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> group(
      FilterQuery<Group> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'group');
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterFilterCondition> groupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'group', 0, true, 0, true);
    });
  }
}

extension GroupMemberQuerySortBy
    on QueryBuilder<GroupMember, GroupMember, QSortBy> {
  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByCanPost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPost', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByCanPostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPost', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByIsAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByIsApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByIsApprovedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByJoinedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> sortByJoinedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.desc);
    });
  }
}

extension GroupMemberQuerySortThenBy
    on QueryBuilder<GroupMember, GroupMember, QSortThenBy> {
  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByCanPost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPost', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByCanPostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPost', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByIsAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByIsApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByIsApprovedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.desc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByJoinedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.asc);
    });
  }

  QueryBuilder<GroupMember, GroupMember, QAfterSortBy> thenByJoinedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.desc);
    });
  }
}

extension GroupMemberQueryWhereDistinct
    on QueryBuilder<GroupMember, GroupMember, QDistinct> {
  QueryBuilder<GroupMember, GroupMember, QDistinct> distinctByCanPost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canPost');
    });
  }

  QueryBuilder<GroupMember, GroupMember, QDistinct> distinctByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAdmin');
    });
  }

  QueryBuilder<GroupMember, GroupMember, QDistinct> distinctByIsApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isApproved');
    });
  }

  QueryBuilder<GroupMember, GroupMember, QDistinct> distinctByJoinedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'joinedOn');
    });
  }
}

extension GroupMemberQueryProperty
    on QueryBuilder<GroupMember, GroupMember, QQueryProperty> {
  QueryBuilder<GroupMember, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroupMember, bool?, QQueryOperations> canPostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canPost');
    });
  }

  QueryBuilder<GroupMember, bool?, QQueryOperations> isAdminProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAdmin');
    });
  }

  QueryBuilder<GroupMember, bool?, QQueryOperations> isApprovedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isApproved');
    });
  }

  QueryBuilder<GroupMember, DateTime?, QQueryOperations> joinedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'joinedOn');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupActivityCollection on Isar {
  IsarCollection<GroupActivity> get groupActivitys => this.collection();
}

const GroupActivitySchema = CollectionSchema(
  name: r'GroupActivity',
  id: -7992169767017170499,
  properties: {
    r'activityTypeName': PropertySchema(
      id: 0,
      name: r'activityTypeName',
      type: IsarType.string,
    )
  },
  estimateSize: _groupActivityEstimateSize,
  serialize: _groupActivitySerialize,
  deserialize: _groupActivityDeserialize,
  deserializeProp: _groupActivityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _groupActivityGetId,
  getLinks: _groupActivityGetLinks,
  attach: _groupActivityAttach,
  version: '3.1.0+1',
);

int _groupActivityEstimateSize(
  GroupActivity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.activityTypeName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groupActivitySerialize(
  GroupActivity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityTypeName);
}

GroupActivity _groupActivityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupActivity(
    activityTypeName: reader.readStringOrNull(offsets[0]),
    id: id,
  );
  return object;
}

P _groupActivityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupActivityGetId(GroupActivity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groupActivityGetLinks(GroupActivity object) {
  return [];
}

void _groupActivityAttach(
    IsarCollection<dynamic> col, Id id, GroupActivity object) {
  object.id = id;
}

extension GroupActivityQueryWhereSort
    on QueryBuilder<GroupActivity, GroupActivity, QWhere> {
  QueryBuilder<GroupActivity, GroupActivity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupActivityQueryWhere
    on QueryBuilder<GroupActivity, GroupActivity, QWhereClause> {
  QueryBuilder<GroupActivity, GroupActivity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<GroupActivity, GroupActivity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterWhereClause> idBetween(
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

extension GroupActivityQueryFilter
    on QueryBuilder<GroupActivity, GroupActivity, QFilterCondition> {
  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityTypeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityTypeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      activityTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition>
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

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GroupActivity, GroupActivity, QAfterFilterCondition> idBetween(
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
}

extension GroupActivityQueryObject
    on QueryBuilder<GroupActivity, GroupActivity, QFilterCondition> {}

extension GroupActivityQueryLinks
    on QueryBuilder<GroupActivity, GroupActivity, QFilterCondition> {}

extension GroupActivityQuerySortBy
    on QueryBuilder<GroupActivity, GroupActivity, QSortBy> {
  QueryBuilder<GroupActivity, GroupActivity, QAfterSortBy>
      sortByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterSortBy>
      sortByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }
}

extension GroupActivityQuerySortThenBy
    on QueryBuilder<GroupActivity, GroupActivity, QSortThenBy> {
  QueryBuilder<GroupActivity, GroupActivity, QAfterSortBy>
      thenByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterSortBy>
      thenByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupActivity, GroupActivity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GroupActivityQueryWhereDistinct
    on QueryBuilder<GroupActivity, GroupActivity, QDistinct> {
  QueryBuilder<GroupActivity, GroupActivity, QDistinct>
      distinctByActivityTypeName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeName',
          caseSensitive: caseSensitive);
    });
  }
}

extension GroupActivityQueryProperty
    on QueryBuilder<GroupActivity, GroupActivity, QQueryProperty> {
  QueryBuilder<GroupActivity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroupActivity, String?, QQueryOperations>
      activityTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeName');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupPostCollection on Isar {
  IsarCollection<GroupPost> get groupPosts => this.collection();
}

const GroupPostSchema = CollectionSchema(
  name: r'GroupPost',
  id: -5851458705281532131,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdOn': PropertySchema(
      id: 1,
      name: r'createdOn',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _groupPostEstimateSize,
  serialize: _groupPostSerialize,
  deserialize: _groupPostDeserialize,
  deserializeProp: _groupPostDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'author': LinkSchema(
      id: 6921771134924860777,
      name: r'author',
      target: r'UserInfo',
      single: true,
    ),
    r'group': LinkSchema(
      id: 2327747247745117840,
      name: r'group',
      target: r'Group',
      single: true,
    ),
    r'attachments': LinkSchema(
      id: 946400921755009187,
      name: r'attachments',
      target: r'GroupPostAttachment',
      single: false,
    ),
    r'comments': LinkSchema(
      id: 8963630214624802451,
      name: r'comments',
      target: r'GroupPostComment',
      single: false,
    ),
    r'reactions': LinkSchema(
      id: -8435098620502269000,
      name: r'reactions',
      target: r'Reaction',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _groupPostGetId,
  getLinks: _groupPostGetLinks,
  attach: _groupPostAttach,
  version: '3.1.0+1',
);

int _groupPostEstimateSize(
  GroupPost object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groupPostSerialize(
  GroupPost object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeDateTime(offsets[1], object.createdOn);
}

GroupPost _groupPostDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupPost(
    content: reader.readStringOrNull(offsets[0]),
    createdOn: reader.readDateTimeOrNull(offsets[1]),
    id: id,
  );
  return object;
}

P _groupPostDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupPostGetId(GroupPost object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groupPostGetLinks(GroupPost object) {
  return [
    object.author,
    object.group,
    object.attachments,
    object.comments,
    object.reactions
  ];
}

void _groupPostAttach(IsarCollection<dynamic> col, Id id, GroupPost object) {
  object.id = id;
  object.author.attach(col, col.isar.collection<UserInfo>(), r'author', id);
  object.group.attach(col, col.isar.collection<Group>(), r'group', id);
  object.attachments.attach(
      col, col.isar.collection<GroupPostAttachment>(), r'attachments', id);
  object.comments
      .attach(col, col.isar.collection<GroupPostComment>(), r'comments', id);
  object.reactions
      .attach(col, col.isar.collection<Reaction>(), r'reactions', id);
}

extension GroupPostQueryWhereSort
    on QueryBuilder<GroupPost, GroupPost, QWhere> {
  QueryBuilder<GroupPost, GroupPost, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupPostQueryWhere
    on QueryBuilder<GroupPost, GroupPost, QWhereClause> {
  QueryBuilder<GroupPost, GroupPost, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<GroupPost, GroupPost, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterWhereClause> idBetween(
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

extension GroupPostQueryFilter
    on QueryBuilder<GroupPost, GroupPost, QFilterCondition> {
  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> createdOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdOn',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      createdOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdOn',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> createdOnEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      createdOnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> createdOnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> createdOnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> idBetween(
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
}

extension GroupPostQueryObject
    on QueryBuilder<GroupPost, GroupPost, QFilterCondition> {}

extension GroupPostQueryLinks
    on QueryBuilder<GroupPost, GroupPost, QFilterCondition> {
  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> author(
      FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'author');
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> authorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'author', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> group(
      FilterQuery<Group> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'group');
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> groupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'group', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> attachments(
      FilterQuery<GroupPostAttachment> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'attachments');
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      attachmentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'attachments', length, true, length, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      attachmentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'attachments', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      attachmentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'attachments', 0, false, 999999, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      attachmentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'attachments', 0, true, length, include);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      attachmentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'attachments', length, include, 999999, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      attachmentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'attachments', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> comments(
      FilterQuery<GroupPostComment> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'comments');
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      commentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'comments', length, true, length, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> commentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'comments', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      commentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'comments', 0, false, 999999, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      commentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'comments', 0, true, length, include);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      commentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'comments', length, include, 999999, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      commentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'comments', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> reactions(
      FilterQuery<Reaction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'reactions');
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      reactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reactions', length, true, length, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition> reactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reactions', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      reactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reactions', 0, false, 999999, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      reactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reactions', 0, true, length, include);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      reactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reactions', length, include, 999999, true);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterFilterCondition>
      reactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'reactions', lower, includeLower, upper, includeUpper);
    });
  }
}

extension GroupPostQuerySortBy on QueryBuilder<GroupPost, GroupPost, QSortBy> {
  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }
}

extension GroupPostQuerySortThenBy
    on QueryBuilder<GroupPost, GroupPost, QSortThenBy> {
  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GroupPostQueryWhereDistinct
    on QueryBuilder<GroupPost, GroupPost, QDistinct> {
  QueryBuilder<GroupPost, GroupPost, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupPost, GroupPost, QDistinct> distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }
}

extension GroupPostQueryProperty
    on QueryBuilder<GroupPost, GroupPost, QQueryProperty> {
  QueryBuilder<GroupPost, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroupPost, String?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<GroupPost, DateTime?, QQueryOperations> createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupPostCommentCollection on Isar {
  IsarCollection<GroupPostComment> get groupPostComments => this.collection();
}

const GroupPostCommentSchema = CollectionSchema(
  name: r'GroupPostComment',
  id: -5769805825952859911,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdOn': PropertySchema(
      id: 1,
      name: r'createdOn',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _groupPostCommentEstimateSize,
  serialize: _groupPostCommentSerialize,
  deserialize: _groupPostCommentDeserialize,
  deserializeProp: _groupPostCommentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'author': LinkSchema(
      id: 6650489695669267558,
      name: r'author',
      target: r'UserInfo',
      single: true,
    ),
    r'groupPost': LinkSchema(
      id: 6769829000286000819,
      name: r'groupPost',
      target: r'GroupPost',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _groupPostCommentGetId,
  getLinks: _groupPostCommentGetLinks,
  attach: _groupPostCommentAttach,
  version: '3.1.0+1',
);

int _groupPostCommentEstimateSize(
  GroupPostComment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groupPostCommentSerialize(
  GroupPostComment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeDateTime(offsets[1], object.createdOn);
}

GroupPostComment _groupPostCommentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupPostComment(
    content: reader.readStringOrNull(offsets[0]),
    createdOn: reader.readDateTimeOrNull(offsets[1]),
    id: id,
  );
  return object;
}

P _groupPostCommentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupPostCommentGetId(GroupPostComment object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groupPostCommentGetLinks(GroupPostComment object) {
  return [object.author, object.groupPost];
}

void _groupPostCommentAttach(
    IsarCollection<dynamic> col, Id id, GroupPostComment object) {
  object.id = id;
  object.author.attach(col, col.isar.collection<UserInfo>(), r'author', id);
  object.groupPost
      .attach(col, col.isar.collection<GroupPost>(), r'groupPost', id);
}

extension GroupPostCommentQueryWhereSort
    on QueryBuilder<GroupPostComment, GroupPostComment, QWhere> {
  QueryBuilder<GroupPostComment, GroupPostComment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupPostCommentQueryWhere
    on QueryBuilder<GroupPostComment, GroupPostComment, QWhereClause> {
  QueryBuilder<GroupPostComment, GroupPostComment, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterWhereClause>
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

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterWhereClause> idBetween(
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

extension GroupPostCommentQueryFilter
    on QueryBuilder<GroupPostComment, GroupPostComment, QFilterCondition> {
  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      createdOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdOn',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      createdOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdOn',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      createdOnEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      createdOnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      createdOnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      createdOnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
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

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
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

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
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
}

extension GroupPostCommentQueryObject
    on QueryBuilder<GroupPostComment, GroupPostComment, QFilterCondition> {}

extension GroupPostCommentQueryLinks
    on QueryBuilder<GroupPostComment, GroupPostComment, QFilterCondition> {
  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      author(FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'author');
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      authorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'author', 0, true, 0, true);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      groupPost(FilterQuery<GroupPost> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'groupPost');
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterFilterCondition>
      groupPostIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupPost', 0, true, 0, true);
    });
  }
}

extension GroupPostCommentQuerySortBy
    on QueryBuilder<GroupPostComment, GroupPostComment, QSortBy> {
  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      sortByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      sortByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }
}

extension GroupPostCommentQuerySortThenBy
    on QueryBuilder<GroupPostComment, GroupPostComment, QSortThenBy> {
  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      thenByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.asc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      thenByCreatedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdOn', Sort.desc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GroupPostCommentQueryWhereDistinct
    on QueryBuilder<GroupPostComment, GroupPostComment, QDistinct> {
  QueryBuilder<GroupPostComment, GroupPostComment, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupPostComment, GroupPostComment, QDistinct>
      distinctByCreatedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdOn');
    });
  }
}

extension GroupPostCommentQueryProperty
    on QueryBuilder<GroupPostComment, GroupPostComment, QQueryProperty> {
  QueryBuilder<GroupPostComment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroupPostComment, String?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<GroupPostComment, DateTime?, QQueryOperations>
      createdOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdOn');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGroupPostAttachmentCollection on Isar {
  IsarCollection<GroupPostAttachment> get groupPostAttachments =>
      this.collection();
}

const GroupPostAttachmentSchema = CollectionSchema(
  name: r'GroupPostAttachment',
  id: -8434716163308600858,
  properties: {
    r'attachmentType': PropertySchema(
      id: 0,
      name: r'attachmentType',
      type: IsarType.string,
    ),
    r'fileUrl': PropertySchema(
      id: 1,
      name: r'fileUrl',
      type: IsarType.string,
    ),
    r'uploadedOn': PropertySchema(
      id: 2,
      name: r'uploadedOn',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _groupPostAttachmentEstimateSize,
  serialize: _groupPostAttachmentSerialize,
  deserialize: _groupPostAttachmentDeserialize,
  deserializeProp: _groupPostAttachmentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'groupPost': LinkSchema(
      id: 1951426942684335277,
      name: r'groupPost',
      target: r'GroupPost',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _groupPostAttachmentGetId,
  getLinks: _groupPostAttachmentGetLinks,
  attach: _groupPostAttachmentAttach,
  version: '3.1.0+1',
);

int _groupPostAttachmentEstimateSize(
  GroupPostAttachment object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.attachmentType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fileUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _groupPostAttachmentSerialize(
  GroupPostAttachment object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.attachmentType);
  writer.writeString(offsets[1], object.fileUrl);
  writer.writeDateTime(offsets[2], object.uploadedOn);
}

GroupPostAttachment _groupPostAttachmentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GroupPostAttachment(
    attachmentType: reader.readStringOrNull(offsets[0]),
    fileUrl: reader.readStringOrNull(offsets[1]),
    id: id,
    uploadedOn: reader.readDateTimeOrNull(offsets[2]),
  );
  return object;
}

P _groupPostAttachmentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _groupPostAttachmentGetId(GroupPostAttachment object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _groupPostAttachmentGetLinks(
    GroupPostAttachment object) {
  return [object.groupPost];
}

void _groupPostAttachmentAttach(
    IsarCollection<dynamic> col, Id id, GroupPostAttachment object) {
  object.id = id;
  object.groupPost
      .attach(col, col.isar.collection<GroupPost>(), r'groupPost', id);
}

extension GroupPostAttachmentQueryWhereSort
    on QueryBuilder<GroupPostAttachment, GroupPostAttachment, QWhere> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GroupPostAttachmentQueryWhere
    on QueryBuilder<GroupPostAttachment, GroupPostAttachment, QWhereClause> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterWhereClause>
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

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterWhereClause>
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

extension GroupPostAttachmentQueryFilter on QueryBuilder<GroupPostAttachment,
    GroupPostAttachment, QFilterCondition> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'attachmentType',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'attachmentType',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attachmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attachmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attachmentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'attachmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'attachmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'attachmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'attachmentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attachmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      attachmentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'attachmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileUrl',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileUrl',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      fileUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
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

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
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

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
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

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      uploadedOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uploadedOn',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      uploadedOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uploadedOn',
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      uploadedOnEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploadedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      uploadedOnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uploadedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      uploadedOnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uploadedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      uploadedOnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uploadedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GroupPostAttachmentQueryObject on QueryBuilder<GroupPostAttachment,
    GroupPostAttachment, QFilterCondition> {}

extension GroupPostAttachmentQueryLinks on QueryBuilder<GroupPostAttachment,
    GroupPostAttachment, QFilterCondition> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      groupPost(FilterQuery<GroupPost> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'groupPost');
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterFilterCondition>
      groupPostIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupPost', 0, true, 0, true);
    });
  }
}

extension GroupPostAttachmentQuerySortBy
    on QueryBuilder<GroupPostAttachment, GroupPostAttachment, QSortBy> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      sortByAttachmentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentType', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      sortByAttachmentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentType', Sort.desc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      sortByFileUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      sortByFileUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.desc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      sortByUploadedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadedOn', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      sortByUploadedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadedOn', Sort.desc);
    });
  }
}

extension GroupPostAttachmentQuerySortThenBy
    on QueryBuilder<GroupPostAttachment, GroupPostAttachment, QSortThenBy> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByAttachmentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentType', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByAttachmentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attachmentType', Sort.desc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByFileUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByFileUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.desc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByUploadedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadedOn', Sort.asc);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QAfterSortBy>
      thenByUploadedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadedOn', Sort.desc);
    });
  }
}

extension GroupPostAttachmentQueryWhereDistinct
    on QueryBuilder<GroupPostAttachment, GroupPostAttachment, QDistinct> {
  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QDistinct>
      distinctByAttachmentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attachmentType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QDistinct>
      distinctByFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupPostAttachment, GroupPostAttachment, QDistinct>
      distinctByUploadedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uploadedOn');
    });
  }
}

extension GroupPostAttachmentQueryProperty
    on QueryBuilder<GroupPostAttachment, GroupPostAttachment, QQueryProperty> {
  QueryBuilder<GroupPostAttachment, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GroupPostAttachment, String?, QQueryOperations>
      attachmentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attachmentType');
    });
  }

  QueryBuilder<GroupPostAttachment, String?, QQueryOperations>
      fileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileUrl');
    });
  }

  QueryBuilder<GroupPostAttachment, DateTime?, QQueryOperations>
      uploadedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uploadedOn');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      isPublic: json['isPublic'] as bool?,
      isApprovalRequired: json['isApprovalRequired'] as bool?,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'isPublic': instance.isPublic,
      'isApprovalRequired': instance.isApprovalRequired,
    };

GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => GroupMember(
      id: (json['id'] as num?)?.toInt(),
      isAdmin: json['isAdmin'] as bool?,
      canPost: json['canPost'] as bool?,
      isApproved: json['isApproved'] as bool?,
      joinedOn: json['joinedOn'] == null
          ? null
          : DateTime.parse(json['joinedOn'] as String),
    );

Map<String, dynamic> _$GroupMemberToJson(GroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isAdmin': instance.isAdmin,
      'canPost': instance.canPost,
      'isApproved': instance.isApproved,
      'joinedOn': instance.joinedOn?.toIso8601String(),
    };

GroupActivity _$GroupActivityFromJson(Map<String, dynamic> json) =>
    GroupActivity(
      id: (json['id'] as num?)?.toInt(),
      activityTypeName: json['activityTypeName'] as String?,
    );

Map<String, dynamic> _$GroupActivityToJson(GroupActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityTypeName': instance.activityTypeName,
    };

GroupPost _$GroupPostFromJson(Map<String, dynamic> json) => GroupPost(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
    );

Map<String, dynamic> _$GroupPostToJson(GroupPost instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdOn': instance.createdOn?.toIso8601String(),
    };

GroupPostComment _$GroupPostCommentFromJson(Map<String, dynamic> json) =>
    GroupPostComment(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
    );

Map<String, dynamic> _$GroupPostCommentToJson(GroupPostComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdOn': instance.createdOn?.toIso8601String(),
    };

GroupPostAttachment _$GroupPostAttachmentFromJson(Map<String, dynamic> json) =>
    GroupPostAttachment(
      id: (json['id'] as num?)?.toInt(),
      fileUrl: json['fileUrl'] as String?,
      attachmentType: json['attachmentType'] as String?,
      uploadedOn: json['uploadedOn'] == null
          ? null
          : DateTime.parse(json['uploadedOn'] as String),
    );

Map<String, dynamic> _$GroupPostAttachmentToJson(
        GroupPostAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileUrl': instance.fileUrl,
      'attachmentType': instance.attachmentType,
      'uploadedOn': instance.uploadedOn?.toIso8601String(),
    };
