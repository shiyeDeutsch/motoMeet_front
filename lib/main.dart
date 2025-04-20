import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'routing/InitialRoute.dart';
import 'routing/routeGenerator.dart';
import 'services/service_locator.dart';
import 'theme/theme_provider.dart';
import 'constants/map_utilties.dart';

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

  // Set Mapbox access token globally
  MapboxOptions.setAccessToken(MapboxConfig.ACCESS_TOKEN);

  // Initialize services
  await setupLocator();

  // Determine the initial route
  String initialRoute = await RouteService.getInitialRoute();

  runApp(
    ProviderScope(
      parent: providerContainer,
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

    return Consumer(
      builder: (context, watch, child) {
        final contextState = ref.watch(contextProvider);
        if (contextState == null) {
          return const SizedBox.shrink(); // or a loading indicator
        }

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
      },
    );
  }
}

/// Provider for accessing BuildContext
final contextProvider = StateProvider<BuildContext?>((ref) {
  // This will be overridden in the MyApp build method
  return null;
});
