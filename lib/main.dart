import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/routing/routes.dart';
import 'package:motomeetfront/services/service_locator.dart';
import 'package:motomeetfront/services/httpClient.dart';

import 'routing/InitialRoute.dart';
import 'routing/routeGenerator.dart';
// import 'routing/routes.dart';
import 'services/isar/isar_user_info.dart';
import 'stateProvider.dart';
import 'utilities/assetLoader.dart';

final providerContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    ByteData data = await rootBundle.load('assets/images/netfree-ca.crt');
    SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

    final isar = await Isar.open([UserInfoSchema], directory: 'path_to_directory');

  // Create a ProviderContainer for your app
  setupLocator(
    isar,
  );

  // Determine the initial route
  String initialRoute = await RouteService.getInitialRoute();
  runApp(ProviderScope(
      parent: providerContainer, child: MyApp(initialRoute: initialRoute)));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Navigator(
          initialRoute: initialRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
