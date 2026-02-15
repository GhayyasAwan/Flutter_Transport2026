import 'package:flutter/material.dart';

class Toast {
  static void _show(
      BuildContext context, {
        required String message,
        required Color color,
        required IconData icon,
      }) {
    // 1. Instantly remove any existing toast so they don't stack
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 2. Show the "Sweet" styled snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating, // Makes it float
        backgroundColor: Colors.transparent, // We use our own Container for styling
        elevation: 0,
        content: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.95),
              borderRadius: BorderRadius.circular(25), // The "Sweet" round look
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Shrinks to fit text
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Generic Success method
  static void success(BuildContext context, String message) {
    _show(context,
        message: message,
        color: Colors.green.shade700,
        icon: Icons.check_circle
    );
  }

  // Generic Error method
  static void error(BuildContext context, String message) {
    _show(context,
        message: message,
        color: Colors.redAccent,
        icon: Icons.error_outline
    );
  }
}