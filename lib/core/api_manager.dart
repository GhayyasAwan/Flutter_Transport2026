import 'package:flutter/material.dart';

import '../widgets/busy.dart';


class ApiManager {
  /// Calls any Future and shows a loading spinner automatically
  static Future<T?> call<T>(
      BuildContext context, {
        required Future<T> Function() request,
        String loadingMessage = "Processing...",
      }) async {
    try {
      Busy.show(context, message: loadingMessage);
      final result = await request();
      return result;
    } catch (e) {
      debugPrint("API Manager Error: $e");
      return null;
    } finally {
      Busy.hide(context);
    }
  }
}