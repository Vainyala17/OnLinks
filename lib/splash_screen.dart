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
      // Check if user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is logged in, go to HomePage
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(onThemeModeChanged: (ThemeMode mode) {  },)));
      } else {
        // No user logged in, go to LoginPage
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyLogin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon/onlinks_logo.png', width: 100), // Adjust size
            SizedBox(height: 20),
            Text(
              "On-Links",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
