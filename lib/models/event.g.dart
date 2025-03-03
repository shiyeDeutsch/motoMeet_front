// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventCollection on Isar {
  IsarCollection<Event> get events => this.collection();
}

const EventSchema = CollectionSchema(
  name: r'Event',
  id: 2102939193127251002,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'endDateTime': PropertySchema(
      id: 1,
      name: r'endDateTime',
      type: IsarType.dateTime,
    ),
    r'isPublic': PropertySchema(
      id: 2,
      name: r'isPublic',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'requiresApproval': PropertySchema(
      id: 4,
      name: r'requiresApproval',
      type: IsarType.bool,
    ),
    r'startDateTime': PropertySchema(
      id: 5,
      name: r'startDateTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _eventEstimateSize,
  serialize: _eventSerialize,
  deserialize: _eventDeserialize,
  deserializeProp: _eventDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'creator': LinkSchema(
      id: 5000770466229810419,
      name: r'creator',
      target: r'UserInfo',
      single: true,
    ),
    r'group': LinkSchema(
      id: -2693589693900826902,
      name: r'group',
      target: r'Group',
      single: true,
    ),
    r'requiredItems': LinkSchema(
      id: 6249769452711430444,
      name: r'requiredItems',
      target: r'EventItem',
      single: false,
    ),
    r'participants': LinkSchema(
      id: -5257466875326667371,
      name: r'participants',
      target: r'EventParticipant',
      single: false,
    ),
    r'stages': LinkSchema(
      id: -2588062954268177387,
      name: r'stages',
      target: r'EventStage',
      single: false,
    ),
    r'eventActivities': LinkSchema(
      id: 3346846923527984227,
      name: r'eventActivities',
      target: r'EventActivity',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _eventGetId,
  getLinks: _eventGetLinks,
  attach: _eventAttach,
  version: '3.1.0+1',
);

int _eventEstimateSize(
  Event object,
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
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _eventSerialize(
  Event object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeDateTime(offsets[1], object.endDateTime);
  writer.writeBool(offsets[2], object.isPublic);
  writer.writeString(offsets[3], object.name);
  writer.writeBool(offsets[4], object.requiresApproval);
  writer.writeDateTime(offsets[5], object.startDateTime);
}

Event _eventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Event(
    description: reader.readStringOrNull(offsets[0]),
    endDateTime: reader.readDateTimeOrNull(offsets[1]),
    id: id,
    isPublic: reader.readBoolOrNull(offsets[2]),
    name: reader.readStringOrNull(offsets[3]),
    requiresApproval: reader.readBoolOrNull(offsets[4]),
    startDateTime: reader.readDateTimeOrNull(offsets[5]),
  );
  return object;
}

P _eventDeserializeProp<P>(
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
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventGetId(Event object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _eventGetLinks(Event object) {
  return [
    object.creator,
    object.group,
    object.requiredItems,
    object.participants,
    object.stages,
    object.eventActivities
  ];
}

void _eventAttach(IsarCollection<dynamic> col, Id id, Event object) {
  object.id = id;
  object.creator.attach(col, col.isar.collection<UserInfo>(), r'creator', id);
  object.group.attach(col, col.isar.collection<Group>(), r'group', id);
  object.requiredItems
      .attach(col, col.isar.collection<EventItem>(), r'requiredItems', id);
  object.participants.attach(
      col, col.isar.collection<EventParticipant>(), r'participants', id);
  object.stages.attach(col, col.isar.collection<EventStage>(), r'stages', id);
  object.eventActivities.attach(
      col, col.isar.collection<EventActivity>(), r'eventActivities', id);
}

extension EventQueryWhereSort on QueryBuilder<Event, Event, QWhere> {
  QueryBuilder<Event, Event, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventQueryWhere on QueryBuilder<Event, Event, QWhereClause> {
  QueryBuilder<Event, Event, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Event, Event, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idBetween(
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

extension EventQueryFilter on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionGreaterThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionContains(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionMatches(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDateTime',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDateTime',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> isPublicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPublic',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> isPublicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPublic',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> isPublicEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublic',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiresApprovalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requiresApproval',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      requiresApprovalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requiresApproval',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiresApprovalEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requiresApproval',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startDateTime',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startDateTime',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EventQueryObject on QueryBuilder<Event, Event, QFilterCondition> {}

extension EventQueryLinks on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> creator(
      FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'creator');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> creatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'creator', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> group(
      FilterQuery<Group> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'group');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> groupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'group', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiredItems(
      FilterQuery<EventItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'requiredItems');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiredItemsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredItems', length, true, length, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiredItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredItems', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiredItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredItems', 0, false, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiredItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredItems', 0, true, length, include);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      requiredItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredItems', length, include, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> requiredItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'requiredItems', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> participants(
      FilterQuery<EventParticipant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'participants');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> participantsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', length, true, length, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> participantsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> participantsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', 0, false, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> participantsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', 0, true, length, include);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      participantsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'participants', length, include, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> participantsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'participants', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stages(
      FilterQuery<EventStage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stages');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stagesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', length, true, length, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', 0, false, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', 0, true, length, include);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stages', length, include, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> stagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stages', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> eventActivities(
      FilterQuery<EventActivity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'eventActivities');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      eventActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', length, true, length, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> eventActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      eventActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', 0, false, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      eventActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', 0, true, length, include);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      eventActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'eventActivities', length, include, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      eventActivitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'eventActivities', lower, includeLower, upper, includeUpper);
    });
  }
}

extension EventQuerySortBy on QueryBuilder<Event, Event, QSortBy> {
  QueryBuilder<Event, Event, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByRequiresApproval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresApproval', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByRequiresApprovalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresApproval', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.desc);
    });
  }
}

