import 'package:flutter/material.dart';
import 'package:my_pos/core/api_routes.dart';
import '../core/api_service.dart';
import '../core/storage_service.dart';
import '../pages/login_page.dart';

class AuthController {

  // 1. Centralized Login API Call
  static Future<Map<String, dynamic>> login(String username, String password) async {
    // Matches your C# LoginRequest object
    Map<String, dynamic> loginData = {
      "Username": username,
      "Password": password,
    };

    return await ApiService.post(ApiRoutes.login, loginData);
  }

  // 2. Centralized Logout Method
  // We pass 'context' here so we can navigate and check 'mounted'
  static Future<void> logout(BuildContext context) async {
    // 1. Remove user from SharedPreferences
    await StorageService.removeUser();

    // 2. Check if the screen is still active (context.mounted)
    if (context.mounted) {
      // 3. Clear the whole screen stack and go to Login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
            (route) => false, // This prevents users from clicking "Back" to enter the app again
      );
    }
  }
}