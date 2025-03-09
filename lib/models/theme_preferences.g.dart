// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetThemePreferencesCollection on Isar {
  IsarCollection<ThemePreferences> get themePreferences => this.collection();
}

const ThemePreferencesSchema = CollectionSchema(
  name: r'ThemePreferences',
  id: -4106280960840802790,
  properties: {
    r'theme_mode': PropertySchema(
      id: 0,
      name: r'theme_mode',
      type: IsarType.string,
    ),
    r'theme_type': PropertySchema(
      id: 1,
      name: r'theme_type',
      type: IsarType.string,
    )
  },
  estimateSize: _themePreferencesEstimateSize,
  serialize: _themePreferencesSerialize,
  deserialize: _themePreferencesDeserialize,
  deserializeProp: _themePreferencesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _themePreferencesGetId,
  getLinks: _themePreferencesGetLinks,
  attach: _themePreferencesAttach,
  version: '3.1.0+1',
);

int _themePreferencesEstimateSize(
  ThemePreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.themeMode.length * 3;
  bytesCount += 3 + object.themeType.length * 3;
  return bytesCount;
}

void _themePreferencesSerialize(
  ThemePreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.themeMode);
  writer.writeString(offsets[1], object.themeType);
}

ThemePreferences _themePreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ThemePreferences();
  object.id = id;
  object.themeMode = reader.readString(offsets[0]);
  object.themeType = reader.readString(offsets[1]);
  return object;
}

P _themePreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _themePreferencesGetId(ThemePreferences object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _themePreferencesGetLinks(ThemePreferences object) {
  return [];
}

void _themePreferencesAttach(
    IsarCollection<dynamic> col, Id id, ThemePreferences object) {
  object.id = id;
}

extension ThemePreferencesQueryWhereSort
    on QueryBuilder<ThemePreferences, ThemePreferences, QWhere> {
  QueryBuilder<ThemePreferences, ThemePreferences, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ThemePreferencesQueryWhere
    on QueryBuilder<ThemePreferences, ThemePreferences, QWhereClause> {
  QueryBuilder<ThemePreferences, ThemePreferences, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterWhereClause>
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

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterWhereClause> idBetween(
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

extension ThemePreferencesQueryFilter
    on QueryBuilder<ThemePreferences, ThemePreferences, QFilterCondition> {
  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
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

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      idLessThan(
    Id value, {
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

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme_mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'theme_mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'theme_mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'theme_mode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'theme_mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'theme_mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'theme_mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'theme_mode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme_mode',
        value: '',
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'theme_mode',
        value: '',
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'theme_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'theme_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'theme_type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'theme_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'theme_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'theme_type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'theme_type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme_type',
        value: '',
      ));
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterFilterCondition>
      themeTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'theme_type',
        value: '',
      ));
    });
  }
}

extension ThemePreferencesQueryObject
    on QueryBuilder<ThemePreferences, ThemePreferences, QFilterCondition> {}

extension ThemePreferencesQueryLinks
    on QueryBuilder<ThemePreferences, ThemePreferences, QFilterCondition> {}

extension ThemePreferencesQuerySortBy
    on QueryBuilder<ThemePreferences, ThemePreferences, QSortBy> {
  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_mode', Sort.asc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_mode', Sort.desc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      sortByThemeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_type', Sort.asc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      sortByThemeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_type', Sort.desc);
    });
  }
}

extension ThemePreferencesQuerySortThenBy
    on QueryBuilder<ThemePreferences, ThemePreferences, QSortThenBy> {
  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_mode', Sort.asc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_mode', Sort.desc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      thenByThemeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_type', Sort.asc);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QAfterSortBy>
      thenByThemeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme_type', Sort.desc);
    });
  }
}

extension ThemePreferencesQueryWhereDistinct
    on QueryBuilder<ThemePreferences, ThemePreferences, QDistinct> {
  QueryBuilder<ThemePreferences, ThemePreferences, QDistinct>
      distinctByThemeMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme_mode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemePreferences, ThemePreferences, QDistinct>
      distinctByThemeType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme_type', caseSensitive: caseSensitive);
    });
  }
}

extension ThemePreferencesQueryProperty
    on QueryBuilder<ThemePreferences, ThemePreferences, QQueryProperty> {
  QueryBuilder<ThemePreferences, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ThemePreferences, String, QQueryOperations> themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme_mode');
    });
  }

  QueryBuilder<ThemePreferences, String, QQueryOperations> themeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme_type');
    });
  }
}
