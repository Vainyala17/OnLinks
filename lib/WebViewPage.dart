import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({required this.url});

  void openLink() async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Open in Browser")),
      body: Center(
        child: ElevatedButton(
          onPressed: openLink,
          child: Text("Open Link"),
        ),
      ),
    );
  }
}
