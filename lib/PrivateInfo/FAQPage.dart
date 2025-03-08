<<<<<<< HEAD
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem("What is On-Links?", "On-Links helps users find and fill online forms easily with guidance."),
            _buildFAQItem("How do I search for a form?", "Use the search bar to find forms by name or category."),
            _buildFAQItem("How do I save my favorite forms?", "Click the 'Favorite' button to save forms."),
            _buildFAQItem("Can I share a form with others?", "Yes, use the 'Share' option to share forms."),
            _buildFAQItem("How do I update my profile?", "Go to Profile Settings > Edit Profile to update info."),
            _buildFAQItem("How do I change my password?", "Go to Profile Settings > Change Password."),
            _buildFAQItem("What to do if I forget my password?", "Click 'Forgot Password' on the login screen."),
            _buildFAQItem("How can I contact support?", "Email us at support@on-links.com or use 'Contact Us' in the app."),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem("What is On-Links?", "On-Links helps users find and fill online forms easily with guidance."),
            _buildFAQItem("How do I search for a form?", "Use the search bar to find forms by name or category."),
            _buildFAQItem("How do I save my favorite forms?", "Click the 'Favorite' button to save forms."),
            _buildFAQItem("Can I share a form with others?", "Yes, use the 'Share' option to share forms."),
            _buildFAQItem("How do I update my profile?", "Go to Profile Settings > Edit Profile to update info."),
            _buildFAQItem("How do I change my password?", "Go to Profile Settings > Change Password."),
            _buildFAQItem("What to do if I forget my password?", "Click 'Forgot Password' on the login screen."),
            _buildFAQItem("How can I contact support?", "Email us at support@on-links.com or use 'Contact Us' in the app."),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
