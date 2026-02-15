import 'package:flutter/material.dart';

class GlobalIconButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const GlobalIconButton({
    Key? key,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
    this.color = const Color(0xFF007BFF), // Bootstrap Primary Blue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12), // Keeps the ripple effect rounded
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wraps content tightly
          children: [
            // The Icon
            Icon(
              icon,
              size: 32, // Larger icon for vertical layout
              color: color,
            ),
            const SizedBox(height: 8), // Gap between icon and text
            // The Text
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}