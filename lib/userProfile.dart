import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _summaryController = TextEditingController();
  final _aboutController = TextEditingController();
  final _interestsController = TextEditingController();
  final _accomplishmentsController = TextEditingController();
  File? _profilePicture;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _usernameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.updateDisplayName(_usernameController.text);
        if (_profilePicture != null) {
          user.updatePhotoURL(_profilePicture?.path ?? '');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    }
  }

  void _pickProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profilePicture = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: _profilePicture != null
                            ? FileImage(_profilePicture!)
                            : (FirebaseAuth.instance.currentUser?.photoURL != null
                            ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                            : null),
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _pickProfilePicture,
                        child: const Text('Profile Picture'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Fields Section
                ..._buildInputFields(),
                const SizedBox(height: 20),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _updateProfile,
                      child: const Text('Update Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Followed successfully')),
                        );
                      },
                      child: const Text('Follow'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputFields() {
    final fields = [
      {'label': 'Username', 'controller': _usernameController},
      {'label': 'Email', 'controller': _emailController},
      {'label': 'Age', 'controller': _ageController},
      {'label': 'Gender', 'controller': _genderController},
      {'label': 'Summary', 'controller': _summaryController},
      {'label': 'About', 'controller': _aboutController},
      {'label': 'Interests', 'controller': _interestsController},
      {'label': 'Accomplishments', 'controller': _accomplishmentsController},
    ];

    return fields
        .map((field) => Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: field['controller'] as TextEditingController,
        decoration: InputDecoration(
          labelText: field['label'] as String,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${field['label']!.toLowerCase()}';
          }
          return null;
        },
      ),
    ))
        .toList();
  }
}

extension on Object {
  toLowerCase() {}
}
