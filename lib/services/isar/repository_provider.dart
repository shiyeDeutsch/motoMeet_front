import 'package:isar/isar.dart';
import 'package:motomeetfront/services/isar/isar_activity.dart';
import 'package:motomeetfront/services/isar/isar_geo_location.dart';
import 'package:motomeetfront/services/isar/isar_user_info.dart';
import 'package:motomeetfront/services/isar/isar_theme_preferences.dart';
import 'package:motomeetfront/services/isar/isar_event.dart';
import 'package:motomeetfront/services/isar/isar_route_repository.dart';
import 'package:motomeetfront/services/isar/isar_location_sharing.dart';

/// Provider for all Isar repositories
class RepositoryProvider {
  final Isar _isar;

  late final IsarUserInfoRepository _userInfoRepository;
 // late final IsarUserRecentActivityRepository _activityRepository;
  late final IsarGeoLocationRepository _geoLocationRepository;
  late final IsarThemePreferencesRepository _themePreferencesRepository;
  late final EventRepository _eventRepository;
  
  // New route repositories
  late final IsarRouteRepository _routeRepository;
  late final IsarUserRouteRepository _userRouteRepository;
  late final IsarRoutePointRepository _routePointRepository;
  late final IsarUserRoutePointRepository _userRoutePointRepository;
  late final IsarPointOfInterestRepository _pointOfInterestRepository;
  
  // Location sharing repositories
  late final IsarSharedLocationRepository _sharedLocationRepository;
  late final IsarLocationSharingSessionRepository _locationSharingSessionRepository;

  RepositoryProvider(this._isar) {
    _userInfoRepository = IsarUserInfoRepository(_isar);
  //  _activityRepository = IsarUserRecentActivityRepository(_isar);
    _geoLocationRepository = IsarGeoLocationRepository(_isar);
    _themePreferencesRepository = IsarThemePreferencesRepository(_isar);
    _eventRepository = EventRepository(_isar);
    
    // Initialize new repositories
    _routeRepository = IsarRouteRepository(_isar);
    _userRouteRepository = IsarUserRouteRepository(_isar);
    _routePointRepository = IsarRoutePointRepository(_isar);
    _userRoutePointRepository = IsarUserRoutePointRepository(_isar);
    _pointOfInterestRepository = IsarPointOfInterestRepository(_isar);
    
    // Initialize location sharing repositories
    _sharedLocationRepository = IsarSharedLocationRepository(_isar);
    _locationSharingSessionRepository = IsarLocationSharingSessionRepository(_isar);
  }

  IsarUserInfoRepository get userInfoRepository => _userInfoRepository;
  // IsarUserRecentActivityRepository get activityRepository =>
  //     _activityRepository;
  IsarGeoLocationRepository get geoLocationRepository => _geoLocationRepository;
  IsarThemePreferencesRepository get themePreferencesRepository =>
      _themePreferencesRepository;
  EventRepository get eventRepository => _eventRepository;
  
  // Getters for new repositories
  IsarRouteRepository get routeRepository => _routeRepository;
  IsarUserRouteRepository get userRouteRepository => _userRouteRepository;
  IsarRoutePointRepository get routePointRepository => _routePointRepository;
  IsarUserRoutePointRepository get userRoutePointRepository => _userRoutePointRepository;
  IsarPointOfInterestRepository get pointOfInterestRepository => _pointOfInterestRepository;
  
  // Getters for location sharing repositories
  IsarSharedLocationRepository get sharedLocationRepository => _sharedLocationRepository;
  IsarLocationSharingSessionRepository get locationSharingSessionRepository => _locationSharingSessionRepository;
}
