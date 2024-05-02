import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:motomeetfront/services/routeService.dart';

import '../stateProvider.dart';
import 'MapMarkerService.dart';
import 'authService.dart';
import 'isar/isar_user_info.dart';
import 'isar/reposetory_provider.dart';

void setupLocator(Isar isarInstance) {
  // Register other services as usual
  GetIt.I.registerLazySingleton<RouteService>(() => RouteService());
  GetIt.I.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  GetIt.I.registerLazySingleton<MapMarkerService>(() => MapMarkerService());

 // Register the RepositoryProvider
  GetIt.I.registerLazySingleton<RepositoryProvider>(() => RepositoryProvider(isarInstance));
}
