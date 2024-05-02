import 'package:http/http.dart' as http;

class HttpClient {
  static final client = http.Client();

  HttpClient();

  // Create - POST
  static Future<http.Response> post({
    required Uri uri,
    required String body, // Now expects a JSON string
  }) async {
    return await client.post(
      uri,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
  }

  // Read - GET
  static Future<http.Response> get(Uri uri) async {
    return await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
  }

  // Update - PUT
  Future<http.Response> put({
    required Uri uri,
    required String body, // Now expects a JSON string
  }) async {
    return await client.put(
      uri,
      body: body, // No need to jsonEncode here
      headers: {'Content-Type': 'application/json'},
    );
  }

  // Delete - DELETE
  Future<http.Response> delete(Uri uri) async {
    return await client.delete(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
  }
}
