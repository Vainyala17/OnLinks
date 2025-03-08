<<<<<<< HEAD
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For Date Formatting

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController(); // Replaces Nickname
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController(); // Date of Birth
  File? _profilePicture;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    if (user != null) {
      // Fetch extra user details from Firestore
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(user!.uid).get();

      setState(() {
        _nameController.text = user?.displayName ?? '';
        _usernameController.text = userDoc['username'] ?? '';
        _emailController.text = user?.email ?? '';
        _phoneController.text = userDoc['phone'] ?? '';
        _dobController.text = userDoc['dob'] ?? '';
      });
    }
  }

  void _pickProfilePicture() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800), // Allowing old dates like 1892
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void _saveProfile() async {
    if (user != null) {
      await user?.updateDisplayName(_nameController.text);
      await _firestore.collection('users').doc(user!.uid).set({
        'username': _usernameController.text,
        'phone': _phoneController.text,
        'dob': _dobController.text,
      }, SetOptions(merge: true)); // Merge updates without overwriting all fields

      await user?.reload(); // Ensure data is updated

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePicture != null
                      ? FileImage(_profilePicture!)
                      : (user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.blue),
                  onPressed: _pickProfilePicture,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField("Name", _nameController),
            _buildTextField("Username", _usernameController),
            _buildTextField("Email", _emailController, enabled: false),
            _buildTextField("Phone Number", _phoneController),
            _buildTextField("Date of Birth", _dobController, onTap: _pickDate),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = true, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        readOnly: onTap != null, // Make date field read-only
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: onTap != null ? const Icon(Icons.calendar_today) : null,
        ),
      ),
    );
  }
}
=======
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For Date Formatting

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController(); // Replaces Nickname
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController(); // Date of Birth
  File? _profilePicture;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    if (user != null) {
      // Fetch extra user details from Firestore
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(user!.uid).get();

      setState(() {
        _nameController.text = user?.displayName ?? '';
        _usernameController.text = userDoc['username'] ?? '';
        _emailController.text = user?.email ?? '';
        _phoneController.text = userDoc['phone'] ?? '';
        _dobController.text = userDoc['dob'] ?? '';
      });
    }
  }

  void _pickProfilePicture() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800), // Allowing old dates like 1892
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void _saveProfile() async {
    if (user != null) {
      await user?.updateDisplayName(_nameController.text);
      await _firestore.collection('users').doc(user!.uid).set({
        'username': _usernameController.text,
        'phone': _phoneController.text,
        'dob': _dobController.text,
      }, SetOptions(merge: true)); // Merge updates without overwriting all fields

      await user?.reload(); // Ensure data is updated

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePicture != null
                      ? FileImage(_profilePicture!)
                      : (user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.blue),
                  onPressed: _pickProfilePicture,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField("Name", _nameController),
            _buildTextField("Username", _usernameController),
            _buildTextField("Email", _emailController, enabled: false),
            _buildTextField("Phone Number", _phoneController),
            _buildTextField("Date of Birth", _dobController, onTap: _pickDate),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = true, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        readOnly: onTap != null, // Make date field read-only
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: onTap != null ? const Icon(Icons.calendar_today) : null,
        ),
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
