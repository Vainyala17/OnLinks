<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class MyGridPage extends StatelessWidget {
  final String formUrl = 'https://example.com'; // Example form URL
  final String videoUrl = 'https://youtube_video_link.com'; // Example video URL

  // Open link in the browser
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Share the link
  void _shareLink(String url) {
    Share.share(url);
  }

  // Add to Favorites
  void _addToFavorites(String url) {
    FirebaseFirestore.instance.collection('favorites').add({
      'url': url,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid Navigation")),
      body: GridView.count(
        crossAxisCount: 2, // Adjust the number of columns
        children: <Widget>[
          GridTile(
            child: GestureDetector(
              onTap: () {
                _launchURL(formUrl); // Open form in browser
              },
              child: Container(
                color: Colors.blue,
                child: Center(child: Text("Fill the Form")),
              ),
            ),
          ),
          GridTile(
            child: GestureDetector(
              onTap: () {
                _launchURL(videoUrl); // Open video in browser
              },
              child: Container(
                color: Colors.green,
                child: Center(child: Text("Watch Video")),
              ),
            ),
          ),
          GridTile(
            child: GestureDetector(
              onTap: () {
                _shareLink(formUrl); // Share the form link
              },
              child: Container(
                color: Colors.orange,
                child: Center(child: Text("Share")),
              ),
            ),
          ),
          GridTile(
            child: GestureDetector(
              onTap: () {
                _addToFavorites(formUrl); // Add to favorites
              },
              child: Container(
                color: Colors.red,
                child: Center(child: Text("Favourite")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class MyGridPage extends StatelessWidget {
  final String formUrl = 'https://example.com'; // Example form URL
  final String videoUrl = 'https://youtube_video_link.com'; // Example video URL

  // Open link in the browser
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Share the link
  void _shareLink(String url) {
    Share.share(url);
  }

  // Add to Favorites
  void _addToFavorites(String url) {
    FirebaseFirestore.instance.collection('favorites').add({
      'url': url,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid Navigation")),
      body: GridView.count(
        crossAxisCount: 2, // Adjust the number of columns
        children: <Widget>[
          GridTile(
            child: GestureDetector(
              onTap: () {
                _launchURL(formUrl); // Open form in browser
              },
              child: Container(
                color: Colors.blue,
                child: Center(child: Text("Fill the Form")),
              ),
            ),
          ),
          GridTile(
            child: GestureDetector(
              onTap: () {
                _launchURL(videoUrl); // Open video in browser
              },
              child: Container(
                color: Colors.green,
                child: Center(child: Text("Watch Video")),
              ),
            ),
          ),
          GridTile(
            child: GestureDetector(
              onTap: () {
                _shareLink(formUrl); // Share the form link
              },
              child: Container(
                color: Colors.orange,
                child: Center(child: Text("Share")),
              ),
            ),
          ),
          GridTile(
            child: GestureDetector(
              onTap: () {
                _addToFavorites(formUrl); // Add to favorites
              },
              child: Container(
                color: Colors.red,
                child: Center(child: Text("Favourite")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
