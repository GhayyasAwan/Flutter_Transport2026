import 'package:flutter/material.dart';

class Notify {
  // A global key or context is needed.
  // For simplicity, we pass the context, but you can also use a GlobalKey.

  static void show(
      BuildContext context, {
        required String message,
        bool isError = false,
        Duration duration = const Duration(seconds: 3),
      }) {
    final scaffold = ScaffoldMessenger.of(context);

    // Clear existing snackbars to avoid queuing
    scaffold.removeCurrentSnackBar();

    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.info_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.redAccent : Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: duration,
        margin: const EdgeInsets.all(15),
      ),
    );
  }

  // Shorthand for Error
  static void error(BuildContext context, String message) {
    show(context, message: message, isError: true);
  }

  // Shorthand for Info
  static void info(BuildContext context, String message) {
    show(context, message: message, isError: false);
  }
}