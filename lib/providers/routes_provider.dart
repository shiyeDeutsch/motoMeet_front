import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../models/route.dart';
import '../models/enum.dart';
import '../services/routesService.dart';

/// Provider for routes data
final routesProvider =
    StateNotifierProvider<RoutesNotifier, AsyncValue<List<Route>>>((ref) {
  return RoutesNotifier();
});

/// Notifier for routes data
class RoutesNotifier extends StateNotifier<AsyncValue<List<Route>>> {
  RoutesNotifier() : super(const AsyncValue.loading()) {
    fetchRoutes();
  }

  final _routesService = GetIt.I<RoutesService>();
  String _searchQuery = '';
  RouteType? _routeType; // Changed from String _category to RouteType?
  String _sortBy = 'Popular';

  /// Fetch routes with current filters and sort options
  Future<void> fetchRoutes() async {
    try {
      state = const AsyncValue.loading();
      
      final routes = await _routesService.getRoutes(
        searchQuery: _searchQuery,
        routeType: _routeType, // Changed from category to routeType
        sortBy: _sortBy,
      );
      
      state = AsyncValue.data(routes);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Search routes by query
  void searchRoutes(String query) {
    _searchQuery = query;
    fetchRoutes();
  }

  /// Filter routes by type
  void filterByRouteType(RouteType? routeType) { // Changed from filterByCategory to filterByRouteType
    _routeType = routeType;
    fetchRoutes();
  }

  /// Sort routes by option
  void sortRoutes(String sortBy) {
    _sortBy = sortBy;
    fetchRoutes();
  }
}

final recommendedRoutesProvider =
    StateNotifierProvider<RecommendedRoutesNotifier, List<Route>>((ref) {
  return RecommendedRoutesNotifier();
});

class RecommendedRoutesNotifier extends StateNotifier<List<Route>> {
  final RoutesService _routeService = GetIt.I<RoutesService>();

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
