import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class FormData {
  final String title;
  final String url;

  FormData({required this.title, required this.url});
}

class MyGridPage extends StatelessWidget {
  final String formUrl = 'https://example.com';
  final String videoUrl = 'https://youtube_video_link.com';

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

  void onFavorite(BuildContext context, FormData form) async {
    try {
      await FirebaseFirestore.instance.collection('favorites').add({
        'title': form.title,
        'url': form.url,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added to favorites!")),
      );
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onFavorite(context, FormData(title: "Sample Form", url: formUrl));
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
