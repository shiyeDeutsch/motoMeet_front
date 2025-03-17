import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motomeetfront/models/route.dart';
import 'package:motomeetfront/models/enum.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:flutter/foundation.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:get_it/get_it.dart';

class RoutesService {
  final _repoProvider = GetIt.I<RepositoryProvider>();

  /// Get recommended routes from the server
  Future<List<Route>> getRecommendedRoutes() async {
    try {
      final response = await http.get(ApiEndpoints.recommendedRoutes);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Route.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recommended routes');
      }
    } catch (e) {
      throw Exception('Failed to load recommended routes: $e');
    }
  }

  /// Get nearby routes from the server
  Future<List<Route>> getNearbyRoutes() async {
    try {
      final response = await http.get(ApiEndpoints.nearbyRoutes);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Route.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load nearby routes');
      }
    } catch (e) {
      throw Exception('Failed to load nearby routes: $e');
    }
  }
  
  /// Get all routes with search parameters
  Future<List<Route>> getRoutes({
    String? searchQuery,
    RouteType? routeType,
    String? sortBy,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['query'] = searchQuery;
      }
      if (routeType != null) {
        queryParams['routeType'] = routeType.name.toLowerCase();
      }
      if (sortBy != null) {
        queryParams['sortBy'] = sortBy.toLowerCase();
      }

      // Create the URI with query parameters
      final uri = ApiEndpoints.routes.replace(queryParameters: queryParams);
      
      // Make the API call
      final response = await HttpClient.get(uri);
      
      if (response.statusCode == 200) {
        final List<dynamic> routesJson = jsonDecode(response.body);
        final routes = routesJson.map((json) => Route.fromJson(json)).toList();
        
        // Cache the routes locally
        await _cacheRoutes(routes);
        
        return routes;
      } else {
        // If server request fails, try to get routes from local cache
        if (kDebugMode) {
          print('Failed to fetch routes from server. Using local cache.');
        }
        return _getRoutesFromLocalCache(searchQuery, routeType, sortBy);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching routes from server: $e');
      }
      // On error, fallback to local cache
      return _getRoutesFromLocalCache(searchQuery, routeType, sortBy);
    }
  }
  
  /// Cache routes locally
  Future<void> _cacheRoutes(List<Route> routes) async {
    for (final route in routes) {
      if (route.id != null) {
        try {
          final existingRoute = await _repoProvider.routeRepository.getById(route.id!);
          if (existingRoute == null) {
            await _repoProvider.routeRepository.add(route);
          } else {
            await _repoProvider.routeRepository.update(route);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error caching route: $e');
          }
        }
      }
    }
  }
  
  /// Get routes from local cache with filtering and sorting
  Future<List<Route>> _getRoutesFromLocalCache(
    String? searchQuery,
    RouteType? routeType,
    String? sortBy,
  ) async {
    try {
      // Get all routes from local database
      final routes = await _repoProvider.routeRepository.getAll();
      
      // Apply filters
      final filteredRoutes = _filterRoutes(routes, searchQuery, routeType);
      
      // Apply sorting
      return _sortRoutes(filteredRoutes, sortBy);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting routes from local cache: $e');
      }
      return [];
    }
  }
  
  /// Filter routes by search query and routeType
  List<Route> _filterRoutes(
    List<Route> routes,
    String? searchQuery,
    RouteType? routeType,
  ) {
    return routes.where((route) {
      // Apply search filter
      final matchesSearch = searchQuery == null || searchQuery.isEmpty ||
          route.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (route.description?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);

      // Apply routeType filter
      final matchesRouteType = routeType == null || route.routeType == routeType;

      return matchesSearch && matchesRouteType;
    }).toList();
  }

  /// Sort routes by the selected sort option
  List<Route> _sortRoutes(List<Route> routes, String? sortBy) {
    if (sortBy == null) return routes;
    
    switch (sortBy) {
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
        return routes
          ..sort((a, b) => (b.startDate ?? DateTime.now())
              .compareTo(a.startDate ?? DateTime.now()));
      default:
        return routes;
    }
  }
}
