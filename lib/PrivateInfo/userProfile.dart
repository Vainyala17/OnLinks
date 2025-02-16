import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/PrivateInfo/privacy_policy.dart';
import 'package:flutter_project/PrivateInfo/settingPage.dart';
import 'package:image_picker/image_picker.dart';

import 'EditProfilePage.dart';
// Import your Settings Page here

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _profilePicture;
  final user = FirebaseAuth.instance.currentUser;

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profilePicture != null
                    ? FileImage(_profilePicture!)
                    : (user?.photoURL != null ? NetworkImage(user!.photoURL!) : null),
              ),
              const SizedBox(height: 10),
              Text(
                user?.displayName ?? "User Name",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "@${user?.email?.split('@')[0] ?? 'username'}",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  _navigateToPage(const EditProfilePage());
                },
                child: const Text("Edit"),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white),
              _buildMenuItem(Icons.settings, "Setting", const SettingsPage()), // Navigate to Settings
              _buildMenuItem(Icons.lock, "Privacy Policy", PrivacyPolicyPage()),
              _buildMenuItem(Icons.group, "New Group", PlaceholderPage("New Group Page")),
              _buildMenuItem(Icons.support, "Support", PlaceholderPage("Support Page")),
              _buildMenuItem(Icons.share, "Share", PlaceholderPage("Share Page")),
              _buildMenuItem(Icons.info, "About Us", PlaceholderPage("About Us Page")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
      onTap: () {
        _navigateToPage(page);
      },
    );
  }
}

// Placeholder page for navigation (Replace with actual pages)
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
    );
  }
}