extension EventQuerySortThenBy on QueryBuilder<Event, Event, QSortThenBy> {
  QueryBuilder<Event, Event, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByRequiresApproval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresApproval', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByRequiresApprovalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresApproval', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.desc);
    });
  }
}

extension EventQueryWhereDistinct on QueryBuilder<Event, Event, QDistinct> {
  QueryBuilder<Event, Event, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDateTime');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublic');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByRequiresApproval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requiresApproval');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDateTime');
    });
  }
}

extension EventQueryProperty on QueryBuilder<Event, Event, QQueryProperty> {
  QueryBuilder<Event, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Event, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Event, DateTime?, QQueryOperations> endDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDateTime');
    });
  }

  QueryBuilder<Event, bool?, QQueryOperations> isPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublic');
    });
  }

  QueryBuilder<Event, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Event, bool?, QQueryOperations> requiresApprovalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requiresApproval');
    });
  }

  QueryBuilder<Event, DateTime?, QQueryOperations> startDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDateTime');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventStageCollection on Isar {
  IsarCollection<EventStage> get eventStages => this.collection();
}

const EventStageSchema = CollectionSchema(
  name: r'EventStage',
  id: -1263140284972187931,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'location': PropertySchema(
      id: 1,
      name: r'location',
      type: IsarType.object,
      target: r'GeoPoint',
    ),
    r'routeType': PropertySchema(
      id: 2,
      name: r'routeType',
      type: IsarType.string,
    ),
    r'stageStartTime': PropertySchema(
      id: 3,
      name: r'stageStartTime',
      type: IsarType.dateTime,
    ),
    r'stageType': PropertySchema(
      id: 4,
      name: r'stageType',
      type: IsarType.string,
      enumMap: _EventStagestageTypeEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _eventStageEstimateSize,
  serialize: _eventStageSerialize,
  deserialize: _eventStageDeserialize,
  deserializeProp: _eventStageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'event': LinkSchema(
      id: 1483449090914379286,
      name: r'event',
      target: r'Event',
      single: true,
    ),
    r'stageParticipants': LinkSchema(
      id: -6764366771252762610,
      name: r'stageParticipants',
      target: r'EventStageParticipant',
      single: false,
    )
  },
  embeddedSchemas: {r'GeoPoint': GeoPointSchema},
  getId: _eventStageGetId,
  getLinks: _eventStageGetLinks,
  attach: _eventStageAttach,
  version: '3.1.0+1',
);

