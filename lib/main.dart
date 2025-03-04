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
import 'package:path_provider/path_provider.dart';

import 'routing/InitialRoute.dart';
import 'routing/routeGenerator.dart';
import 'services/isar/isar_user_info.dart';
import 'services/isar/isar_theme_preferences.dart';
import 'stateProvider.dart';
import 'utilities/assetLoader.dart';
import 'theme/theme_provider.dart';

final providerContainer = ProviderContainer();

// Global provider for BuildContext
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kDebugMode) {
    ByteData data = await rootBundle.load('assets/images/netfree-ca.crt');
    SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }
  
  // Initialize services
  setupLocator();

  // Determine the initial route
  String initialRoute = await RouteService.getInitialRoute();
  
  runApp(
    ProviderScope(
      parent: providerContainer,
      overrides: [
        // Override theme service provider
        themePreferencesServiceProvider.overrideWithValue(
          locator<IsarThemePreferencesService>()
        ),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Set up the context provider override
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(contextProvider.notifier).state = context;
    });
    
    // Get theme state from provider
    final themeState = ref.watch(themeProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'MotoMeet',
      theme: themeState.currentTheme.lightTheme,
      darkTheme: themeState.currentTheme.darkTheme,
      themeMode: themeState.flutterThemeMode,
      home: Scaffold(
        body: Navigator(
          initialRoute: initialRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}

/// Provider for accessing BuildContext
final contextProvider = StateProvider<BuildContext>((ref) {
  // This will be overridden in the MyApp build method
  throw UnimplementedError('Context provider not initialized');
});
