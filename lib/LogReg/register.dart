import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _message = '';
  bool _obscurePassword = true; // State for password visibility
  bool _obscureConfirmPassword = true; // State for confirm password visibility

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request notification permission
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Email validation before Firebase call
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
    if (!emailRegex.hasMatch(email)) {
      _showMessageDialog('Error', 'Enter a valid email address.');
      return;
    }

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessageDialog('Error', 'Please fill in all fields');
      return;
    }

    if (password != confirmPassword) {
      _showMessageDialog('Error', 'Passwords do not match');
      return;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': 'Unnamed',
          'email': email,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      _sendWelcomeNotification();

      _showMessageDialog('Success', 'Registration successful!', () {
        Navigator.pushNamed(context, 'home');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showMessageDialog(
            'Error', 'Email is already registered. Try logging in.');
      } else {
        _showMessageDialog('Error', 'Registration failed: ${e.message}');
      }
    }
  }

  void _sendWelcomeNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'welcome_channel_id',
      'Welcome Notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Welcome to On-Links!',
      'Thank you for joining. Start exploring now!',
      platformChannelSpecifics,
    );
  }
  void _showMessageDialog(String title, String message, [VoidCallback? onOkPressed]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) onOkPressed();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _scrollToField() {
    Future.delayed(Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 0),
              child: Text(
                'Create your account \nhere....',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.30,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      onTap: _scrollToField,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      onTap: _scrollToField,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        ),
                      ),
                      onTap: _scrollToField,
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 11),
                          backgroundColor: Color(0xFF2196F3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 8),
                            Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Add space for the message
                    Text(
                      _message,
                      style: TextStyle(color: Colors.red, fontSize: 16), // Display messages
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff4c505b),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Already have an account ? \n ',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}