import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';  // Your main screen
import 'LogReg/Login.dart'; // Your login screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(onThemeModeChanged: (ThemeMode mode) {})),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MyLogin()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match background color with app drawer
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/onlinks_logo.png',
              width: 40, // Increased size for better visibility
            ),
            SizedBox(height: 12),
            Text(
              "OnLinks", // App name
              style: TextStyle(
                fontSize: 28, // Slightly bigger font
                fontWeight: FontWeight.bold,
                color: Colors.black, // Match app drawer style
              ),
            ),
          ],
        ),
      ),
    );
  }
}
