import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteLinks;

  const FavoritesPage({super.key, required this.favoriteLinks});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<Map<String, dynamic>> favoriteLinks;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    favoriteLinks = List<Map<String, dynamic>>.from(widget.favoriteLinks);
  }

  void removeFavorite(Map<String, dynamic> form) {
    setState(() {
      favoriteLinks.removeWhere((fav) => fav['url'] == form['url']);
    });
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
                          onPressed: () => removeFavorite(filteredLinks[index]),
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
