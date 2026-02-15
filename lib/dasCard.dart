import 'package:flutter/material.dart'; // Use Material for better Card/Shadow support

class DashCard extends StatefulWidget {
  final String title;
  final String value;

  // Best practice: Use camelCase for variables and key for constructors
  const DashCard({Key? key, required this.title, required this.value})
    : super(key: key);

  @override
  State<DashCard> createState() => _DashCardState();
}

class _DashCardState extends State<DashCard> {
  @override
  Widget build(BuildContext context) {
    // Calculate 40% of screen width
    double cardWidth = MediaQuery.of(context).size.width * 0.40;

    return Container(
      width: cardWidth,
      height: 100, // Adjusted height for two rows
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDEE2E6), width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Pushes row 1 to top, row 2 to bottom
        children: [
          // Row 1: Title (Top Left)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6C757D), // Bootstrap Secondary Gray
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Row 2: Value (Bottom Right)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 12),
              child: Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212529), // Bootstrap Dark
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