int _eventStageEstimateSize(
  EventStage object,
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
      bytesCount += 3 +
          GeoPointSchema.estimateSize(value, allOffsets[GeoPoint]!, allOffsets);
    }
  }
  {
    final value = object.routeType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stageType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _eventStageSerialize(
  EventStage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeObject<GeoPoint>(
    offsets[1],
    allOffsets,
    GeoPointSchema.serialize,
    object.location,
  );
  writer.writeString(offsets[2], object.routeType);
  writer.writeDateTime(offsets[3], object.stageStartTime);
  writer.writeString(offsets[4], object.stageType?.name);
  writer.writeString(offsets[5], object.title);
}

EventStage _eventStageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventStage(
    description: reader.readStringOrNull(offsets[0]),
    id: id,
    location: reader.readObjectOrNull<GeoPoint>(
      offsets[1],
      GeoPointSchema.deserialize,
      allOffsets,
    ),
    routeType: reader.readStringOrNull(offsets[2]),
    stageStartTime: reader.readDateTimeOrNull(offsets[3]),
    stageType:
        _EventStagestageTypeValueEnumMap[reader.readStringOrNull(offsets[4])],
    title: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _eventStageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<GeoPoint>(
        offset,
        GeoPointSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (_EventStagestageTypeValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EventStagestageTypeEnumValueMap = {
  r'RouteSegment': r'RouteSegment',
  r'MeetingPoint': r'MeetingPoint',
  r'OvernightStop': r'OvernightStop',
  r'LunchStop': r'LunchStop',
  r'Activity': r'Activity',
};
const _EventStagestageTypeValueEnumMap = {
  r'RouteSegment': EventStageType.RouteSegment,
  r'MeetingPoint': EventStageType.MeetingPoint,
  r'OvernightStop': EventStageType.OvernightStop,
  r'LunchStop': EventStageType.LunchStop,
  r'Activity': EventStageType.Activity,
};

Id _eventStageGetId(EventStage object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _eventStageGetLinks(EventStage object) {
  return [object.event, object.stageParticipants];
}

void _eventStageAttach(IsarCollection<dynamic> col, Id id, EventStage object) {
  object.id = id;
  object.event.attach(col, col.isar.collection<Event>(), r'event', id);
  object.stageParticipants.attach(col,
      col.isar.collection<EventStageParticipant>(), r'stageParticipants', id);
}

extension EventStageQueryWhereSort
    on QueryBuilder<EventStage, EventStage, QWhere> {
  QueryBuilder<EventStage, EventStage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventStageQueryWhere
    on QueryBuilder<EventStage, EventStage, QWhereClause> {
  QueryBuilder<EventStage, EventStage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<EventStage, EventStage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterWhereClause> idBetween(
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

extension EventStageQueryFilter
    on QueryBuilder<EventStage, EventStage, QFilterCondition> {
  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionEqualTo(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionLessThan(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionBetween(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      routeTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'routeType',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      routeTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'routeType',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> routeTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      routeTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> routeTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> routeTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      routeTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> routeTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> routeTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> routeTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routeType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      routeTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeType',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      routeTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routeType',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageStartTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageStartTime',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageStartTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageStartTime',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageStartTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageStartTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stageStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageStartTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stageStartTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageStartTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stageStartTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageType',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageType',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageTypeEqualTo(
    EventStageType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageTypeGreaterThan(
    EventStageType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageTypeLessThan(
    EventStageType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageTypeBetween(
    EventStageType? lower,
    EventStageType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stageType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageType',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stageType',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension EventStageQueryObject
    on QueryBuilder<EventStage, EventStage, QFilterCondition> {
  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> location(
      FilterQuery<GeoPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'location');
    });
  }
}

extension EventStageQueryLinks
    on QueryBuilder<EventStage, EventStage, QFilterCondition> {
  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> event(
      FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'event');
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> eventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'event', 0, true, 0, true);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition> stageParticipants(
      FilterQuery<EventStageParticipant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stageParticipants');
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageParticipantsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', length, true, length, true);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageParticipantsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', 0, true, 0, true);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageParticipantsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', 0, false, 999999, true);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageParticipantsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', 0, true, length, include);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageParticipantsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stageParticipants', length, include, 999999, true);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterFilterCondition>
      stageParticipantsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stageParticipants', lower, includeLower, upper, includeUpper);
    });
  }
}

extension EventStageQuerySortBy
    on QueryBuilder<EventStage, EventStage, QSortBy> {
  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByRouteType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeType', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByRouteTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeType', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByStageStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageStartTime', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy>
      sortByStageStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageStartTime', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByStageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageType', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByStageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageType', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension EventStageQuerySortThenBy
    on QueryBuilder<EventStage, EventStage, QSortThenBy> {
  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByRouteType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeType', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByRouteTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routeType', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByStageStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageStartTime', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy>
      thenByStageStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageStartTime', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByStageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageType', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByStageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageType', Sort.desc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<EventStage, EventStage, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension EventStageQueryWhereDistinct
    on QueryBuilder<EventStage, EventStage, QDistinct> {
  QueryBuilder<EventStage, EventStage, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventStage, EventStage, QDistinct> distinctByRouteType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventStage, EventStage, QDistinct> distinctByStageStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageStartTime');
    });
  }

  QueryBuilder<EventStage, EventStage, QDistinct> distinctByStageType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventStage, EventStage, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension EventStageQueryProperty
    on QueryBuilder<EventStage, EventStage, QQueryProperty> {
  QueryBuilder<EventStage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventStage, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<EventStage, GeoPoint?, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<EventStage, String?, QQueryOperations> routeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeType');
    });
  }

  QueryBuilder<EventStage, DateTime?, QQueryOperations>
      stageStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageStartTime');
    });
  }

  QueryBuilder<EventStage, EventStageType?, QQueryOperations>
      stageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageType');
    });
  }

  QueryBuilder<EventStage, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventParticipantCollection on Isar {
  IsarCollection<EventParticipant> get eventParticipants => this.collection();
}

