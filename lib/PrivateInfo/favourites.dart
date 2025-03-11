import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoriteLinks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoriteData = prefs.getString('favoriteLinks');
    if (favoriteData != null) {
      setState(() {
        favoriteLinks = List<Map<String, dynamic>>.from(json.decode(favoriteData));
      });
    }
  }

  Future<void> _addToFavorite(Map<String, dynamic> form) async {
    if (!favoriteLinks.any((fav) => fav['url'] == form['url'])) {
      setState(() {
        favoriteLinks.add(form);
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('favoriteLinks', json.encode(favoriteLinks));

      Fluttertoast.showToast(msg: "Added to favorites"); // ✅ Show toast message
    } else {
      Fluttertoast.showToast(msg: "Already in favorites"); // ✅ Prevent duplicate storage
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredLinks = favoriteLinks
        .where((link) => link["title"]
        .toLowerCase()
        .contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Search forms...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLinks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(filteredLinks[index]["icon"]),
                    ),
                    title: Text(
                      filteredLinks[index]["title"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(filteredLinks[index]["description"]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () => _addToFavorite(filteredLinks[index]), // ✅ Only store link, no navigation
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri url = Uri.parse(filteredLinks[index]["url"]);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          child: const Text("Open"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
