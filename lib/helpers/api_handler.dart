import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseURL = 'https://www.themealdb.com/api/json/v1/1';

Future<dynamic> getRequest(String endpoint) async {
  try {
    final response = await http.get(Uri.parse('$baseURL/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in getRequest: $e');
    throw Exception('Failed to make the request');
  }
}