const EventParticipantSchema = CollectionSchema(
  name: r'EventParticipant',
  id: 1505668128277415724,
  properties: {
    r'isActive': PropertySchema(
      id: 0,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isApproved': PropertySchema(
      id: 1,
      name: r'isApproved',
      type: IsarType.bool,
    ),
    r'joinedOn': PropertySchema(
      id: 2,
      name: r'joinedOn',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _eventParticipantEstimateSize,
  serialize: _eventParticipantSerialize,
  deserialize: _eventParticipantDeserialize,
  deserializeProp: _eventParticipantDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'person': LinkSchema(
      id: 1314319832651745242,
      name: r'person',
      target: r'UserInfo',
      single: true,
    ),
    r'event': LinkSchema(
      id: -3047162210715580925,
      name: r'event',
      target: r'Event',
      single: true,
    ),
    r'stageParticipants': LinkSchema(
      id: -7785491383827007822,
      name: r'stageParticipants',
      target: r'EventStageParticipant',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _eventParticipantGetId,
  getLinks: _eventParticipantGetLinks,
  attach: _eventParticipantAttach,
  version: '3.1.0+1',
);

int _eventParticipantEstimateSize(
  EventParticipant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _eventParticipantSerialize(
  EventParticipant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isActive);
  writer.writeBool(offsets[1], object.isApproved);
  writer.writeDateTime(offsets[2], object.joinedOn);
}

EventParticipant _eventParticipantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventParticipant(
    id: id,
    isActive: reader.readBoolOrNull(offsets[0]),
    isApproved: reader.readBoolOrNull(offsets[1]),
    joinedOn: reader.readDateTimeOrNull(offsets[2]),
  );
  return object;
}

P _eventParticipantDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventParticipantGetId(EventParticipant object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _eventParticipantGetLinks(EventParticipant object) {
  return [object.person, object.event, object.stageParticipants];
}

void _eventParticipantAttach(
    IsarCollection<dynamic> col, Id id, EventParticipant object) {
  object.id = id;
  object.person.attach(col, col.isar.collection<UserInfo>(), r'person', id);
  object.event.attach(col, col.isar.collection<Event>(), r'event', id);
  object.stageParticipants.attach(col,
      col.isar.collection<EventStageParticipant>(), r'stageParticipants', id);
}

extension EventParticipantQueryWhereSort
    on QueryBuilder<EventParticipant, EventParticipant, QWhere> {
  QueryBuilder<EventParticipant, EventParticipant, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventParticipantQueryWhere
    on QueryBuilder<EventParticipant, EventParticipant, QWhereClause> {
  QueryBuilder<EventParticipant, EventParticipant, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterWhereClause>
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

  QueryBuilder<EventParticipant, EventParticipant, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterWhereClause> idBetween(
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

extension EventParticipantQueryFilter
    on QueryBuilder<EventParticipant, EventParticipant, QFilterCondition> {
  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
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

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
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

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
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

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      isActiveEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      isApprovedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isApproved',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      isApprovedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isApproved',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      isApprovedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isApproved',
        value: value,
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      joinedOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'joinedOn',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      joinedOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'joinedOn',
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      joinedOnEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'joinedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
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

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
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

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      joinedOnBetween(
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

extension EventParticipantQueryObject
    on QueryBuilder<EventParticipant, EventParticipant, QFilterCondition> {}

extension EventParticipantQueryLinks
    on QueryBuilder<EventParticipant, EventParticipant, QFilterCondition> {
  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      person(FilterQuery<UserInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'person');
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      personIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'person', 0, true, 0, true);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition> event(
      FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'event');
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      eventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'event', 0, true, 0, true);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipants(FilterQuery<EventStageParticipant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stageParticipants');
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipantsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', length, true, length, true);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipantsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', 0, true, 0, true);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipantsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', 0, false, 999999, true);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipantsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stageParticipants', 0, true, length, include);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipantsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stageParticipants', length, include, 999999, true);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterFilterCondition>
      stageParticipantsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stageParticipants', lower, includeLower, upper, includeUpper);
    });
  }
}

extension EventParticipantQuerySortBy
    on QueryBuilder<EventParticipant, EventParticipant, QSortBy> {
  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      sortByIsApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      sortByIsApprovedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.desc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      sortByJoinedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      sortByJoinedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.desc);
    });
  }
}

extension EventParticipantQuerySortThenBy
    on QueryBuilder<EventParticipant, EventParticipant, QSortThenBy> {
  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByIsApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByIsApprovedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isApproved', Sort.desc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByJoinedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.asc);
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QAfterSortBy>
      thenByJoinedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'joinedOn', Sort.desc);
    });
  }
}

extension EventParticipantQueryWhereDistinct
    on QueryBuilder<EventParticipant, EventParticipant, QDistinct> {
  QueryBuilder<EventParticipant, EventParticipant, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QDistinct>
      distinctByIsApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isApproved');
    });
  }

  QueryBuilder<EventParticipant, EventParticipant, QDistinct>
      distinctByJoinedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'joinedOn');
    });
  }
}

extension EventParticipantQueryProperty
    on QueryBuilder<EventParticipant, EventParticipant, QQueryProperty> {
  QueryBuilder<EventParticipant, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventParticipant, bool?, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<EventParticipant, bool?, QQueryOperations> isApprovedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isApproved');
    });
  }

  QueryBuilder<EventParticipant, DateTime?, QQueryOperations>
      joinedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'joinedOn');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventStageParticipantCollection on Isar {
  IsarCollection<EventStageParticipant> get eventStageParticipants =>
      this.collection();
}

