import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _profileImage;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  String? selectedBirthDate;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    loadProfileData(); // Load saved data when screen opens
  }
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path);
    }
  }

  // 🔹 Save Image Path to SharedPreferences
  Future<void> _saveProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', imagePath);
  }

  // 🔹 Load Saved Profile Image
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }
  void loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstNameController.text = prefs.getString('firstName') ?? "";
      lastNameController.text = prefs.getString('lastName') ?? "";
      usernameController.text = prefs.getString('username') ?? "";
      emailController.text = prefs.getString('email') ?? "";
      phoneController.text = prefs.getString('phone') ?? "";
      birthDateController.text = prefs.getString('birthDate') ?? "";
    });
  }
  void saveProfileData() async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        birthDateController.text.isEmpty) {

      // 🔹 Show Dialog: "Please fill all details"
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Incomplete Details"),
            content: Text("Please fill in all the details before saving."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return; // Stop execution if fields are empty
    }

    // 🔹 Save Data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('username', usernameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('birthDate', birthDateController.text);

    // 🔹 Show Success Dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Profile data has been saved!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: 20),

        // 🔹 Profile Image with Edit Icon
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) // Show saved image
                    : AssetImage("assets/default_profile.png") as ImageProvider, // Default image
                ),
                GestureDetector(
                  onTap: _pickImage, // Pick image on click
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Input Fields
            buildTextField("First Name", firstNameController),
            buildTextField("Last Name", lastNameController),
            buildTextField("Username", usernameController),
            buildTextField("Email", emailController, enabled: true),
            buildTextField("Phone Number", phoneController, inputType: TextInputType.phone),
            buildDatePickerField("Birth Date", birthDateController),
            // Gender Dropdown
            buildDropdownField("Gender", ["Male", "Female", "Other"], (value) {
              setState(() => selectedGender = value);
            }, selectedGender),

            SizedBox(height: 20),

            // Change Password Button
            ElevatedButton.icon(
              onPressed: saveProfileData, // ✅ Save data & show dialog
              icon: Icon(Icons.save),
              label: Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text Field Widget
  Widget buildTextField(String label, TextEditingController controller, {bool enabled = true, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: inputType,  // 👈 Set the keyboard type
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }


  // Dropdown Field Widget
  Widget buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: true, // 👈 Prevents manual input
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900), // Earliest selectable date
            lastDate: DateTime.now(), // Latest selectable date (today)
          );

          if (pickedDate != null) {
            String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            setState(() {
              controller.text = formattedDate; // Updates the TextField with selected date
            });
          }
        },
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today), // Calendar icon
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
  // Dropdown Field Widget
  Widget buildDropdownField(String label, List<String> items, Function(String?) onChanged, String? selectedValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
  }
