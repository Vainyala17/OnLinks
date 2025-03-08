<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  double fontSize = 16.0;
  String selectedLanguage = 'English';
  bool linkExpiryNotifications = true;
  bool prioritySortingAlerts = true;
  String themeMode = 'System Default';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      fontSize = prefs.getDouble('fontSize') ?? 16.0;
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
      linkExpiryNotifications = prefs.getBool('linkExpiryNotifications') ?? true;
      prioritySortingAlerts = prefs.getBool('prioritySortingAlerts') ?? true;
      themeMode = prefs.getString('themeMode') ?? 'System Default';
    });
  }

  Future<void> saveSettings(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) prefs.setBool(key, value);
    if (value is double) prefs.setDouble(key, value);
    if (value is String) prefs.setString(key, value);
  }

  void reportBug() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
      queryParameters: {'subject': 'Bug Report', 'body': 'Describe the issue...'},
    );
    launchUrl(emailUri);
  }

  void openFAQs() async {
    final Uri faqUri = Uri.parse("https://yourfaqpage.com");
    launchUrl(faqUri, mode: LaunchMode.externalApplication);
  }

  void contactUs() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '1234567890');
    launchUrl(phoneUri);
  }

  void showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(Icons.brightness_6, size: 40),
              SizedBox(height: 8),
              Text("Choose Theme", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Light', 'Dark', 'System Default'].map((theme) {
              return RadioListTile<String>(
                title: Text(theme),
                value: theme,
                groupValue: themeMode,
                onChanged: (value) {
                  setState(() {
                    themeMode = value!;
                    saveSettings('themeMode', value);
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.link),
            title: Text('On-Links Settings'),
          ),

          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text("Theme"),
            subtitle: Text(themeMode),
            onTap: showThemeDialog,
          ),

          ListTile(
            title: const Text('Font Size'),
            subtitle: Slider(
              value: fontSize,
              min: 12,
              max: 24,
              divisions: 6,
              label: fontSize.toString(),
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                  saveSettings('fontSize', value);
                });
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.language, color: Colors.green),
            title: const Text("Language"),
            subtitle: Text(selectedLanguage),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView(
                    children: ["English", "Marathi", "Hindi"].map((lang) {
                      return ListTile(
                        title: Text(lang),
                        onTap: () {
                          setState(() {
                            selectedLanguage = lang;
                          });
                          saveSettings('selectedLanguage', lang);
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),

          SwitchListTile(
            title: const Text('Link Expiry Notifications'),
            value: linkExpiryNotifications,
            onChanged: (value) {
              setState(() {
                linkExpiryNotifications = value;
                saveSettings('linkExpiryNotifications', value);
              });
            },
          ),

          SwitchListTile(
            title: const Text('Priority Sorting Alerts'),
            value: prioritySortingAlerts,
            onChanged: (value) {
              setState(() {
                prioritySortingAlerts = value;
                saveSettings('prioritySortingAlerts', value);
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.question_answer, color: Colors.blue),
            title: const Text("FAQs"),
            onTap: openFAQs,
          ),

          ListTile(
            leading: const Icon(Icons.bug_report, color: Colors.red),
            title: const Text("Report a Bug"),
            onTap: reportBug,
          ),

          ListTile(
            leading: const Icon(Icons.phone, color: Colors.orange),
            title: const Text("Contact Us"),
            onTap: contactUs,
          ),

          ListTile(
            title: const Text('Reset to Default'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              loadSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to default.')),
              );
            },
          ),

          const ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  final Function(String) onThemeChanged;

  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  double fontSize = 16.0;
  String selectedLanguage = 'English';
  bool linkExpiryNotifications = true;
  bool prioritySortingAlerts = true;
  String themeMode = 'System Default';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      fontSize = prefs.getDouble('fontSize') ?? 16.0;
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
      linkExpiryNotifications = prefs.getBool('linkExpiryNotifications') ?? true;
      prioritySortingAlerts = prefs.getBool('prioritySortingAlerts') ?? true;
      themeMode = prefs.getString('themeMode') ?? 'System Default';
    });
  }

  Future<void> saveSettings(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) prefs.setBool(key, value);
    if (value is double) prefs.setDouble(key, value);
    if (value is String) prefs.setString(key, value);
  }

  void reportBug() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
      queryParameters: {'subject': 'Bug Report', 'body': 'Describe the issue...'},
    );
    launchUrl(emailUri);
  }

  void openFAQs() async {
    final Uri faqUri = Uri.parse("https://yourfaqpage.com");
    launchUrl(faqUri, mode: LaunchMode.externalApplication);
  }

  void contactUs() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '1234567890');
    launchUrl(phoneUri);
  }

  void showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(Icons.brightness_6, size: 40),
              SizedBox(height: 8),
              Text("Choose Theme", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Light', 'Dark', 'System Default'].map((theme) {
              return RadioListTile<String>(
                title: Text(theme),
                value: theme,
                groupValue: themeMode,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      themeMode = value;
                      saveSettings('themeMode', value);
                    });
                    widget.onThemeChanged(value);
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.link),
            title: Text('On-Links Settings'),
          ),

          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text("Theme"),
            subtitle: Text(themeMode),
            onTap: showThemeDialog,
          ),

          ListTile(
            title: const Text('Font Size'),
            subtitle: Slider(
              value: fontSize,
              min: 12,
              max: 24,
              divisions: 6,
              label: fontSize.toString(),
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                  saveSettings('fontSize', value);
                });
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.language, color: Colors.green),
            title: const Text("Language"),
            subtitle: Text(selectedLanguage),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView(
                    children: ["English", "Marathi", "Hindi"].map((lang) {
                      return ListTile(
                        title: Text(lang),
                        onTap: () {
                          setState(() {
                            selectedLanguage = lang;
                          });
                          saveSettings('selectedLanguage', lang);
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),

          SwitchListTile(
            title: const Text('Link Expiry Notifications'),
            value: linkExpiryNotifications,
            onChanged: (value) {
              setState(() {
                linkExpiryNotifications = value;
                saveSettings('linkExpiryNotifications', value);
              });
            },
          ),

          SwitchListTile(
            title: const Text('Priority Sorting Alerts'),
            value: prioritySortingAlerts,
            onChanged: (value) {
              setState(() {
                prioritySortingAlerts = value;
                saveSettings('prioritySortingAlerts', value);
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.question_answer, color: Colors.blue),
            title: const Text("FAQs"),
            onTap: openFAQs,
          ),

          ListTile(
            leading: const Icon(Icons.bug_report, color: Colors.red),
            title: const Text("Report a Bug"),
            onTap: reportBug,
          ),

          ListTile(
            leading: const Icon(Icons.phone, color: Colors.orange),
            title: const Text("Contact Us"),
            onTap: contactUs,
          ),

          ListTile(
            title: const Text('Reset to Default'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              loadSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to default.')),
              );
            },
          ),

          const ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
