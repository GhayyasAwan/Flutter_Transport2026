import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final String initialValue;
  final Color accentColor;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.initialValue,
    this.accentColor = Colors.blue,
  }) : super(key: key);

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  // Method to update value if needed
  void updateValue(String newValue) {
    setState(() {
      _currentValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: cardWidth, // Fixed width for dashboard grid look
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border(
            left: BorderSide(color: widget.accentColor, width: 5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                _currentValue,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}