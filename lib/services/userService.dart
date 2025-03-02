import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/geoLocationInfo.dart';
import 'package:motomeetfront/models/newRoute.dart';
import 'package:motomeetfront/services/httpClient.dart';
import 'package:motomeetfront/services/loctionService.dart';
import 'package:motomeetfront/services/isar/isar_geo_location.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';

import '../models/userModel.dart';
import '../utilities/apiEndPoints.dart';

class UserService {
  Future<UserInfo?> fetchUserProfile(String token) async {
    try {
      final response = await HttpClient.get(
        ApiEndpoints.userProfile, // Replace with your actual endpoint
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserInfo.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Failed to fetch user profile: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while fetching user profile: $e');
      }
      return null;
    }
  }

  Future<GeoLocationInfo?> sendGeoLocation() async {
    try {
      var location = await LocationService.getCurrentLocation();
      final payload = {
        'latitude': location?.latitude,
        'longitude': location?.longitude,
      };

      final response = await HttpClient.post(
        uri: ApiEndpoints.geoLocation,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final geoLocationInfo = GeoLocationInfo.fromJson(data);
        
        // Store the geo location info to the local database
        final repositoryProvider = GetIt.I<RepositoryProvider>();
        final geoLocationRepository = repositoryProvider.geoLocationRepository;
        await geoLocationRepository.add(geoLocationInfo);
        
        return geoLocationInfo;
      } else {
        if (kDebugMode) {
          print('Failed to send geo location: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while sending geo location: $e');
      }
      return null;
    }
  }
}
