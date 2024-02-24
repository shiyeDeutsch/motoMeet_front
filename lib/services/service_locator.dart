import 'package:get_it/get_it.dart';

import 'authService.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
 }