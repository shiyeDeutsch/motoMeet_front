import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/activity.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/isar/isar_activity.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';
import 'package:motomeetfront/utilities/apiEndPoints.dart';

class ActivityService {
  final _repositoryProvider = GetIt.I<RepositoryProvider>();
  
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
}
