import 'package:flutter/material.dart';
import 'package:motomeetfront/services/service_locator.dart';

import 'routing/routeGenerator.dart';
import 'routing/routes.dart';

 void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
     
      initialRoute: Routes.login,
       onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
