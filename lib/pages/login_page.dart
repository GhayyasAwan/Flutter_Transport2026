import 'package:flutter/material.dart';
import 'package:my_pos/helper_classes/toast.dart';

import '../controllers/auth_controller.dart';
import '../core/api_manager.dart';
import '../core/storage_service.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
// Inside your _LoginScreenState
  void _handleLogin() async {
    String user = _usernameController.text.trim();
    String pass = _passwordController.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      Toast.error(context, "Please fill all fields");
      return;
    }

    final response = await ApiManager.call(
      context,
      loadingMessage: "Verifying Credentials...",
      request: () => AuthController.login(user, pass),
    );


    if (response!=null && response["Success"] == true) {
      // API returned Ok()
      int userId = response["User"]["Id"];
      // 2. Save it to disk
      await StorageService.saveUserId(userId);
      Toast.success(context, response["Message"]);
      //Toast.success(context, "Welcome Back, Admin!");
      // Navigate to Dashboard
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  MyHomePage(title: 'Transport App')));
      // You can access User data like this:
      // var userId = response["User"]["Id"];

     // Navigator.pushReplacementNamed(context, '/home');
    } else {
      // API returned APIError (BadRequest)
      Toast.error(context, response!["Message"]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              // Your Hero Image
              Image.asset('assets/images/hero.png', height: 180),
              const SizedBox(height: 20),
              const Text(
                "Transport App",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const Text("Login to your account", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),

              // Username Field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  labelText: "Username",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                  labelText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),

              const SizedBox(height: 100),
              // Developer Logo at bottom
              const Text('Developed By', style: TextStyle(color: Colors.black38)),
              Image.asset('assets/images/agelogo.png', height: 40),
            ],
          ),
        ),
      ),
    );
  }
}