import 'package:flutter/material.dart';

class Busy {
  static bool _isShowing = false;

  static void show(BuildContext context, {String message = "Please wait..."}) {
    if (_isShowing) return;
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false, // User cannot click away
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Prevents back button from closing it
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Colors.indigo),
                  const SizedBox(height: 15),
                  Text(message, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      _isShowing = false;
    }
  }
}