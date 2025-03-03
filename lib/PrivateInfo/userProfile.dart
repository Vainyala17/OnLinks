import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'EditProfilePage.dart';
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
            _buildSectionTitle("General"),
            _buildMenuItem(Icons.person, "Edit Profile", const EditProfilePage()),
            _buildMenuItem(Icons.lock, "Change Password", const ChangePasswordPage()),
            _buildMenuItem(Icons.info, "Terms of Use", PlaceholderPage("Terms of Use")),
            _buildMenuItem(Icons.credit_card, "Add Card", PlaceholderPage("Add Card")),

            const SizedBox(height: 20),
            _buildSectionTitle("Preferences"),
            _buildToggleMenuItem(Icons.notifications, "Notification"),
            _buildMenuItem(Icons.help, "FAQ", PlaceholderPage("FAQ")),
            _buildMenuItem(Icons.logout, "Log Out", PlaceholderPage("Log Out")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Balance"),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, Widget page) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text, style: const TextStyle(fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      ),
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