const EventStageParticipantSchema = CollectionSchema(
  name: r'EventStageParticipant',
  id: 2635820788494396651,
  properties: {
    r'finishedAt': PropertySchema(
      id: 0,
      name: r'finishedAt',
      type: IsarType.dateTime,
    ),
    r'isCompleted': PropertySchema(
      id: 1,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'startedAt': PropertySchema(
      id: 2,
      name: r'startedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _eventStageParticipantEstimateSize,
  serialize: _eventStageParticipantSerialize,
  deserialize: _eventStageParticipantDeserialize,
  deserializeProp: _eventStageParticipantDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'eventStage': LinkSchema(
      id: -8314180794366714669,
      name: r'eventStage',
      target: r'EventStage',
      single: true,
    ),
    r'eventParticipant': LinkSchema(
      id: 2372688897893911462,
      name: r'eventParticipant',
      target: r'EventParticipant',
      single: true,
    ),
    r'userRoute': LinkSchema(
      id: -4188945433286612070,
      name: r'userRoute',
      target: r'UserRoute',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _eventStageParticipantGetId,
  getLinks: _eventStageParticipantGetLinks,
  attach: _eventStageParticipantAttach,
  version: '3.1.0+1',
);

int _eventStageParticipantEstimateSize(
  EventStageParticipant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _eventStageParticipantSerialize(
  EventStageParticipant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.finishedAt);
  writer.writeBool(offsets[1], object.isCompleted);
  writer.writeDateTime(offsets[2], object.startedAt);
}

EventStageParticipant _eventStageParticipantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventStageParticipant(
    finishedAt: reader.readDateTimeOrNull(offsets[0]),
    id: id,
    isCompleted: reader.readBoolOrNull(offsets[1]),
    startedAt: reader.readDateTimeOrNull(offsets[2]),
  );
  return object;
}

P _eventStageParticipantDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventStageParticipantGetId(EventStageParticipant object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _eventStageParticipantGetLinks(
    EventStageParticipant object) {
  return [object.eventStage, object.eventParticipant, object.userRoute];
}

void _eventStageParticipantAttach(
    IsarCollection<dynamic> col, Id id, EventStageParticipant object) {
  object.id = id;
  object.eventStage
      .attach(col, col.isar.collection<EventStage>(), r'eventStage', id);
  object.eventParticipant.attach(
      col, col.isar.collection<EventParticipant>(), r'eventParticipant', id);
  object.userRoute
      .attach(col, col.isar.collection<UserRoute>(), r'userRoute', id);
}

extension EventStageParticipantQueryWhereSort
    on QueryBuilder<EventStageParticipant, EventStageParticipant, QWhere> {
  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventStageParticipantQueryWhere on QueryBuilder<EventStageParticipant,
    EventStageParticipant, QWhereClause> {
  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterWhereClause>
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

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterWhereClause>
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

extension EventStageParticipantQueryFilter on QueryBuilder<
    EventStageParticipant, EventStageParticipant, QFilterCondition> {
  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> finishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> finishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> finishedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> finishedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> finishedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> finishedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> isCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> isCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> isCompletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> startedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startedAt',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> startedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startedAt',
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> startedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> startedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> startedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> startedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EventStageParticipantQueryObject on QueryBuilder<
    EventStageParticipant, EventStageParticipant, QFilterCondition> {}

extension EventStageParticipantQueryLinks on QueryBuilder<EventStageParticipant,
    EventStageParticipant, QFilterCondition> {
  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> eventStage(FilterQuery<EventStage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'eventStage');
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> eventStageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventStage', 0, true, 0, true);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> eventParticipant(FilterQuery<EventParticipant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'eventParticipant');
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> eventParticipantIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventParticipant', 0, true, 0, true);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> userRoute(FilterQuery<UserRoute> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'userRoute');
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant,
      QAfterFilterCondition> userRouteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'userRoute', 0, true, 0, true);
    });
  }
}

extension EventStageParticipantQuerySortBy
    on QueryBuilder<EventStageParticipant, EventStageParticipant, QSortBy> {
  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      sortByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      sortByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }
}

extension EventStageParticipantQuerySortThenBy
    on QueryBuilder<EventStageParticipant, EventStageParticipant, QSortThenBy> {
  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }
}

extension EventStageParticipantQueryWhereDistinct
    on QueryBuilder<EventStageParticipant, EventStageParticipant, QDistinct> {
  QueryBuilder<EventStageParticipant, EventStageParticipant, QDistinct>
      distinctByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedAt');
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<EventStageParticipant, EventStageParticipant, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }
}

extension EventStageParticipantQueryProperty on QueryBuilder<
    EventStageParticipant, EventStageParticipant, QQueryProperty> {
  QueryBuilder<EventStageParticipant, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventStageParticipant, DateTime?, QQueryOperations>
      finishedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedAt');
    });
  }

  QueryBuilder<EventStageParticipant, bool?, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<EventStageParticipant, DateTime?, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActivityTypeCollection on Isar {
  IsarCollection<ActivityType> get activityTypes => this.collection();
}

