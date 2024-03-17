import 'package:get_it/get_it.dart';
import 'package:motomeetfront/services/routeService.dart';

import 'MapMarkerService.dart';
import 'authService.dart';
import 'isar_service.dart';

void setupLocator(IsarService isar) {
  // Inside your GetIt setup file or where you configure your dependencies
  GetIt.I.registerLazySingleton<RouteService>(() => RouteService());
  GetIt.I.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  GetIt.I.registerLazySingleton<MapMarkerService>(() => MapMarkerService());
  GetIt.I.registerLazySingleton<IsarService>(() => isar);
}
