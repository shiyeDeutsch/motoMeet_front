import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';

class HttpClient {
  static final client = http.Client();
  static final getIt = GetIt.instance;

  HttpClient();

  // Add method to get auth token
  static String? _getAuthToken() {
    try {
      final repositoryProvider = getIt<RepositoryProvider>();
      final userInfo = repositoryProvider.userInfoRepository.getCurrentUser();
      return userInfo?.token;
    } catch (e) {
      print('Error getting auth token: $e');
      return null;
    }
  }

  // Create - POST
  static Future<http.Response> post({
    Map<String, String>? headers,
    required Uri uri,
    required String body, // Now expects a JSON string
  }) async {
    final String? token = _getAuthToken();
    return await client.post(
      uri,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );
  }

  // Read - GET
  static Future<http.Response> get(Uri uri, {Map<String, String>? headers}) {
    final String? token = _getAuthToken();
    return client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );
  }

  // Update - PUT
  Future<http.Response> put({
    required Uri uri,
    required String body,
    Map<String, String>? headers,
  }) async {
    final String? token = _getAuthToken();
    return await client.put(
      uri,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );
  }

  // Delete - DELETE
  Future<http.Response> delete(Uri uri, {Map<String, String>? headers}) async {
    final String? token = _getAuthToken();
    return await client.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );
  }
}
