import 'dart:convert';
import 'package:flutter/services.dart';

class AssetLoader {
static  Future<List<dynamic>?> loadCountryData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/images/country.json');
      final jsonData = jsonDecode(jsonString);
      print(jsonData);
      return jsonData;
    } catch (e) {
      print('Failed to load country data: $e');
    }
    return null;
  }
}
