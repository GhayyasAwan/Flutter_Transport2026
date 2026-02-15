import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userKey = "logged_in_user_id";
  static const String _userNameKey = "logged_in_user_Name";

  // Save User ID
  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userKey, id);
  }

  // Get User ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userKey);
  }
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  // Get User ID
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Logout (Remove User ID)
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_userNameKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final id = await getUserId();
    return id != null;
  }
}