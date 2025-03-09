// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';
// import 'package:motomeetfront/models/activity.dart';
// import 'package:motomeetfront/models/event.dart';
// import 'package:motomeetfront/services/httpClient.dart';
// import 'package:motomeetfront/services/isar/isar_activity.dart';
// import 'package:motomeetfront/services/isar/repository_provider.dart';
// import 'package:motomeetfront/utilities/apiEndPoints.dart';

// class ActivityService {
//   final _repositoryProvider = GetIt.I<RepositoryProvider>();
  

//   ActivityService( );
      

//   IsarUserRecentActivityRepository get _activityRepository =>
//     _repositoryProvider.activityRepository;

//   Future<List<UserRecentActivity>> getRecentActivities({
//     int page = 1,
//     int limit = 10,
//   }) async {
//     try {
//       // Try to get from API first
//       final response = await HttpClient.get(
//         '${EndPoints.activities}?page=$page&limit=$limit',
//         headers: await _getAuthHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         final activities = data.map((json) => UserRecentActivity.fromJson(json)).toList();
        
//         // Save to local database if it's the first page
//         if (page == 1) {
//           await _saveActivitiesToLocal(activities);
//         }
        
//         return activities;
//       }
      
//       // If API fails or we're offline, get from local database
//       return await _getActivitiesFromLocal(page, limit);
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching activities: $e');
//       }
      
//       // On error, try to get from local database
//       return await _getActivitiesFromLocal(page, limit);
//     }
//   }

//   Future<List<UserRecentActivity>> _getActivitiesFromLocal(int page, int limit) async {
//     final skipCount = (page - 1) * limit;
//     final activities = await _activityRepository.getActivities(
//       skip: skipCount,
//       limit: limit,
//     );
//     return activities;
//   }

//   Future<void> _saveActivitiesToLocal(List<UserRecentActivity> activities) async {
//     await _activityRepository.saveActivities(activities);
//   }

//   Future<Map<String, String>> _getAuthHeaders() async {
//     // Implementation depends on your auth service
//     return {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer yourAuthTokenHere'
//     };
//   }

//   // Get all activity types
//   Future<List<UserRecentActivity>> getActivityTypes() async {
//     try {
//       final response = await HttpClient.get(
//         ApiEndpoints.activityTypes,
//        // headers: await _getAuthHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return (data as List)
//             .map((activityJson) => UserRecentActivity.fromJson(activityJson))
//             .toList();
//       } else {
//         // Handle different status codes or errors as needed
//         if (kDebugMode) {
//           print('Failed to load activity types with status code: ${response.statusCode}');
//         }
//         return [];
//       }
//     } catch (e) {
//       throw Exception('Failed to load activity types: $e');
//     }
//   }

//   // Get activity type by ID
//   Future<UserRecentActivity> getActivityTypeById(String activityTypeId) async {
//     try {
//       final response = await HttpClient.get(
//         Uri(
//           scheme: ApiEndpoints.activityType.scheme,
//           host: ApiEndpoints.activityType.host,
//           port: ApiEndpoints.activityType.port,
//           path: '${ApiEndpoints.activityType.path}/$activityTypeId',
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return UserRecentActivity.fromJson(data);
//       } else {
//         // Handle different status codes or errors as needed
//         if (kDebugMode) {
//           print('Failed to get activity type with status code: ${response.statusCode}');
//         }
//         throw Exception('Failed to load activity type');
//       }
//     } catch (e) {
//       throw Exception('Failed to load activity type: $e');
//     }
//   }

//   // Get popular activity types
//   Future<List<UserRecentActivity>> getPopularActivityTypes({int limit = 5}) async {
//     try {
//       final response = await HttpClient.get(
//         Uri(
//           scheme: ApiEndpoints.activityTypes.scheme,
//           host: ApiEndpoints.activityTypes.host,
//           port: ApiEndpoints.activityTypes.port,
//           path: '${ApiEndpoints.activityTypes.path}/popular',
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return (data as List)
//             .map((activityJson) => ActivityType.fromJson(activityJson))
//             .toList();
//       } else {
//         // Handle different status codes or errors as needed
//         if (kDebugMode) {
//           print('Failed to load popular activity types with status code: ${response.statusCode}');
//         }
//         return [];
//       }
//     } catch (e) {
//       throw Exception('Failed to load popular activity types: $e');
//     }
//   }

//   // Create a custom activity type (for admin users)
//   Future<bool> createActivityType(ActivityType activityType) async {
//     try {
//       final response = await HttpClient.post(
//         uri: ApiEndpoints.activityTypes,
//         body: jsonEncode(activityType.toJson()),
//       );

//       if (response.statusCode == 201) {
//         return true;
//       } else {
//         // Handle different status codes or errors as needed
//         if (kDebugMode) {
//           print('Failed to create activity type with status code: ${response.statusCode}');
//         }
//         return false;
//       }
//     } catch (e) {
//       throw Exception('Failed to create activity type: $e');
//     }
//   }

//   // Update activity type (for admin users)
//   Future<bool> updateActivityType(UserRecentActivity activityType) async {
//     if (activityType.id == null) {
//       throw Exception('Activity type ID is required for updating');
//     }

//     try {
//       final response = await HttpClient.post(
//         uri: Uri(
//           scheme: ApiEndpoints.activityTypes.scheme,
//           host: ApiEndpoints.activityTypes.host,
//           port: ApiEndpoints.activityTypes.port,
//           path: '${ApiEndpoints.activityTypes.path}/${activityType.id}',
//         ),
//         body: jsonEncode(activityType.toJson()),
//       );

//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         // Handle different status codes or errors as needed
//         if (kDebugMode) {
//           print('Failed to update activity type with status code: ${response.statusCode}');
//         }
//         return false;
//       }
//     } catch (e) {
//       throw Exception('Failed to update activity type: $e');
//     }
//   }

//   // Delete activity type (for admin users)
//   Future<bool> deleteActivityType(String activityTypeId) async {
//     try {
//       final response = await HttpClient.get(
//         Uri(
//           scheme: ApiEndpoints.activityTypes.scheme,
//           host: ApiEndpoints.activityTypes.host,
//           port: ApiEndpoints.activityTypes.port,
//           path: '${ApiEndpoints.activityTypes.path}/$activityTypeId',
//         ),
//       );

//       if (response.statusCode == 204) {
//         return true;
//       } else {
//         // Handle different status codes or errors as needed
//         if (kDebugMode) {
//           print('Failed to delete activity type with status code: ${response.statusCode}');
//         }
//         return false;
//       }
//     } catch (e) {
//       throw Exception('Failed to delete activity type: $e');
//     }
//   }
// }
