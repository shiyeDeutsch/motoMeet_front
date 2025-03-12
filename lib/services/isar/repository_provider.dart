import 'package:isar/isar.dart';
import 'package:motomeetfront/services/isar/isar_activity.dart';
import 'package:motomeetfront/services/isar/isar_geo_location.dart';
import 'package:motomeetfront/services/isar/isar_user_info.dart';
import 'package:motomeetfront/services/isar/isar_theme_preferences.dart';
import 'package:motomeetfront/services/isar/isar_event.dart';

/// Provider for all Isar repositories
class RepositoryProvider {
  final Isar _isar;

  late final IsarUserInfoRepository _userInfoRepository;
 // late final IsarUserRecentActivityRepository _activityRepository;
  late final IsarGeoLocationRepository _geoLocationRepository;
  late final IsarThemePreferencesRepository _themePreferencesRepository;
  late final EventRepository _eventRepository;

  RepositoryProvider(this._isar) {
    _userInfoRepository = IsarUserInfoRepository(_isar);
  //  _activityRepository = IsarUserRecentActivityRepository(_isar);
    _geoLocationRepository = IsarGeoLocationRepository(_isar);
    _themePreferencesRepository = IsarThemePreferencesRepository(_isar);
    _eventRepository = EventRepository(_isar);
  }

  IsarUserInfoRepository get userInfoRepository => _userInfoRepository;
  // IsarUserRecentActivityRepository get activityRepository =>
  //     _activityRepository;
  IsarGeoLocationRepository get geoLocationRepository => _geoLocationRepository;
  IsarThemePreferencesRepository get themePreferencesRepository =>
      _themePreferencesRepository;
  EventRepository get eventRepository => _eventRepository;
}
