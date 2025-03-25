import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class FormData {
  final String title;
  final String url;

  FormData({required this.title, required this.url});
}

class FavoritesPage extends StatelessWidget {
  Stream<List<FormData>> getFavoriteForms() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]); // Return empty list if user is not logged in
    }

    return FirebaseFirestore.instance
        .collection('favorites') // Corrected path
        .where('userId', isEqualTo: user.uid) // Filter by userId
        .orderBy('timestamp', descending: true) // Ensure timestamp is added when saving
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FormData(
      title: doc['title'],
      url: doc['url'],
    ))
        .toList());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: StreamBuilder<List<FormData>>(
        stream: getFavoriteForms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No favorites added yet."));
          }

          final favoriteForms = snapshot.data!;
          return ListView.builder(
            itemCount: favoriteForms.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(favoriteForms[index].title),
                subtitle: Text(favoriteForms[index].url),
                onTap: () => _launchURL(favoriteForms[index].url),
              );
            },
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
