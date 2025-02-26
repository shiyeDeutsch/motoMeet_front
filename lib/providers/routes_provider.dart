import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/newRoute.dart';
import 'package:motomeetfront/services/routeService.dart';

class RecommendedRoutesNotifier extends StateNotifier<List<NewRoute>> {
  final RouteService _routeService = GetIt.I<RouteService>();

  RecommendedRoutesNotifier() : super([]);

  Future<void> loadRecommendedRoutes({bool refresh = false}) async {
    if (state.isNotEmpty && !refresh) return;

    try {
      final routes = await _routeService.getRecommendedRoutes();
      state = routes;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}

class NearbyRoutesNotifier extends StateNotifier<List<NewRoute>> {
  final RouteService _routeService = GetIt.I<RouteService>();

  NearbyRoutesNotifier() : super([]);

  Future<void> loadNearbyRoutes({bool refresh = false}) async {
    if (state.isNotEmpty && !refresh) return;

    try {
      final routes = await _routeService.getNearbyRoutes();
      state = routes;
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}

final recommendedRoutesProvider = StateNotifierProvider<RecommendedRoutesNotifier, List<NewRoute>>((ref) {
  return RecommendedRoutesNotifier();
});

final nearbyRoutesProvider = StateNotifierProvider<NearbyRoutesNotifier, List<NewRoute>>((ref) {
  return NearbyRoutesNotifier();
});
