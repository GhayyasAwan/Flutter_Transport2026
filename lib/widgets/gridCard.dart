import 'package:flutter/material.dart';

class ActionGridCard extends StatefulWidget {
  final List<Widget> children;
  final double height;

  const ActionGridCard({
    Key? key,
    required this.children,
    this.height = 240, // Default height to fit 3 rows
  }) : super(key: key);

  @override
  _ActionGridCardState createState() => _ActionGridCardState();
}

class _ActionGridCardState extends State<ActionGridCard> {
  @override
  Widget build(BuildContext context) {
    // Logic to split buttons into pages of 9 (3x3)
    List<List<Widget>> pages = [];
    for (var i = 0; i < widget.children.length; i += 6) {
      pages.add(
        widget.children.sublist(
          i,
          i + 6 > widget.children.length ? widget.children.length : i + 6,
        ),
      );
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: widget.height,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildGrid(pages[index]);
                },
              ),
            ),
            // Page Indicator (Dots)
            if (pages.length > 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 8,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<Widget> buttons) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Important: Prevents conflict with PageView
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Max 3 columns
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1, // Keep buttons square
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) => buttons[index],
      ),
    );
  }
}