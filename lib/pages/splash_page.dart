
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pos/pages/login_page.dart';

import 'home_page.dart';

class SplahScreen extends StatefulWidget
{
  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), ()
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
    });
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold
      (
      body: Container(
        color: Colors.white,
        width: double.infinity, // Ensure it takes full width
        child: Column(
          children: [
            // 1. This pushes the hero image to the center
            const Spacer(),

            // 2. Main Image (Exactly in the center)
            const Image(
              image: AssetImage('assets/images/hero.png'),
              height: 200,
              width: 200,
            ),

            // 3. This pushes the bottom content away from the center
            const Spacer(),

            // 4. Bottom Content
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Padding from bottom edge
              child: Column(
                children: [
                  const Text(
                    'Developed By',
                    style: TextStyle(color: Colors.black38),
                  ),
                  const SizedBox(height: 10),
                  Image(
                    image: const AssetImage('assets/images/agelogo.png'),
                    height: 50, // Usually logos at bottom are smaller
                    width: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  }