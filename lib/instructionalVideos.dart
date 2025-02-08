import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AddLinkScreen.dart';

class InstructionalVideosPage extends StatefulWidget {
  const InstructionalVideosPage({super.key});

  @override
  _InstructionalVideosPageState createState() => _InstructionalVideosPageState();
}

class _InstructionalVideosPageState extends State<InstructionalVideosPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Predefined links
  final List<Map<String, String>> predefinedVideos = [
    {
      "title": "Mahadbt Scholarship",
      "url": "https://www.youtube.com/watch?v=Z31B7Q-q2GM",
    },
    {
      "title": "Bank KYC Update",
      "url": "https://www.youtube.com/watch?v=abcdef12345",
    },
    {
      "title": "Aadhar Link Guide",
      "url": "https://www.youtube.com/watch?v=ghijkl67890",
    },
  ];

  void openVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instructional Videos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('videos').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          List<Map<String, String>> combinedVideos = List.from(predefinedVideos);

          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              combinedVideos.add({
                "title": doc["title"],
                "url": doc["url"],
              });
            }
          }

          return ListView.builder(
            itemCount: combinedVideos.length,
            itemBuilder: (context, index) {
              final video = combinedVideos[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.video_library, color: Colors.blue),
                  title: Text(video["title"]!, style: const TextStyle(fontSize: 18)),
                  subtitle: Text(video["url"]!, style: const TextStyle(color: Colors.blue)),
                  onTap: () => openVideo(video["url"]!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLinkScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
