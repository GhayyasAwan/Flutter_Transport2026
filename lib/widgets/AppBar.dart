import 'package:flutter/material.dart';
import 'package:my_pos/core/storage_service.dart'; // Adjust based on your path
import 'package:my_pos/controllers/auth_controller.dart';
import 'package:my_pos/helper_classes/toast.dart';

class ShimmerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const ShimmerAppBar({Key? key, required this.title}) : super(key: key);

  @override
  _ShimmerAppBarState createState() => _ShimmerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ShimmerAppBarState extends State<ShimmerAppBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _userName = "User"; // Default value

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  // Fetch username from StorageService
  void _loadUserInfo() async {
    // Note: You'll need a getUserName() in your StorageService
    // For now, let's assume it's there or use a placeholder
    final name = await StorageService.getUserName();
    if (mounted) {
      setState(() {
        _userName = name ?? "Admin";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            double slideValue = _controller.value * 5;
            double alignmentValue = -1.0 + (slideValue * 3);
            if (alignmentValue > 2.0) alignmentValue = 2.0;

            return LinearGradient(
              begin: Alignment(alignmentValue - 0.4, 0),
              end: Alignment(alignmentValue, 0),
              colors: [
                Colors.white.withOpacity(0.0),
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcOver,
          child: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.indigo, // Matching your POS theme
            elevation: 4,
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.account_circle, size: 30),
                onSelected: (value) {
                  if (value == 'change_password') {
                    Toast.success(context, "Done");
                  } else if (value == 'logout') {
                    AuthController.logout(context);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  // 1. Display Username (Non-clickable header)
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.indigo),
                        const SizedBox(width: 10),
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  // 2. Change Password
                  const PopupMenuItem<String>(
                    value: 'change_password',
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline, size: 20),
                        SizedBox(width: 10),
                        Text("Change Password"),
                      ],
                    ),
                  ),
                  // 3. Logout
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.redAccent, size: 20),
                        SizedBox(width: 10),
                        Text("Logout", style: TextStyle(color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }
}