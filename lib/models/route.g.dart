// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNewRouteCollection on Isar {
  IsarCollection<NewRoute> get newRoutes => this.collection();
}

const NewRouteSchema = CollectionSchema(
  name: r'NewRoute',
  id: 2534213512110557197,
  properties: {
    r'country': PropertySchema(
      id: 0,
      name: r'country',
      type: IsarType.string,
    ),
    r'coverImageUrl': PropertySchema(
      id: 1,
      name: r'coverImageUrl',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'difficulty': PropertySchema(
      id: 3,
      name: r'difficulty',
      type: IsarType.string,
      enumMap: _NewRoutedifficultyEnumValueMap,
    ),
    r'durationMinutes': PropertySchema(
      id: 4,
      name: r'durationMinutes',
      type: IsarType.long,
    ),
    r'endDate': PropertySchema(
      id: 5,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'endPoint': PropertySchema(
      id: 6,
      name: r'endPoint',
      type: IsarType.object,
      target: r'GeoPoint',
    ),
    r'isActive': PropertySchema(
      id: 7,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'isComplited': PropertySchema(
      id: 8,
      name: r'isComplited',
      type: IsarType.bool,
    ),
    r'isLoop': PropertySchema(
      id: 9,
      name: r'isLoop',
      type: IsarType.bool,
    ),
    r'length': PropertySchema(
      id: 10,
      name: r'length',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'natureReserveUrl': PropertySchema(
      id: 12,
      name: r'natureReserveUrl',
      type: IsarType.string,
    ),
    r'pointOfInterest': PropertySchema(
      id: 13,
      name: r'pointOfInterest',
      type: IsarType.objectList,
      target: r'Waypoint',
    ),
    r'rating': PropertySchema(
      id: 14,
      name: r'rating',
      type: IsarType.double,
    ),
    r'region': PropertySchema(
      id: 15,
      name: r'region',
      type: IsarType.string,
    ),
    r'routePoints': PropertySchema(
      id: 16,
      name: r'routePoints',
      type: IsarType.objectList,
      target: r'GeoPoint',
    ),
    r'routeTags': PropertySchema(
      id: 17,
      name: r'routeTags',
      type: IsarType.stringList,
      enumMap: _NewRouterouteTagsEnumValueMap,
    ),
    r'routeType': PropertySchema(
      id: 18,
      name: r'routeType',
      type: IsarType.object,
      target: r'RouteType',
    ),
    r'startDate': PropertySchema(
      id: 19,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'startPoint': PropertySchema(
      id: 20,
      name: r'startPoint',
      type: IsarType.object,
      target: r'GeoPoint',
    ),
    r'tips': PropertySchema(
      id: 21,
      name: r'tips',
      type: IsarType.string,
    )
  },
  estimateSize: _newRouteEstimateSize,
  serialize: _newRouteSerialize,
  deserialize: _newRouteDeserialize,
  deserializeProp: _newRouteDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'GeoPoint': GeoPointSchema,
    r'RouteType': RouteTypeSchema,
    r'Waypoint': WaypointSchema
  },
  getId: _newRouteGetId,
  getLinks: _newRouteGetLinks,
  attach: _newRouteAttach,
  version: '3.1.0+1',
);

int _newRouteEstimateSize(
  NewRoute object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.country;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.coverImageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.difficulty;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.endPoint;
    if (value != null) {
      bytesCount += 3 +
          GeoPointSchema.estimateSize(value, allOffsets[GeoPoint]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.natureReserveUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.pointOfInterest;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Waypoint]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += WaypointSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.region;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.routePoints;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[GeoPoint]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += GeoPointSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.routeTags.length * 3;
  {
    for (var i = 0; i < object.routeTags.length; i++) {
      final value = object.routeTags[i];
      bytesCount += value.name.length * 3;
    }
  }
  {
    final value = object.routeType;
    if (value != null) {
      bytesCount += 3 +
          RouteTypeSchema.estimateSize(
              value, allOffsets[RouteType]!, allOffsets);
    }
  }
  bytesCount += 3 +
      GeoPointSchema.estimateSize(
          object.startPoint, allOffsets[GeoPoint]!, allOffsets);
  {
    final value = object.tips;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _newRouteSerialize(
  NewRoute object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.country);
  writer.writeString(offsets[1], object.coverImageUrl);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.difficulty?.name);
  writer.writeLong(offsets[4], object.durationMinutes);
  writer.writeDateTime(offsets[5], object.endDate);
  writer.writeObject<GeoPoint>(
    offsets[6],
    allOffsets,
    GeoPointSchema.serialize,
    object.endPoint,
  );
  writer.writeBool(offsets[7], object.isActive);
  writer.writeBool(offsets[8], object.isComplited);
  writer.writeBool(offsets[9], object.isLoop);
  writer.writeDouble(offsets[10], object.length);
  writer.writeString(offsets[11], object.name);
  writer.writeString(offsets[12], object.natureReserveUrl);
  writer.writeObjectList<Waypoint>(
    offsets[13],
    allOffsets,
    WaypointSchema.serialize,
    object.pointOfInterest,
  );
  writer.writeDouble(offsets[14], object.rating);
  writer.writeString(offsets[15], object.region);
  writer.writeObjectList<GeoPoint>(
    offsets[16],
    allOffsets,
    GeoPointSchema.serialize,
    object.routePoints,
  );
  writer.writeStringList(
      offsets[17], object.routeTags.map((e) => e.name).toList());
  writer.writeObject<RouteType>(
    offsets[18],
    allOffsets,
    RouteTypeSchema.serialize,
    object.routeType,
  );
  writer.writeDateTime(offsets[19], object.startDate);
  writer.writeObject<GeoPoint>(
    offsets[20],
    allOffsets,
    GeoPointSchema.serialize,
    object.startPoint,
  );
  writer.writeString(offsets[21], object.tips);
}

NewRoute _newRouteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NewRoute(
    country: reader.readStringOrNull(offsets[0]),
    coverImageUrl: reader.readStringOrNull(offsets[1]),
    description: reader.readStringOrNull(offsets[2]),
    difficulty:
        _NewRoutedifficultyValueEnumMap[reader.readStringOrNull(offsets[3])],
    durationMinutes: reader.readLongOrNull(offsets[4]),
    endDate: reader.readDateTimeOrNull(offsets[5]),
    endPoint: reader.readObjectOrNull<GeoPoint>(
      offsets[6],
      GeoPointSchema.deserialize,
      allOffsets,
    ),
    isActive: reader.readBool(offsets[7]),
    isComplited: reader.readBool(offsets[8]),
    isLoop: reader.readBoolOrNull(offsets[9]),
    isarId: id,
    length: reader.readDoubleOrNull(offsets[10]),
    name: reader.readString(offsets[11]),
    natureReserveUrl: reader.readStringOrNull(offsets[12]),
    pointOfInterest: reader.readObjectList<Waypoint>(
      offsets[13],
      WaypointSchema.deserialize,
      allOffsets,
      Waypoint(),
    ),
    rating: reader.readDoubleOrNull(offsets[14]),
    region: reader.readStringOrNull(offsets[15]),
    routePoints: reader.readObjectList<GeoPoint>(
      offsets[16],
      GeoPointSchema.deserialize,
      allOffsets,
      GeoPoint(),
    ),
    routeTags: reader
            .readStringList(offsets[17])
            ?.map((e) => _NewRouterouteTagsValueEnumMap[e] ?? TagEnum.Hiking)
            .toList() ??
        [],
    routeType: reader.readObjectOrNull<RouteType>(
      offsets[18],
      RouteTypeSchema.deserialize,
      allOffsets,
    ),
    startDate: reader.readDateTime(offsets[19]),
    startPoint: reader.readObjectOrNull<GeoPoint>(
          offsets[20],
          GeoPointSchema.deserialize,
          allOffsets,
        ) ??
        GeoPoint(),
    tips: reader.readStringOrNull(offsets[21]),
  );
  return object;
}

P _newRouteDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (_NewRoutedifficultyValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readObjectOrNull<GeoPoint>(
        offset,
        GeoPointSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readObjectList<Waypoint>(
        offset,
        WaypointSchema.deserialize,
        allOffsets,
        Waypoint(),
      )) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readObjectList<GeoPoint>(
        offset,
        GeoPointSchema.deserialize,
        allOffsets,
        GeoPoint(),
      )) as P;
    case 17:
      return (reader
              .readStringList(offset)
              ?.map((e) => _NewRouterouteTagsValueEnumMap[e] ?? TagEnum.Hiking)
              .toList() ??
          []) as P;
    case 18:
      return (reader.readObjectOrNull<RouteType>(
        offset,
        RouteTypeSchema.deserialize,
        allOffsets,
      )) as P;
    case 19:
      return (reader.readDateTime(offset)) as P;
    case 20:
      return (reader.readObjectOrNull<GeoPoint>(
            offset,
            GeoPointSchema.deserialize,
            allOffsets,
          ) ??
          GeoPoint()) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NewRoutedifficultyEnumValueMap = {
  r'Easy': r'Easy',
  r'Moderate': r'Moderate',
  r'Hard': r'Hard',
  r'Expert': r'Expert',
};
const _NewRoutedifficultyValueEnumMap = {
  r'Easy': DifficultyEnum.Easy,
  r'Moderate': DifficultyEnum.Moderate,
  r'Hard': DifficultyEnum.Hard,
  r'Expert': DifficultyEnum.Expert,
};
const _NewRouterouteTagsEnumValueMap = {
  r'Hiking': r'Hiking',
  r'Biking': r'Biking',
  r'Skiing': r'Skiing',
  r'JeepTouring': r'JeepTouring',
  r'Motorcycling': r'Motorcycling',
  r'AccessibleForWheelchairs': r'AccessibleForWheelchairs',
  r'FamilyFriendly': r'FamilyFriendly',
  r'SuitableForChildren': r'SuitableForChildren',
  r'PetFriendly': r'PetFriendly',
  r'ScenicViews': r'ScenicViews',
  r'HistoricalLandmarks': r'HistoricalLandmarks',
  r'WaterfallSightings': r'WaterfallSightings',
  r'BirdWatching': r'BirdWatching',
  r'CampingSites': r'CampingSites',
  r'WildflowerTrails': r'WildflowerTrails',
  r'MountainBiking': r'MountainBiking',
  r'CrossCountrySkiing': r'CrossCountrySkiing',
  r'Snowshoeing': r'Snowshoeing',
  r'NatureReserves': r'NatureReserves',
  r'EducationalTrails': r'EducationalTrails',
};
const _NewRouterouteTagsValueEnumMap = {
  r'Hiking': TagEnum.Hiking,
  r'Biking': TagEnum.Biking,
  r'Skiing': TagEnum.Skiing,
  r'JeepTouring': TagEnum.JeepTouring,
  r'Motorcycling': TagEnum.Motorcycling,
  r'AccessibleForWheelchairs': TagEnum.AccessibleForWheelchairs,
  r'FamilyFriendly': TagEnum.FamilyFriendly,
  r'SuitableForChildren': TagEnum.SuitableForChildren,
  r'PetFriendly': TagEnum.PetFriendly,
  r'ScenicViews': TagEnum.ScenicViews,
  r'HistoricalLandmarks': TagEnum.HistoricalLandmarks,
  r'WaterfallSightings': TagEnum.WaterfallSightings,
  r'BirdWatching': TagEnum.BirdWatching,
  r'CampingSites': TagEnum.CampingSites,
  r'WildflowerTrails': TagEnum.WildflowerTrails,
  r'MountainBiking': TagEnum.MountainBiking,
  r'CrossCountrySkiing': TagEnum.CrossCountrySkiing,
  r'Snowshoeing': TagEnum.Snowshoeing,
  r'NatureReserves': TagEnum.NatureReserves,
  r'EducationalTrails': TagEnum.EducationalTrails,
};

Id _newRouteGetId(NewRoute object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _newRouteGetLinks(NewRoute object) {
  return [];
}

void _newRouteAttach(IsarCollection<dynamic> col, Id id, NewRoute object) {
  object.isarId = id;
}

extension NewRouteQueryWhereSort on QueryBuilder<NewRoute, NewRoute, QWhere> {
  QueryBuilder<NewRoute, NewRoute, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NewRouteQueryWhere on QueryBuilder<NewRoute, NewRoute, QWhereClause> {
  QueryBuilder<NewRoute, NewRoute, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NewRouteQueryFilter
    on QueryBuilder<NewRoute, NewRoute, QFilterCondition> {
  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'country',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      coverImageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coverImageUrl',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      coverImageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coverImageUrl',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> coverImageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      coverImageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> coverImageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> coverImageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      coverImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> coverImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> coverImageUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> coverImageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      coverImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      coverImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionContains(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionMatches(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'difficulty',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      difficultyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'difficulty',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyEqualTo(
    DifficultyEnum? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyGreaterThan(
    DifficultyEnum? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyLessThan(
    DifficultyEnum? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyBetween(
    DifficultyEnum? lower,
    DifficultyEnum? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'difficulty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'difficulty',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      durationMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'durationMinutes',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      durationMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'durationMinutes',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      durationMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      durationMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      durationMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      durationMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endPointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endPoint',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endPointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endPoint',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isComplitedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isComplited',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isLoopIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isLoop',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isLoopIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isLoop',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isLoopEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLoop',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> lengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'length',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> lengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'length',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> lengthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'length',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> lengthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'length',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> lengthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'length',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> lengthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'length',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameEqualTo(
    String value, {
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameGreaterThan(
    String value, {
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameLessThan(
    String value, {
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameContains(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'natureReserveUrl',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'natureReserveUrl',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureReserveUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'natureReserveUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'natureReserveUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'natureReserveUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'natureReserveUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'natureReserveUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'natureReserveUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'natureReserveUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureReserveUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      natureReserveUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'natureReserveUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pointOfInterest',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pointOfInterest',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointOfInterest',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointOfInterest',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointOfInterest',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointOfInterest',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointOfInterest',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointOfInterest',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> ratingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> ratingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> ratingEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> ratingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> ratingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> ratingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'region',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'region',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'region',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'region',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'region',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> regionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'region',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routePointsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'routePoints',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routePointsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'routePoints',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routePointsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routePoints',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routePointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routePoints',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routePointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routePoints',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routePointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routePoints',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routePointsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routePoints',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routePointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routePoints',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementEqualTo(
    TagEnum value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementGreaterThan(
    TagEnum value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routeTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementLessThan(
    TagEnum value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routeTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementBetween(
    TagEnum lower,
    TagEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routeTags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routeTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routeTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routeTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routeTags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routeTags',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routeTags',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routeTags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routeTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routeTags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routeTags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routeTags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routeTags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      routeTagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'routeTags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routeTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'routeType',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routeTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'routeType',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> startDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tips',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tips',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tips',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tips',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tips',
        value: '',
      ));
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> tipsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tips',
        value: '',
      ));
    });
  }
}

extension NewRouteQueryObject
    on QueryBuilder<NewRoute, NewRoute, QFilterCondition> {
  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> endPoint(
      FilterQuery<GeoPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'endPoint');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition>
      pointOfInterestElement(FilterQuery<Waypoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pointOfInterest');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routePointsElement(
      FilterQuery<GeoPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'routePoints');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> routeType(
      FilterQuery<RouteType> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'routeType');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterFilterCondition> startPoint(
      FilterQuery<GeoPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'startPoint');
    });
  }
}

extension NewRouteQueryLinks
    on QueryBuilder<NewRoute, NewRoute, QFilterCondition> {}

extension NewRouteQuerySortBy on QueryBuilder<NewRoute, NewRoute, QSortBy> {
  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByCoverImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverImageUrl', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByCoverImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverImageUrl', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByIsComplited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplited', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByIsComplitedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplited', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByIsLoop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoop', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByIsLoopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoop', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByNatureReserveUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureReserveUrl', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByNatureReserveUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureReserveUrl', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByTips() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tips', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> sortByTipsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tips', Sort.desc);
    });
  }
}

extension NewRouteQuerySortThenBy
    on QueryBuilder<NewRoute, NewRoute, QSortThenBy> {
  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByCoverImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverImageUrl', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByCoverImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverImageUrl', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsComplited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplited', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsComplitedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isComplited', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsLoop() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoop', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsLoopDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLoop', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByNatureReserveUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureReserveUrl', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByNatureReserveUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureReserveUrl', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByTips() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tips', Sort.asc);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QAfterSortBy> thenByTipsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tips', Sort.desc);
    });
  }
}

extension NewRouteQueryWhereDistinct
    on QueryBuilder<NewRoute, NewRoute, QDistinct> {
  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByCountry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByCoverImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverImageUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByDifficulty(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficulty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMinutes');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByIsComplited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isComplited');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByIsLoop() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLoop');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'length');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByNatureReserveUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'natureReserveUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'region', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByRouteTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routeTags');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<NewRoute, NewRoute, QDistinct> distinctByTips(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tips', caseSensitive: caseSensitive);
    });
  }
}

extension NewRouteQueryProperty
    on QueryBuilder<NewRoute, NewRoute, QQueryProperty> {
  QueryBuilder<NewRoute, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<NewRoute, String?, QQueryOperations> countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<NewRoute, String?, QQueryOperations> coverImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverImageUrl');
    });
  }

  QueryBuilder<NewRoute, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<NewRoute, DifficultyEnum?, QQueryOperations>
      difficultyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficulty');
    });
  }

  QueryBuilder<NewRoute, int?, QQueryOperations> durationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMinutes');
    });
  }

  QueryBuilder<NewRoute, DateTime?, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<NewRoute, GeoPoint?, QQueryOperations> endPointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endPoint');
    });
  }

  QueryBuilder<NewRoute, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<NewRoute, bool, QQueryOperations> isComplitedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isComplited');
    });
  }

  QueryBuilder<NewRoute, bool?, QQueryOperations> isLoopProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLoop');
    });
  }

  QueryBuilder<NewRoute, double?, QQueryOperations> lengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'length');
    });
  }

  QueryBuilder<NewRoute, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<NewRoute, String?, QQueryOperations> natureReserveUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'natureReserveUrl');
    });
  }

  QueryBuilder<NewRoute, List<Waypoint>?, QQueryOperations>
      pointOfInterestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pointOfInterest');
    });
  }

  QueryBuilder<NewRoute, double?, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<NewRoute, String?, QQueryOperations> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'region');
    });
  }

  QueryBuilder<NewRoute, List<GeoPoint>?, QQueryOperations>
      routePointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routePoints');
    });
  }

  QueryBuilder<NewRoute, List<TagEnum>, QQueryOperations> routeTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeTags');
    });
  }

  QueryBuilder<NewRoute, RouteType?, QQueryOperations> routeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routeType');
    });
  }

  QueryBuilder<NewRoute, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<NewRoute, GeoPoint, QQueryOperations> startPointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startPoint');
    });
  }

  QueryBuilder<NewRoute, String?, QQueryOperations> tipsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tips');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WaypointSchema = Schema(
  name: r'Waypoint',
  id: 3211103457560820224,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 1,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'location': PropertySchema(
      id: 2,
      name: r'location',
      type: IsarType.object,
      target: r'GeoPoint',
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
      enumMap: _WaypointtypeEnumValueMap,
    )
  },
  estimateSize: _waypointEstimateSize,
  serialize: _waypointSerialize,
  deserialize: _waypointDeserialize,
  deserializeProp: _waypointDeserializeProp,
);

