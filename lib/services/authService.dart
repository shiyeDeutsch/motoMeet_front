import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:motomeetfront/services/httpClient.dart';

import '../models/userModel.dart';
import '../utilities/apiEndPoints.dart';

class AuthenticationService {
  AuthenticationService();

  Future<UserInfo?> register(UserInfo user) async {
    try {
      print(user.toJson());
      final response = await HttpClient.post(
        uri: EndPoints.register,
        body: jsonEncode(user.toJson()),
        //  headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Assuming the server returns a 200 status code on successful registration
        final data = jsonDecode(response.body);
        final user = UserInfo.fromJson(data['user']);
        //  final token = data['token'] as String?;

        if (user != null) {
          return user;
        }
      } else {
        // Handle different status codes or errors as needed
        if (kDebugMode) {
          print('Registration failed with status code: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      // Log or handle the exception as needed
      if (kDebugMode) {
        print('An error occurred during registration: $e');
      }
      return null;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await HttpClient.post(
     uri: EndPoints.login,
        body: jsonEncode({'Email': email, 'Password': password}),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] as String?;
        return token; // Return only the token
      } else {
        if (kDebugMode) {
          print('Login failed with status code: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred during login: $e');
      }
      return null;
    }
  }
}
