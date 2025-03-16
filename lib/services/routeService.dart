import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motomeetfront/models/route.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';

class RoutesService {
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
}
