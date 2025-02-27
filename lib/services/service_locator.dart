import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:motomeetfront/services/routeService.dart';
import 'package:motomeetfront/services/activity_service.dart';
import 'package:motomeetfront/services/authService.dart';
import 'package:motomeetfront/services/events_service.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/userService.dart';
import 'package:motomeetfront/services/isar/isar_initializer.dart';
import 'package:motomeetfront/services/loctionService.dart';
import 'package:motomeetfront/services/MapMarkerService.dart';

import '../stateProvider.dart';
import 'MapMarkerService.dart';
import 'authService.dart';
import 'isar/isar_user_info.dart';
import 'isar/repository_provider.dart';
import 'userService.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core services
  getIt.registerSingleton<HttpClient>(HttpClient());
  getIt.registerSingletonAsync<IsarInitializer>(() async {
    final initializer = IsarInitializer();
    await initializer.initialize();
    return initializer;
  });

  // API services
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<RouteService>(RouteService());
  getIt.registerSingleton<LocationService>(LocationService());
  getIt.registerSingleton<MapMarkerService>(MapMarkerService());
  getIt.registerSingleton<EventsService>(EventsService());
  getIt.registerSingleton<ActivityService>(ActivityService());
}
