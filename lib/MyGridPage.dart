import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/favorites_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkModel {
  final String id;
  final String title;
  final String url;

  LinkModel({required this.id, required this.title, required this.url});
}

class MyGridPage extends StatelessWidget {
  final String formUrl = 'https://example.com';
  final String videoUrl = 'https://youtube_video_link.com';
  final FavoritesService favoritesService = FavoritesService();

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareContent(String content) {
    Share.share(content);
  }

  void _saveToFavorites(BuildContext context, LinkModel linkData) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You need to log in to save favorites!")),
      );
      return;
    }

    try {
      await favoritesService.saveToFavorites(linkData.id, linkData.title, linkData.url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added to favorites!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add to favorites.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final linkData = LinkModel(id: "123", title: "Example Form", url: formUrl);

    return Scaffold(
      appBar: AppBar(title: Text("Grid Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
          children: [
            _buildGridItem(Icons.edit, "Fill the form here", () {
              _launchURL(formUrl);
            }),
            _buildGridItem(Icons.play_circle_fill, "Watch the video", () {
              _launchURL(videoUrl);
            }),
            _buildGridItem(Icons.share, "Share the link", () {
              _shareContent("Check out this amazing app or link: $formUrl");
            }),
            _buildGridItem(Icons.favorite, "Favorite", () {
              _saveToFavorites(context, linkData);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
