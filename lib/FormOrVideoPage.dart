<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormOrVideoPage extends StatelessWidget {
  final String url;
  final bool isForm; // True for form, false for video

  FormOrVideoPage({required this.url, required this.isForm});

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
      appBar: AppBar(title: Text(isForm ? "Fill the Form" : "Watch Video")),
      body: Center(
        child: ElevatedButton(
          onPressed: openLink,
          child: Text(isForm ? "Open Form" : "Open Video"),
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormOrVideoPage extends StatelessWidget {
  final String url;
  final bool isForm; // True for form, false for video

  FormOrVideoPage({required this.url, required this.isForm});

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
      appBar: AppBar(title: Text(isForm ? "Fill the Form" : "Watch Video")),
      body: Center(
        child: ElevatedButton(
          onPressed: openLink,
          child: Text(isForm ? "Open Form" : "Open Video"),
        ),
      ),
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
