import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/routing/routes.dart';
import 'package:motomeetfront/services/service_locator.dart';

import 'routing/InitialRoute.dart';
import 'routing/routeGenerator.dart';
// import 'routing/routes.dart';
import 'services/isar_service.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Isar
  IsarService isarService = IsarService();
  await isarService.initIsar();
  setupLocator(isarService);

  // Determine the initial route
  String initialRoute = await RouteService.getInitialRoute();
  runApp(ProviderScope(child: MyApp(initialRoute: initialRoute)));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner :false,
      home: Scaffold(  
        body: Navigator(
          initialRoute: initialRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }


}