const ActivityTypeSchema = CollectionSchema(
  name: r'ActivityType',
  id: -319715602017010704,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _activityTypeEstimateSize,
  serialize: _activityTypeSerialize,
  deserialize: _activityTypeDeserialize,
  deserializeProp: _activityTypeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'eventActivities': LinkSchema(
      id: -1530238197323582262,
      name: r'eventActivities',
      target: r'EventActivity',
      single: false,
    ),
    r'groupActivities': LinkSchema(
      id: 6964704383587144479,
      name: r'groupActivities',
      target: r'GroupActivity',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _activityTypeGetId,
  getLinks: _activityTypeGetLinks,
  attach: _activityTypeAttach,
  version: '3.1.0+1',
);

int _activityTypeEstimateSize(
  ActivityType object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _activityTypeSerialize(
  ActivityType object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

ActivityType _activityTypeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActivityType(
    id: id,
    name: reader.readStringOrNull(offsets[0]),
  );
  return object;
}

P _activityTypeDeserializeProp<P>(
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

Id _activityTypeGetId(ActivityType object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _activityTypeGetLinks(ActivityType object) {
  return [object.eventActivities, object.groupActivities];
}

void _activityTypeAttach(
    IsarCollection<dynamic> col, Id id, ActivityType object) {
  object.id = id;
  object.eventActivities.attach(
      col, col.isar.collection<EventActivity>(), r'eventActivities', id);
  object.groupActivities.attach(
      col, col.isar.collection<GroupActivity>(), r'groupActivities', id);
}

extension ActivityTypeQueryWhereSort
    on QueryBuilder<ActivityType, ActivityType, QWhere> {
  QueryBuilder<ActivityType, ActivityType, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActivityTypeQueryWhere
    on QueryBuilder<ActivityType, ActivityType, QWhereClause> {
  QueryBuilder<ActivityType, ActivityType, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ActivityType, ActivityType, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterWhereClause> idBetween(
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

extension ActivityTypeQueryFilter
    on QueryBuilder<ActivityType, ActivityType, QFilterCondition> {
  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ActivityTypeQueryObject
    on QueryBuilder<ActivityType, ActivityType, QFilterCondition> {}

extension ActivityTypeQueryLinks
    on QueryBuilder<ActivityType, ActivityType, QFilterCondition> {
  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivities(FilterQuery<EventActivity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'eventActivities');
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', length, true, length, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', 0, true, 0, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', 0, false, 999999, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'eventActivities', 0, true, length, include);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'eventActivities', length, include, 999999, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      eventActivitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'eventActivities', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      groupActivities(FilterQuery<GroupActivity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'groupActivities');
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      groupActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', length, true, length, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      groupActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', 0, true, 0, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      groupActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', 0, false, 999999, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      groupActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groupActivities', 0, true, length, include);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
      groupActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'groupActivities', length, include, 999999, true);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterFilterCondition>
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

extension ActivityTypeQuerySortBy
    on QueryBuilder<ActivityType, ActivityType, QSortBy> {
  QueryBuilder<ActivityType, ActivityType, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ActivityTypeQuerySortThenBy
    on QueryBuilder<ActivityType, ActivityType, QSortThenBy> {
  QueryBuilder<ActivityType, ActivityType, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ActivityType, ActivityType, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ActivityTypeQueryWhereDistinct
    on QueryBuilder<ActivityType, ActivityType, QDistinct> {
  QueryBuilder<ActivityType, ActivityType, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ActivityTypeQueryProperty
    on QueryBuilder<ActivityType, ActivityType, QQueryProperty> {
  QueryBuilder<ActivityType, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActivityType, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventActivityCollection on Isar {
  IsarCollection<EventActivity> get eventActivitys => this.collection();
}

const EventActivitySchema = CollectionSchema(
  name: r'EventActivity',
  id: 3205657380676997202,
  properties: {
    r'activityTypeName': PropertySchema(
      id: 0,
      name: r'activityTypeName',
      type: IsarType.string,
    )
  },
  estimateSize: _eventActivityEstimateSize,
  serialize: _eventActivitySerialize,
  deserialize: _eventActivityDeserialize,
  deserializeProp: _eventActivityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _eventActivityGetId,
  getLinks: _eventActivityGetLinks,
  attach: _eventActivityAttach,
  version: '3.1.0+1',
);

int _eventActivityEstimateSize(
  EventActivity object,
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

void _eventActivitySerialize(
  EventActivity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityTypeName);
}

EventActivity _eventActivityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventActivity(
    activityTypeName: reader.readStringOrNull(offsets[0]),
    id: id,
  );
  return object;
}

P _eventActivityDeserializeProp<P>(
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

Id _eventActivityGetId(EventActivity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _eventActivityGetLinks(EventActivity object) {
  return [];
}

void _eventActivityAttach(
    IsarCollection<dynamic> col, Id id, EventActivity object) {
  object.id = id;
}

extension EventActivityQueryWhereSort
    on QueryBuilder<EventActivity, EventActivity, QWhere> {
  QueryBuilder<EventActivity, EventActivity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventActivityQueryWhere
    on QueryBuilder<EventActivity, EventActivity, QWhereClause> {
  QueryBuilder<EventActivity, EventActivity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<EventActivity, EventActivity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterWhereClause> idBetween(
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

extension EventActivityQueryFilter
    on QueryBuilder<EventActivity, EventActivity, QFilterCondition> {
  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      activityTypeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      activityTypeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      activityTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      activityTypeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityTypeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      activityTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      activityTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition>
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EventActivity, EventActivity, QAfterFilterCondition> idBetween(
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

extension EventActivityQueryObject
    on QueryBuilder<EventActivity, EventActivity, QFilterCondition> {}

extension EventActivityQueryLinks
    on QueryBuilder<EventActivity, EventActivity, QFilterCondition> {}

extension EventActivityQuerySortBy
    on QueryBuilder<EventActivity, EventActivity, QSortBy> {
  QueryBuilder<EventActivity, EventActivity, QAfterSortBy>
      sortByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterSortBy>
      sortByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }
}

extension EventActivityQuerySortThenBy
    on QueryBuilder<EventActivity, EventActivity, QSortThenBy> {
  QueryBuilder<EventActivity, EventActivity, QAfterSortBy>
      thenByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterSortBy>
      thenByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventActivity, EventActivity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension EventActivityQueryWhereDistinct
    on QueryBuilder<EventActivity, EventActivity, QDistinct> {
  QueryBuilder<EventActivity, EventActivity, QDistinct>
      distinctByActivityTypeName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeName',
          caseSensitive: caseSensitive);
    });
  }
}

extension EventActivityQueryProperty
    on QueryBuilder<EventActivity, EventActivity, QQueryProperty> {
  QueryBuilder<EventActivity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventActivity, String?, QQueryOperations>
      activityTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeName');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventItemCollection on Isar {
  IsarCollection<EventItem> get eventItems => this.collection();
}

const EventItemSchema = CollectionSchema(
  name: r'EventItem',
  id: -9171563734917098695,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'isAssigned': PropertySchema(
      id: 1,
      name: r'isAssigned',
      type: IsarType.bool,
    ),
    r'itemName': PropertySchema(
      id: 2,
      name: r'itemName',
      type: IsarType.string,
    )
  },
  estimateSize: _eventItemEstimateSize,
  serialize: _eventItemSerialize,
  deserialize: _eventItemDeserialize,
  deserializeProp: _eventItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'event': LinkSchema(
      id: -1654982966316986846,
      name: r'event',
      target: r'Event',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _eventItemGetId,
  getLinks: _eventItemGetLinks,
  attach: _eventItemAttach,
  version: '3.1.0+1',
);

int _eventItemEstimateSize(
  EventItem object,
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
    final value = object.itemName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _eventItemSerialize(
  EventItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeBool(offsets[1], object.isAssigned);
  writer.writeString(offsets[2], object.itemName);
}

EventItem _eventItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EventItem(
    description: reader.readStringOrNull(offsets[0]),
    id: id,
    isAssigned: reader.readBoolOrNull(offsets[1]),
    itemName: reader.readStringOrNull(offsets[2]),
  );
  return object;
}

P _eventItemDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventItemGetId(EventItem object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _eventItemGetLinks(EventItem object) {
  return [object.event];
}

void _eventItemAttach(IsarCollection<dynamic> col, Id id, EventItem object) {
  object.id = id;
  object.event.attach(col, col.isar.collection<Event>(), r'event', id);
}

extension EventItemQueryWhereSort
    on QueryBuilder<EventItem, EventItem, QWhere> {
  QueryBuilder<EventItem, EventItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventItemQueryWhere
    on QueryBuilder<EventItem, EventItem, QWhereClause> {
  QueryBuilder<EventItem, EventItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<EventItem, EventItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterWhereClause> idBetween(
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

extension EventItemQueryFilter
    on QueryBuilder<EventItem, EventItem, QFilterCondition> {
  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> descriptionContains(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> descriptionMatches(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> isAssignedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isAssigned',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      isAssignedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isAssigned',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> isAssignedEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAssigned',
        value: value,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'itemName',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      itemNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'itemName',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> itemNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemName',
        value: '',
      ));
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition>
      itemNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemName',
        value: '',
      ));
    });
  }
}

extension EventItemQueryObject
    on QueryBuilder<EventItem, EventItem, QFilterCondition> {}

extension EventItemQueryLinks
    on QueryBuilder<EventItem, EventItem, QFilterCondition> {
  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> event(
      FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'event');
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterFilterCondition> eventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'event', 0, true, 0, true);
    });
  }
}

extension EventItemQuerySortBy on QueryBuilder<EventItem, EventItem, QSortBy> {
  QueryBuilder<EventItem, EventItem, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> sortByIsAssigned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssigned', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> sortByIsAssignedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssigned', Sort.desc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> sortByItemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> sortByItemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.desc);
    });
  }
}

extension EventItemQuerySortThenBy
    on QueryBuilder<EventItem, EventItem, QSortThenBy> {
  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByIsAssigned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssigned', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByIsAssignedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAssigned', Sort.desc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByItemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.asc);
    });
  }

  QueryBuilder<EventItem, EventItem, QAfterSortBy> thenByItemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemName', Sort.desc);
    });
  }
}

