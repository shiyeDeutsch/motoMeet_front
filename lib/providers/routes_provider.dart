import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../models/route.dart';
import '../services/httpClient.dart';
import '../services/isar/repository_provider.dart';
import '../services/routeService.dart';
import '../utilities/apiEndPoints.dart';

/// Provider for routes data
final routesProvider = StateNotifierProvider<RoutesNotifier, AsyncValue<List<Route>>>((ref) {
  return RoutesNotifier();
});

/// Notifier for routes data
class RoutesNotifier extends StateNotifier<AsyncValue<List<Route>>> {
  RoutesNotifier() : super(const AsyncValue.loading()) {
    fetchRoutes();
  }

  final _repoProvider = GetIt.I<RepositoryProvider>();
  String _searchQuery = '';
  String _category = 'All';
  String _sortBy = 'Popular';

  /// Fetch routes from server and local database
  Future<void> fetchRoutes() async {
    try {
      state = const AsyncValue.loading();
      
      // First, get routes from local database
      final localRoutes = await _repoProvider.routeRepository.getAll();
      
      // Then, try to fetch from server
      List<Route> serverRoutes = [];
      try {
        final response = await HttpClient.get(ApiEndpoints.routes);
        if (response.statusCode == 200) {
          final List<dynamic> routesJson = jsonDecode(response.body);
          serverRoutes = routesJson.map((json) => Route.fromJson(json)).toList();
          
          // Save server routes to local database
          for (final route in serverRoutes) {
            if (route.id != null) {
              // Check if we already have this route locally
              final existingRoute = await _repoProvider.routeRepository.getById(route.id!);
              if (existingRoute == null) {
                await _repoProvider.routeRepository.add(route);
              } else {
                await _repoProvider.routeRepository.update(route);
              }
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching routes from server: $e');
        }
        // Continue with local routes only
      }
      
      // Combine local and server routes, removing duplicates
      final Map<int?, Route> routesMap = {};
      for (final route in [...localRoutes, ...serverRoutes]) {
        if (route.id != null) {
          routesMap[route.id] = route;
        }
      }
      
      final List<Route> allRoutes = routesMap.values.toList();
      
      // Apply filters and sorting
      final filteredRoutes = _filterRoutes(allRoutes);
      final sortedRoutes = _sortRoutes(filteredRoutes);
      
      state = AsyncValue.data(sortedRoutes);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Filter routes by search query and category
  List<Route> _filterRoutes(List<Route> routes) {
    return routes.where((route) {
      // Apply search filter
      final matchesSearch = _searchQuery.isEmpty ||
          route.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (route.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      
      // Apply category filter
      final matchesCategory = _category == 'All' ||
          (route.routeType?.toString().split('.').last == _category);
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  /// Sort routes by the selected sort option
  List<Route> _sortRoutes(List<Route> routes) {
    switch (_sortBy) {
      case 'Popular':
        // Sort by rating (descending)
        return routes..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      case 'Distance':
        // Sort by length (descending)
        return routes..sort((a, b) => (b.length ?? 0).compareTo(a.length ?? 0));
      case 'Rating':
        // Sort by rating (descending)
        return routes..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      case 'Recent':
        // Sort by start date (descending)
        return routes..sort((a, b) => (b.startDate ?? DateTime.now())
            .compareTo(a.startDate ?? DateTime.now()));
      default:
        return routes;
    }
  }

  /// Search routes by query
  void searchRoutes(String query) {
    _searchQuery = query;
    _refreshRoutes();
  }

  /// Filter routes by category
  void filterByCategory(String category) {
    _category = category;
    _refreshRoutes();
  }

  /// Sort routes by option
  void sortRoutes(String sortBy) {
    _sortBy = sortBy;
    _refreshRoutes();
  }

  /// Refresh routes with current filters and sorting
  void _refreshRoutes() {
    if (state.value != null) {
      final filteredRoutes = _filterRoutes(state.value!);
      final sortedRoutes = _sortRoutes(filteredRoutes);
      state = AsyncValue.data(sortedRoutes);
    }
  }
}
final recommendedRoutesProvider = StateNotifierProvider<RecommendedRoutesNotifier, List<Route>>((ref) {
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
