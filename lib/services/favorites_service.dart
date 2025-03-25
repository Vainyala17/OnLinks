import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveToFavorites(String id, String title, String url) async {
    final user = _auth.currentUser;
    if (user == null) return; // Ensure user is logged in

    await _firestore
        .collection('users') // Store under each user
        .doc(user.uid)
        .collection('favorites')
        .doc(id)
        .set({
      'title': title,
      'url': url,
      'timestamp': FieldValue.serverTimestamp(), // For sorting
    });
  }

  Stream<QuerySnapshot> getFavorites() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.empty(); // Return empty stream if user is not logged in
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