extension EventItemQueryWhereDistinct
    on QueryBuilder<EventItem, EventItem, QDistinct> {
  QueryBuilder<EventItem, EventItem, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventItem, EventItem, QDistinct> distinctByIsAssigned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAssigned');
    });
  }

  QueryBuilder<EventItem, EventItem, QDistinct> distinctByItemName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemName', caseSensitive: caseSensitive);
    });
  }
}

extension EventItemQueryProperty
    on QueryBuilder<EventItem, EventItem, QQueryProperty> {
  QueryBuilder<EventItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EventItem, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<EventItem, bool?, QQueryOperations> isAssignedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAssigned');
    });
  }

  QueryBuilder<EventItem, String?, QQueryOperations> itemNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemName');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      isPublic: json['isPublic'] as bool?,
      requiresApproval: json['requiresApproval'] as bool?,
      startDateTime: json['startDateTime'] == null
          ? null
          : DateTime.parse(json['startDateTime'] as String),
      endDateTime: json['endDateTime'] == null
          ? null
          : DateTime.parse(json['endDateTime'] as String),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isPublic': instance.isPublic,
      'requiresApproval': instance.requiresApproval,
      'startDateTime': instance.startDateTime?.toIso8601String(),
      'endDateTime': instance.endDateTime?.toIso8601String(),
    };

