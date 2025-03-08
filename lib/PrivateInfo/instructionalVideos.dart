<<<<<<< HEAD
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
  final TextEditingController _searchController = TextEditingController();

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
      appBar: AppBar(
        title: const Text("Instructional Videos"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('videos').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          List<Map<String, String>> combinedVideos = List.from(predefinedVideos);

          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              if (doc.data() is Map<String, dynamic>) {
                combinedVideos.add({
                  "title": doc["title"] ?? "No Title",
                  "url": doc["url"] ?? "",
                });
              }
            }
          }

          // Filter based on search input
          List<Map<String, String>> filteredVideos = combinedVideos
              .where((video) => video["title"]!.toLowerCase().contains(_searchController.text.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredVideos.length,
            itemBuilder: (context, index) {
              final video = filteredVideos[index];
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
=======
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
  final TextEditingController _searchController = TextEditingController();

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
      appBar: AppBar(
        title: const Text("Instructional Videos"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('videos').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          List<Map<String, String>> combinedVideos = List.from(predefinedVideos);

          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              if (doc.data() is Map<String, dynamic>) {
                combinedVideos.add({
                  "title": doc["title"] ?? "No Title",
                  "url": doc["url"] ?? "",
                });
              }
            }
          }

          // Filter based on search input
          List<Map<String, String>> filteredVideos = combinedVideos
              .where((video) => video["title"]!.toLowerCase().contains(_searchController.text.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredVideos.length,
            itemBuilder: (context, index) {
              final video = filteredVideos[index];
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
>>>>>>> 90d5fa9 (Fix line endings)
