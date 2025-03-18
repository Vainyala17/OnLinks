import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormData {
  final String title;
  final String url;

  FormData({required this.title, required this.url});
}

class FavoritesPage extends StatelessWidget {
  Stream<List<FormData>> getFavoriteForms() {
    return FirebaseFirestore.instance
        .collection('favorites')
        .orderBy('timestamp', descending: true)
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
              );
            },
          );
        },
      ),
    );
  }
}
