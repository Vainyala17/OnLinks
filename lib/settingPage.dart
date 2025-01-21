import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';
  bool linkExpiryNotifications = true;
  bool prioritySortingAlerts = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  // Load saved preferences
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
      linkExpiryNotifications = prefs.getBool('linkExpiryNotifications') ?? true;
      prioritySortingAlerts = prefs.getBool('prioritySortingAlerts') ?? true;
    });
  }

  // Save preferences
  Future<void> saveSettings(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) prefs.setBool(key, value);
    if (value is String) prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Display Settings
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                  saveSettings('isDarkMode', value);
                });
              },
            ),
          ),
          ListTile(
            title: Text('Font Size'),
            subtitle: Text('Small, Medium, Large (Not implemented yet)'),
            onTap: () {
              // Implement Font Size Picker
            },
          ),
          // Language Settings
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: ['English', 'Marathi', 'Hindi']
                  .map((lang) => DropdownMenuItem(
                child: Text(lang),
                value: lang,
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                  saveSettings('selectedLanguage', value);
                });
              },
            ),
          ),
          // Notification Settings
          ListTile(
            title: Text('Link Expiry Notifications'),
            trailing: Switch(
              value: linkExpiryNotifications,
              onChanged: (value) {
                setState(() {
                  linkExpiryNotifications = value;
                  saveSettings('linkExpiryNotifications', value);
                });
              },
            ),
          ),
          ListTile(
            title: Text('Priority Sorting Alerts'),
            trailing: Switch(
              value: prioritySortingAlerts,
              onChanged: (value) {
                setState(() {
                  prioritySortingAlerts = value;
                  saveSettings('prioritySortingAlerts', value);
                });
              },
            ),
          ),
          // Help & Support
          ListTile(
            title: Text('FAQ'),
            onTap: () {
              // Navigate to FAQ page
            },
          ),
          ListTile(
            title: Text('Report a Bug'),
            onTap: () {
              // Navigate to Report Bug page
            },
          ),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              // Navigate to Contact Us page
            },
          ),
          // General Settings
          ListTile(
            title: Text('Reset to Default'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              loadSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings reset to default.')));
            },
          ),
          ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
