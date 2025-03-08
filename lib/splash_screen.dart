import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'LogReg/Login.dart';

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
      backgroundColor: Colors.white,
      body: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/icon/onlinks_logo.png',
            //   width: 50, // Adjust for proper size
            //   height: 50,
            //   fit: BoxFit.contain,
            // ),
            //SizedBox(height: 10),
            Container(
              // width: 200,
              // height: 50,
              // color: Colors.red, // Visible background
              child: Center(
                child: Text(
                  "OnLinks",
                  style: TextStyle(fontSize: 50,  // Make it large
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Change color for contrast
                    backgroundColor: Colors.yellow,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
