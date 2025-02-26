import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:motomeetfront/models/geoLocationInfo.dart';
import 'package:motomeetfront/models/newRoute.dart';
import 'package:motomeetfront/services/httpClient.dart';

import '../models/userModel.dart';
import '../utilities/apiEndPoints.dart';

class UserServce
{
    Future<UserInfo?> fetchUserProfile(String token) async {
    try {
      final response = await HttpClient.get(
           EndPoints.userProfile , // Replace with your actual endpoint
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
  
  Future<GeoLocationInfo?> sendGeoLocation(String token, GeoPoint geoPoint) async {
    try {
      final payload = {
        'latitude': geoPoint.latitude,
        'longitude': geoPoint.longitude,
        'altitude': geoPoint.altitude
      };
      
      final response = await HttpClient.post(
        uri: EndPoints.geoLocation,
        body: jsonEncode(payload),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GeoLocationInfo.fromJson(data);
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