import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/PrivateInfo/FAQPage.dart';
import 'package:flutter_project/PrivateInfo/settingPage.dart';
import 'package:image_picker/image_picker.dart';
import 'EditProfilePage.dart';
import 'package:flutter_project/LogReg/Login.dart';  // Adjust the path based on your project structure
import 'ChangePasswordPage.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _profilePicture;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);

    try {
      final ref = FirebaseStorage.instance.ref().child("profile_pics/${user!.uid}.jpg");
      await ref.putFile(imageFile);
      String downloadUrl = await ref.getDownloadURL();

      await user?.updatePhotoURL(downloadUrl);
      await FirebaseAuth.instance.currentUser?.reload();

      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: $e")),
      );
    }
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog (No action)
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                // Logout from Firebase
                await FirebaseAuth.instance.signOut();

                // Close dialog
                Navigator.pop(context);

                // Navigate to Login Page & Remove all previous pages
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyLogin()),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Profile Setting", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: _profilePicture != null
                      ? FileImage(_profilePicture!)
                      : (user?.photoURL != null ? NetworkImage(user!.photoURL!) : const AssetImage("assets/default_profile.png")) as ImageProvider,
                  child: GestureDetector(
                    onTap: pickAndUploadImage,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, size: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.displayName ?? "User Name", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(user?.email ?? "user@example.com", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildMenuItem(Icons.person, "Edit Profile", page: const EditProfilePage()),
            _buildMenuItem(Icons.lock, "Change Password", page: const ChangePasswordPage()),
            _buildMenuItem(Icons.settings, "Settings", page: const SettingsPage()),
            _buildMenuItem(Icons.help, "FAQ", page: const FAQPage()),


            const SizedBox(height: 20),
            _buildSectionTitle("Preferences"),
            _buildToggleMenuItem(Icons.notifications, "Notification"),
            _buildMenuItem(Icons.logout, "Log Out", onTap: () {
              _showLogoutDialog(context);
            }),
          ],
        ),
      ),
    );
  }
  Widget _buildMenuItem(IconData icon, String text, {VoidCallback? onTap, Widget? page}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text, style: const TextStyle(fontSize: 16)),
        onTap: () {
          if (onTap != null) {
            onTap(); // Execute function if provided (e.g., logout)
          } else if (page != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page)); // Navigate if page is provided
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildToggleMenuItem(IconData icon, String text) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text, style: const TextStyle(fontSize: 16)),
        trailing: Switch(value: true, onChanged: (bool value) {}),
      ),
    );
  }
}

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
