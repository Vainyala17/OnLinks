import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyGridPage extends StatelessWidget {
  final String formUrl = 'https://example.com';
  final String videoUrl = 'https://youtube_video_link.com';

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Opens in default browser
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareLink(String url) {
    Share.share(url);
  }

  void _addToFavorites(String url) {
    FirebaseFirestore.instance.collection('favorites').add({
      'url': url,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Supreme Court of India")),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8, // Controls width
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8, // Matches image layout
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildGridItem(Icons.edit, "Fill the form here", () {
                _launchURL(formUrl);
              }),
              _buildGridItem(Icons.play_circle_fill, "Watch the video", () {
                _launchURL(videoUrl);
              }),
                _buildGridItem(Icons.share, "Share the link", () {
                  _shareLink(formUrl);
                }),
                _buildGridItem(Icons.favorite, "Favorite", () {
                  _addToFavorites(formUrl);
                }),
            ],
          ),
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
