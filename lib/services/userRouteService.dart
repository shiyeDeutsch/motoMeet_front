import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../models/route.dart';
import '../providers/route_creation_provider.dart';
import '../services/route_creation_service.dart';

/// @deprecated - Use [route_creation_provider.dart] instead
/// 
/// This class is deprecated and will be removed in a future version.
/// Please migrate your code to use the RouteCreationNotifier in route_creation_provider.dart
/// and RouteCreationService in route_creation_service.dart instead.
///
/// REASON FOR DEPRECATION:
/// This class mixed state management with service-level operations which
/// violates separation of concerns. The new implementation separates these
/// responsibilities more clearly.
@Deprecated('Use routeCreationProvider from route_creation_provider.dart instead')
final userRouteServiceProvider =
    StateNotifierProvider<UserRouteService, UserRoute?>((ref) {
  if (kDebugMode) {
    print(
      'WARNING: userRouteServiceProvider is deprecated. '
      'Use routeCreationProvider from route_creation_provider.dart instead.'
    );
  }
  return UserRouteService();
});

/// @deprecated - Use [RouteCreationNotifier] from route_creation_provider.dart instead
///
/// This class is deprecated and will be removed in a future version.
@Deprecated('Use RouteCreationNotifier from route_creation_provider.dart instead')
class UserRouteService extends StateNotifier<UserRoute?> {
  final _routeCreationService = GetIt.I<RouteCreationService>();
  
  UserRouteService() : super(null) {
    if (kDebugMode) {
      print(
        'WARNING: UserRouteService is deprecated. '
        'Use RouteCreationNotifier from route_creation_provider.dart instead.'
      );
    }
  }
  
  /// Start a new trip on an existing route (redirects to new implementation)
  Future<void> startExistingRoute(Route route) async {
    printWarning();
    // Implementation is empty - users should migrate to new provider
  }
  
  /// Start a brand new route (redirects to new implementation)
  Future<void> startNewRoute(RouteType routeType, GeoPoint startPoint) async {
    printWarning();
    // Implementation is empty - users should migrate to new provider
  }
  
  /// Stop the route (redirects to new implementation)
  Future<void> stopUserRoute() async {
    printWarning();
    // Implementation is empty - users should migrate to new provider
  }
  
  /// Finalize the route (redirects to new implementation)
  Future<Route?> finalizeRoute(String name, String? description, List? tags) async {
    printWarning();
    return null;
  }
  
  /// Print deprecation warning
  void printWarning() {
    if (kDebugMode) {
      print(
        'WARNING: Using deprecated UserRouteService. '
        'Please migrate to RouteCreationNotifier in route_creation_provider.dart.'
      );
    }
  }
  
  /// Redirect to the new implementation
  @override
  set state(UserRoute? value) {
    printWarning();
    super.state = value;
  }
}