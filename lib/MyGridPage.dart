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
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareContent(String content) {
    Share.share(content);
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
      body: Stack(
        children: [
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.3, // Move grid up
            left: -MediaQuery.of(context).size.width * 0.3, // Move grid left
            right: -MediaQuery.of(context).size.width * 0.3, // Move grid right
            bottom: -MediaQuery.of(context).size.height * 0.3, // Move grid down
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
              clipBehavior: Clip.none,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildGridItem(Icons.edit, "Fill the form here", () {
                  _launchURL(formUrl);
                }),
                _buildGridItem(Icons.play_circle_fill, "Watch the video", () {
                  _launchURL(videoUrl);
                }),
                _buildGridItem(Icons.share, "Share the link", () {
                    _shareContent(
                        "Check out this amazing app or link: https://yourlink.com");
                    Navigator.pop(context);
                }),
                _buildGridItem(Icons.favorite, "Favorite", () {
                  _addToFavorites(formUrl);
                }),
              ],
            ),
          ),
        ],
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
