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
import 'isar/isar_repository.dart';
import 'isar/isar_theme_preferences.dart';

import '../stateProvider.dart';
import 'MapMarkerService.dart';
import 'authService.dart';
import 'isar/isar_user_info.dart';
import 'isar/repository_provider.dart';
import 'userService.dart';

final locator = GetIt.instance;

void setupLocator() async {
  GetIt.I.registerLazySingleton<RouteService>(() => RouteService());
  GetIt.I.registerLazySingleton<AuthService>(() => AuthService());
  GetIt.I.registerLazySingleton<EventsService>(() => EventsService());
  GetIt.I.registerLazySingleton<ActivityService>(() => ActivityService());
  GetIt.I.registerLazySingleton<MapMarkerService>(() => MapMarkerService());
  GetIt.I.registerLazySingleton<UserService>(() => UserService());

  // Register the IsarInitializer
  final IsarInitializer isarInitializer = IsarInitializer();
  await isarInitializer.initialize();
  final Isar isarInstance = isarInitializer.getInstance();
  GetIt.I.registerLazySingleton<RepositoryProvider>(() => RepositoryProvider(isarInstance));

  // Repository
  locator.registerLazySingleton<IsarRepository>(() => IsarRepository());

  // Services
  locator.registerLazySingleton<IsarThemePreferencesService>(
    () => IsarThemePreferencesService(locator<IsarRepository>())
  );
}