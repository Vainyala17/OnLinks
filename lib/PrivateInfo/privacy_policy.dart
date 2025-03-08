<<<<<<< HEAD
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Last updated: February 2025", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
              SizedBox(height: 20),

              Text("1. Introduction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("On-Links respects your privacy and is committed to protecting your personal data."),

              SizedBox(height: 15),
              Text("2. Information We Collect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We may collect personal and non-personal data, including:"),
              Text("- Personal Information: Name, email (if provided)."),
              Text("- Non-Personal Data: Device info, usage logs, analytics data."),

              SizedBox(height: 15),
              Text("3. How We Use Your Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We use your data to improve app functionality, enhance security, and personalize user experience."),

              SizedBox(height: 15),
              Text("4. Third-Party Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We may use Firebase for authentication and analytics. We do not sell your personal data."),

              SizedBox(height: 15),
              Text("5. Security Measures", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We take appropriate security measures to protect your data from unauthorized access."),

              SizedBox(height: 15),
              Text("6. Your Rights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("You have the right to access, update, or delete your data by contacting us."),

              SizedBox(height: 15),
              Text("7. Updates to This Policy", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We may update this policy from time to time. Please check this page for updates."),

              SizedBox(height: 15),
              Text("8. Contact Us", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("If you have any questions, contact us at support@onlinks.com."),

              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Last updated: February 2025", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
              SizedBox(height: 20),

              Text("1. Introduction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("On-Links respects your privacy and is committed to protecting your personal data."),

              SizedBox(height: 15),
              Text("2. Information We Collect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We may collect personal and non-personal data, including:"),
              Text("- Personal Information: Name, email (if provided)."),
              Text("- Non-Personal Data: Device info, usage logs, analytics data."),

              SizedBox(height: 15),
              Text("3. How We Use Your Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We use your data to improve app functionality, enhance security, and personalize user experience."),

              SizedBox(height: 15),
              Text("4. Third-Party Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We may use Firebase for authentication and analytics. We do not sell your personal data."),

              SizedBox(height: 15),
              Text("5. Security Measures", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We take appropriate security measures to protect your data from unauthorized access."),

              SizedBox(height: 15),
              Text("6. Your Rights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("You have the right to access, update, or delete your data by contacting us."),

              SizedBox(height: 15),
              Text("7. Updates to This Policy", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("We may update this policy from time to time. Please check this page for updates."),

              SizedBox(height: 15),
              Text("8. Contact Us", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("If you have any questions, contact us at support@onlinks.com."),

              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
