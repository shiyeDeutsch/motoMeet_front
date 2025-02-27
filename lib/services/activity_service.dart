import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/activity.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/isar/isar_activity.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';

class ActivityService {
  final _repositoryProvider = GetIt.I<RepositoryProvider>();
  final HttpClient _httpClient;

  ActivityService({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  ActivityRepository get _activityRepository =>
    _repositoryProvider.activityRepository;

  Future<List<UserActivity>> getRecentActivities({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Try to get from API first
      final response = await HttpClient.get(
        '${EndPoints.activities}?page=$page&limit=$limit',
        headers: await _getAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final activities = data.map((json) => UserActivity.fromJson(json)).toList();
        
        // Save to local database if it's the first page
        if (page == 1) {
          await _saveActivitiesToLocal(activities);
        }
        
        return activities;
      }
      
      // If API fails or we're offline, get from local database
      return await _getActivitiesFromLocal(page, limit);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching activities: $e');
      }
      
      // On error, try to get from local database
      return await _getActivitiesFromLocal(page, limit);
    }
  }

  Future<List<UserActivity>> _getActivitiesFromLocal(int page, int limit) async {
    final skipCount = (page - 1) * limit;
    final activities = await _activityRepository.getActivities(
      skip: skipCount,
      limit: limit,
    );
    return activities;
  }

  Future<void> _saveActivitiesToLocal(List<UserActivity> activities) async {
    await _activityRepository.saveActivities(activities);
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    // Implementation depends on your auth service
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer yourAuthTokenHere'
    };
  }

  // Get all activity types
  Future<List<ActivityType>> getActivityTypes() async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.activityTypes,
      );

      return (response.data as List)
          .map((activityJson) => ActivityType.fromJson(activityJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load activity types: $e');
    }
  }

  // Get activity type by ID
  Future<ActivityType> getActivityTypeById(String activityTypeId) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.activityTypes}/$activityTypeId',
      );

      return ActivityType.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load activity type: $e');
    }
  }

  // Get popular activity types
  Future<List<ActivityType>> getPopularActivityTypes({int limit = 5}) async {
    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.activityTypes}/popular',
        queryParameters: {'limit': limit.toString()},
      );

      return (response.data as List)
          .map((activityJson) => ActivityType.fromJson(activityJson))
          .toList();
    } catch (e) {
      throw Exception('Failed to load popular activity types: $e');
    }
  }

  // Create a custom activity type (for admin users)
  Future<bool> createActivityType(ActivityType activityType) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.activityTypes,
        data: activityType.toJson(),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to create activity type: $e');
    }
  }

  // Update activity type (for admin users)
  Future<bool> updateActivityType(ActivityType activityType) async {
    if (activityType.id == null) {
      throw Exception('Activity type ID is required for updating');
    }

    try {
      final response = await _httpClient.put(
        '${ApiEndpoints.activityTypes}/${activityType.id}',
        data: activityType.toJson(),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update activity type: $e');
    }
  }

  // Delete activity type (for admin users)
  Future<bool> deleteActivityType(String activityTypeId) async {
    try {
      final response = await _httpClient.delete(
        '${ApiEndpoints.activityTypes}/$activityTypeId',
      );

      return response.statusCode == 204;
    } catch (e) {
      throw Exception('Failed to delete activity type: $e');
    }
  }
}
