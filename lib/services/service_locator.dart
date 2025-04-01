import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:motomeetfront/services/routesService.dart';
import 'package:motomeetfront/services/authService.dart';
import 'package:motomeetfront/services/events_service.dart';
import 'package:motomeetfront/services/userService.dart';
import 'package:motomeetfront/services/isar/isar_initializer.dart';
import 'package:motomeetfront/services/route_creation_service.dart';
 

import 'isar/repository_provider.dart';


Future<void> setupLocator( )async  {
 
    GetIt.I.registerLazySingleton<RoutesService>(() => RoutesService());
  GetIt.I.registerLazySingleton<AuthService>(() => AuthService());
   GetIt.I.registerLazySingleton<EventsService>(() => EventsService());
  //  GetIt.I.registerLazySingleton<ActivityService>(() => ActivityService());
  // GetIt.I.registerLazySingleton<MapMarkerService>(() => MapMarkerService());
  GetIt.I.registerLazySingleton<UserService>(() => UserService());
  
  // Register the RouteCreationService (replaces UserRouteService)
  GetIt.I.registerLazySingleton<RouteCreationService>(() => RouteCreationService());
  
  
  // Register the IsarInitializer
  final IsarInitializer isarInitializer = IsarInitializer();
  await isarInitializer.initialize();
  final Isar isarInstance = isarInitializer.getInstance();
  GetIt.I.registerLazySingleton<RepositoryProvider>(() => RepositoryProvider(isarInstance));


 
}