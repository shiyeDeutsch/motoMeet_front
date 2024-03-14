import 'package:get_it/get_it.dart';

import 'MapMarkerService.dart';
import 'authService.dart';
import 'isar_service.dart';

void setupLocator(IsarService isar) {
  GetIt.I.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  GetIt.I.registerLazySingleton<MapMarkerService>(() => MapMarkerService());
  GetIt.I.registerLazySingleton<IsarService>(() => isar);
 }