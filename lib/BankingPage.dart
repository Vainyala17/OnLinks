import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BankingPage extends StatefulWidget {
  const BankingPage({super.key});

  @override
  _BankingPageState createState() => _BankingPageState();
}

class _BankingPageState extends State<BankingPage> {
  final List<String> forms = ['Bank Form 1', 'Bank Form 2', 'Bank Form 3']; // Example banking forms

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banking Forms'),
      ),
      body: ListView.builder(
        itemCount: forms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(forms[index]),
            onTap: () {
              // Navigate to form details or a page where users can fill out the form
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormDetailsPage(formName: forms[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class FormDetailsPage extends StatelessWidget {
  final String formName;
  const FormDetailsPage({super.key, required this.formName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formName),
      ),
      body: Center(
        child: Text('Details of $formName will be shown here.'),
      ),
    );
  }
}

class SortedFormsPage extends StatelessWidget {
  final List<Map<String, dynamic>> forms = [
    {'name': 'Bank Form 1', 'popularity': 5},
    {'name': 'Bank Form 2', 'popularity': 10},
    {'name': 'Bank Form 3', 'popularity': 3},
  ];

  SortedFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    forms.sort((a, b) => b['popularity'].compareTo(a['popularity'])); // Sort by popularity

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Banking Forms'),
      ),
      body: ListView.builder(
        itemCount: forms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(forms[index]['name']),
            subtitle: Text('Popularity: ${forms[index]['popularity']}'),
          );
        },
      ),
    );
  }
}

class SuggestedFormsPage extends StatelessWidget {
  final List<String> suggestedForms = ['Bank Form 1', 'Bank Form 2', 'Bank Form 3'];

  SuggestedFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggested Banking Forms'),
      ),
      body: ListView.builder(
        itemCount: suggestedForms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestedForms[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FormDetailsPage(formName: suggestedForms[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              // Switch to English
            },
          ),
          ListTile(
            title: Text('Marathi'),
            onTap: () {
              // Switch to Marathi
            },
          ),
          ListTile(
            title: Text('Hindi'),
            onTap: () {
              // Switch to Hindi
            },
          ),
        ],
      ),
    );
  }
}

void setupNotifications() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle notification
    if (message.notification != null) {
      // Display a simple notification dialog
      print(message.notification!.title); // Example: Print notification title
    }
  });
}
