import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class MyGridPage extends StatelessWidget {
  // Replace this with your form URL or dynamic data.
  final Map<String, String> form = {'url': 'https://example.com'};

  // Launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Build Grid Item
  Widget _buildGridItem(IconData icon, String text, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid Navigation")),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildGridItem(Icons.edit, "Fill the form here", () => _launchURL(form['url']!)),
          _buildGridItem(Icons.play_circle_fill, "Watch the video", () {
            // Replace with your video URL logic
            // _launchURL(videoUrl);
          }),
          _buildGridItem(Icons.share, "Share the link", () {
            // Implement share logic here
          }),
          _buildGridItem(Icons.favorite, "Favorite", () {
            // Implement favorite logic here
          }),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyGridPage()));
}
