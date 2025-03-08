<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLinkScreen extends StatefulWidget {
  const AddLinkScreen({super.key});

  @override
  _AddLinkScreenState createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveLink() async {
    final String title = _titleController.text.trim();
    final String url = _urlController.text.trim();

    if (title.isNotEmpty && url.isNotEmpty) {
      await _firestore.collection('videos').add({
        'title': title,
        'url': url,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context); // Go back to the list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Video Link')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLink,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLinkScreen extends StatefulWidget {
  const AddLinkScreen({super.key});

  @override
  _AddLinkScreenState createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveLink() async {
    final String title = _titleController.text.trim();
    final String url = _urlController.text.trim();

    if (title.isNotEmpty && url.isNotEmpty) {
      await _firestore.collection('videos').add({
        'title': title,
        'url': url,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context); // Go back to the list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Video Link')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLink,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