int _waypointEstimateSize(
  Waypoint object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.imageUrl.length * 3;
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 +
          GeoPointSchema.estimateSize(value, allOffsets[GeoPoint]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _waypointSerialize(
  Waypoint object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.imageUrl);
  writer.writeObject<GeoPoint>(
    offsets[2],
    allOffsets,
    GeoPointSchema.serialize,
    object.location,
  );
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.type?.name);
}

Waypoint _waypointDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Waypoint(
    description: reader.readStringOrNull(offsets[0]) ?? '',
    imageUrl: reader.readStringOrNull(offsets[1]) ?? '',
    location: reader.readObjectOrNull<GeoPoint>(
      offsets[2],
      GeoPointSchema.deserialize,
      allOffsets,
    ),
    name: reader.readStringOrNull(offsets[3]) ?? '',
    type: _WaypointtypeValueEnumMap[reader.readStringOrNull(offsets[4])],
  );
  return object;
}

P _waypointDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readObjectOrNull<GeoPoint>(
        offset,
        GeoPointSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (_WaypointtypeValueEnumMap[reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _WaypointtypeEnumValueMap = {
  r'Lake': r'Lake',
  r'Cliff': r'Cliff',
  r'Waterfall': r'Waterfall',
  r'WaterSpring': r'WaterSpring',
  r'River': r'River',
  r'MountainPeak': r'MountainPeak',
  r'Forest': r'Forest',
  r'Meadow': r'Meadow',
  r'Cave': r'Cave',
  r'Valley': r'Valley',
  r'Beach': r'Beach',
  r'Glacier': r'Glacier',
  r'Volcano': r'Volcano',
  r'HistoricalSite': r'HistoricalSite',
  r'VisitorCenter': r'VisitorCenter',
  r'Viewpoint': r'Viewpoint',
  r'Museum': r'Museum',
  r'CulturalSite': r'CulturalSite',
  r'EducationalTrail': r'EducationalTrail',
  r'ParkOffice': r'ParkOffice',
  r'SteepDrop': r'SteepDrop',
  r'SlipperyPath': r'SlipperyPath',
  r'HighTide': r'HighTide',
  r'WildlifeSighting': r'WildlifeSighting',
  r'FloodingArea': r'FloodingArea',
  r'Rockfall': r'Rockfall',
  r'RestrictedArea': r'RestrictedArea',
};
const _WaypointtypeValueEnumMap = {
  r'Lake': WaypointType.Lake,
  r'Cliff': WaypointType.Cliff,
  r'Waterfall': WaypointType.Waterfall,
  r'WaterSpring': WaypointType.WaterSpring,
  r'River': WaypointType.River,
  r'MountainPeak': WaypointType.MountainPeak,
  r'Forest': WaypointType.Forest,
  r'Meadow': WaypointType.Meadow,
  r'Cave': WaypointType.Cave,
  r'Valley': WaypointType.Valley,
  r'Beach': WaypointType.Beach,
  r'Glacier': WaypointType.Glacier,
  r'Volcano': WaypointType.Volcano,
  r'HistoricalSite': WaypointType.HistoricalSite,
  r'VisitorCenter': WaypointType.VisitorCenter,
  r'Viewpoint': WaypointType.Viewpoint,
  r'Museum': WaypointType.Museum,
  r'CulturalSite': WaypointType.CulturalSite,
  r'EducationalTrail': WaypointType.EducationalTrail,
  r'ParkOffice': WaypointType.ParkOffice,
  r'SteepDrop': WaypointType.SteepDrop,
  r'SlipperyPath': WaypointType.SlipperyPath,
  r'HighTide': WaypointType.HighTide,
  r'WildlifeSighting': WaypointType.WildlifeSighting,
  r'FloodingArea': WaypointType.FloodingArea,
  r'Rockfall': WaypointType.Rockfall,
  r'RestrictedArea': WaypointType.RestrictedArea,
};

extension WaypointQueryFilter
    on QueryBuilder<Waypoint, Waypoint, QFilterCondition> {
  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionEqualTo(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionLessThan(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionContains(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionMatches(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlEqualTo(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlGreaterThan(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlLessThan(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlStartsWith(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlEndsWith(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameEqualTo(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameGreaterThan(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameLessThan(
    String value, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeEqualTo(
    WaypointType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeGreaterThan(
    WaypointType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeLessThan(
    WaypointType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeBetween(
    WaypointType? lower,
    WaypointType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension WaypointQueryObject
    on QueryBuilder<Waypoint, Waypoint, QFilterCondition> {
  QueryBuilder<Waypoint, Waypoint, QAfterFilterCondition> location(
      FilterQuery<GeoPoint> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'location');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RouteTypeSchema = Schema(
  name: r'RouteType',
  id: 542760461257275683,
  properties: {
    r'type': PropertySchema(
      id: 0,
      name: r'type',
      type: IsarType.string,
      enumMap: _RouteTypetypeEnumValueMap,
    )
  },
  estimateSize: _routeTypeEstimateSize,
  serialize: _routeTypeSerialize,
  deserialize: _routeTypeDeserialize,
  deserializeProp: _routeTypeDeserializeProp,
);

int _routeTypeEstimateSize(
  RouteType object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _routeTypeSerialize(
  RouteType object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.type?.name);
}

RouteType _routeTypeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RouteType(
    type: _RouteTypetypeValueEnumMap[reader.readStringOrNull(offsets[0])],
  );
  return object;
}

P _routeTypeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_RouteTypetypeValueEnumMap[reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RouteTypetypeEnumValueMap = {
  r'hiking': r'hiking',
  r'biking': r'biking',
  r'motorcycle': r'motorcycle',
  r'jeep': r'jeep',
};
const _RouteTypetypeValueEnumMap = {
  r'hiking': RouteTypeEnum.hiking,
  r'biking': RouteTypeEnum.biking,
  r'motorcycle': RouteTypeEnum.motorcycle,
  r'jeep': RouteTypeEnum.jeep,
};

extension RouteTypeQueryFilter
    on QueryBuilder<RouteType, RouteType, QFilterCondition> {
  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeEqualTo(
    RouteTypeEnum? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeGreaterThan(
    RouteTypeEnum? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeLessThan(
    RouteTypeEnum? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeBetween(
    RouteTypeEnum? lower,
    RouteTypeEnum? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<RouteType, RouteType, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension RouteTypeQueryObject
    on QueryBuilder<RouteType, RouteType, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const GeoPointSchema = Schema(
  name: r'GeoPoint',
  id: -8531463882726182924,
  properties: {
    r'altitude': PropertySchema(
      id: 0,
      name: r'altitude',
      type: IsarType.double,
    ),
    r'latitude': PropertySchema(
      id: 1,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 2,
      name: r'longitude',
      type: IsarType.double,
    )
  },
  estimateSize: _geoPointEstimateSize,
  serialize: _geoPointSerialize,
  deserialize: _geoPointDeserialize,
  deserializeProp: _geoPointDeserializeProp,
);

int _geoPointEstimateSize(
  GeoPoint object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _geoPointSerialize(
  GeoPoint object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.altitude);
  writer.writeDouble(offsets[1], object.latitude);
  writer.writeDouble(offsets[2], object.longitude);
}

GeoPoint _geoPointDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GeoPoint(
    altitude: reader.readDoubleOrNull(offsets[0]),
    latitude: reader.readDoubleOrNull(offsets[1]),
    longitude: reader.readDoubleOrNull(offsets[2]),
  );
  return object;
}

P _geoPointDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension GeoPointQueryFilter
    on QueryBuilder<GeoPoint, GeoPoint, QFilterCondition> {
  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> altitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'altitude',
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> altitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'altitude',
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> altitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> altitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> altitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> altitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'altitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GeoPoint, GeoPoint, QAfterFilterCondition> longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension GeoPointQueryObject
    on QueryBuilder<GeoPoint, GeoPoint, QFilterCondition> {}
