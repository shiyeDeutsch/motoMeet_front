import 'dart:convert';

import 'package:motomeetfront/services/httpClient.dart';

import '../models/userModel.dart';
import '../utilities/apiEndPoints.dart';

class AuthenticationService {
  AuthenticationService();
 

  Future<int?> register(UserInfo user) async {
    try {
      final response = await HttpClient.post(
        uri: EndPoints.register,
        body: jsonEncode(user.toJson()),
        //  headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Assuming the server returns a 200 status code on successful registration
        final userId= jsonDecode(response.body)['Id'];
        return userId;
      } else {
        // Handle different status codes or errors as needed
        print('Registration failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Log or handle the exception as needed
      print('An error occurred during registration: $e');
      return null;
    }
  }
}
