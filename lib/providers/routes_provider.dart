import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/newRoute.dart';
import 'package:motomeetfront/services/routeService.dart';
import '../models/route.dart';
import '../services/isar/isar_repository.dart';

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

class NearbyRoutesNotifier extends StateNotifier<List<Route>> {
  final RoutesService _routeService = GetIt.I<RoutesService>();

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

final recommendedRoutesProvider = StateNotifierProvider<RecommendedRoutesNotifier, List<Route>>((ref) {
  return RecommendedRoutesNotifier();
});

final nearbyRoutesProvider = StateNotifierProvider<NearbyRoutesNotifier, List<Route>>((ref) {
  return NearbyRoutesNotifier();
});

final routesProvider = StateNotifierProvider<RoutesNotifier, AsyncValue<List<Route>>>((ref) {
  final routeService = RoutesService();
  return RoutesNotifier(routeService);
});

class RoutesNotifier extends StateNotifier<AsyncValue<List<Route>>> {
  final RoutesService _routeService;
  List<Route> _allRoutes = [];
  String _searchQuery = '';
  String _category = 'All';
  String _sortBy = 'Popular';

  RoutesNotifier(this._routeService) : super(const AsyncValue.loading()) {
    loadRoutes();
  }

  Future<void> loadRoutes() async {
    try {
      state = const AsyncValue.loading();
      final recommended = await _routeService.getRecommendedRoutes();
      final nearby = await _routeService.getNearbyRoutes();
      _allRoutes = [...recommended, ...nearby];
      _filterAndSortRoutes();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void searchRoutes(String query) {
    _searchQuery = query.toLowerCase();
    _filterAndSortRoutes();
  }

  void filterByCategory(String category) {
    _category = category;
    _filterAndSortRoutes();
  }

  void sortRoutes(String sortBy) {
    _sortBy = sortBy;
    _filterAndSortRoutes();
  }

  void _filterAndSortRoutes() {
    List<Route> filteredRoutes = List.from(_allRoutes);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredRoutes = filteredRoutes.where((route) {
        return route.name.toLowerCase().contains(_searchQuery) ||
            (route.description?.toLowerCase() ?? '').contains(_searchQuery);
      }).toList();
    }

    // Apply category filter
    if (_category != 'All') {
      filteredRoutes = filteredRoutes.where((route) => 
        route.routeType?.name == _category
      ).toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'Popular':
        filteredRoutes.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Distance':
        filteredRoutes.sort((a, b) => (b.length ?? 0).compareTo(a.length ?? 0));
        break;
      case 'Rating':
        filteredRoutes.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Recent':
        filteredRoutes.sort((a, b) {
          final bDate = b.startDate;
          final aDate = a.startDate;
          if (bDate == null || aDate == null) return 0;
          return bDate.compareTo(aDate);
        });
        break;
    }

    state = AsyncValue.data(filteredRoutes);
  }
}