EventStage _$EventStageFromJson(Map<String, dynamic> json) => EventStage(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      stageStartTime: json['stageStartTime'] == null
          ? null
          : DateTime.parse(json['stageStartTime'] as String),
      routeType: json['routeType'] as String?,
      stageType:
          $enumDecodeNullable(_$EventStageTypeEnumMap, json['stageType']),
      location: json['location'] == null
          ? null
          : GeoPoint.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventStageToJson(EventStage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'stageStartTime': instance.stageStartTime?.toIso8601String(),
      'routeType': instance.routeType,
      'stageType': _$EventStageTypeEnumMap[instance.stageType],
      'location': instance.location,
    };

const _$EventStageTypeEnumMap = {
  EventStageType.RouteSegment: 'RouteSegment',
  EventStageType.MeetingPoint: 'MeetingPoint',
  EventStageType.OvernightStop: 'OvernightStop',
  EventStageType.LunchStop: 'LunchStop',
  EventStageType.Activity: 'Activity',
};

EventParticipant _$EventParticipantFromJson(Map<String, dynamic> json) =>
    EventParticipant(
      id: (json['id'] as num?)?.toInt(),
      isApproved: json['isApproved'] as bool?,
      isActive: json['isActive'] as bool?,
      joinedOn: json['joinedOn'] == null
          ? null
          : DateTime.parse(json['joinedOn'] as String),
    );

Map<String, dynamic> _$EventParticipantToJson(EventParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isApproved': instance.isApproved,
      'isActive': instance.isActive,
      'joinedOn': instance.joinedOn?.toIso8601String(),
    };

EventStageParticipant _$EventStageParticipantFromJson(
        Map<String, dynamic> json) =>
    EventStageParticipant(
      id: (json['id'] as num?)?.toInt(),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$EventStageParticipantToJson(
        EventStageParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'isCompleted': instance.isCompleted,
    };

ActivityType _$ActivityTypeFromJson(Map<String, dynamic> json) => ActivityType(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ActivityTypeToJson(ActivityType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

EventActivity _$EventActivityFromJson(Map<String, dynamic> json) =>
    EventActivity(
      id: (json['id'] as num?)?.toInt(),
      activityTypeName: json['activityTypeName'] as String?,
    );

Map<String, dynamic> _$EventActivityToJson(EventActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityTypeName': instance.activityTypeName,
    };

EventItem _$EventItemFromJson(Map<String, dynamic> json) => EventItem(
      id: (json['id'] as num?)?.toInt(),
      itemName: json['itemName'] as String?,
      description: json['description'] as String?,
      isAssigned: json['isAssigned'] as bool?,
    );

Map<String, dynamic> _$EventItemToJson(EventItem instance) => <String, dynamic>{
      'id': instance.id,
      'itemName': instance.itemName,
      'description': instance.description,
      'isAssigned': instance.isAssigned,
    };
