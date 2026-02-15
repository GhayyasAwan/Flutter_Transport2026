import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Centralized POST method
  static Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final decodedResponse = jsonDecode(response.body);

      // Even if the status is 400 (BadRequest), your API returns a JSON body
      // with Success = false and a Message. We return that to the UI.
      return decodedResponse;
    } catch (e) {
      // Handles network crashes, timeouts, or no internet
      return {
        "Success": false,
        "Message": "Network Error: Please check your connection."
      };
    }
  }

  static Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } catch (e) {
      return [];
    }
  }
  // PUT: To update existing records
  // PUT: Update existing records
  static Future<Map<String, dynamic>> put(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } catch (e) {
      return {
        "Success": false,
        "Message": "Update Error: Connection to Xeon server failed."
      };
    }
  }

  // DELETE: Remove or Deactivate records
  static Future<Map<String, dynamic>> delete(String url) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      final decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } catch (e) {
      return {
        "Success": false,
        "Message": "Delete Error: Could not reach the server."
      };
    }
  }
}