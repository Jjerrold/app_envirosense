import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  static const String _baseUrl = 'http://10.0.2.2/EnviroSense_Backend/login.php';

  static Future<Map<String, dynamic>> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
