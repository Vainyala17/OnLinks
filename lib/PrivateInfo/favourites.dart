<<<<<<< HEAD
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
  bool isBankSelected = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    favoriteLinks = List<Map<String, dynamic>>.from(widget.favoriteLinks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
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
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(10),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           _toggleButton("Bank Forms", isBankSelected),
      //           const SizedBox(width: 10),
      //           _toggleButton("Scholarship Forms", !isBankSelected),
      //         ],
      //       ),
      //     ),
      //     Expanded(child: _buildFavoritesList()),
      //   ],
      // ),
    );
  }

  // Widget _toggleButton(String text, bool isSelected) {
  //   return GestureDetector(
  //     onTap: () => setState(() => isBankSelected = text == "Bank Forms"),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
  //       decoration: BoxDecoration(
  //         color: isSelected ? Colors.orange : Colors.grey[300],
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           color: isSelected ? Colors.white : Colors.black,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFavoritesList() {
    String query = _searchController.text.toLowerCase();

    List<Map<String, dynamic>> filteredLinks = favoriteLinks
        .where((link) =>
    link["category"] == (isBankSelected ? "Bank" : "Scholarship") &&
        (link["title"].toLowerCase().contains(query) ||
            link["description"].toLowerCase().contains(query)))
        .toList();

    if (filteredLinks.isEmpty) {
      return const Center(child: Text("No favorite links available."));
    }

    return ListView.builder(
      itemCount: filteredLinks.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: Text(filteredLinks[index]["title"]),
            subtitle: Text(filteredLinks[index]["description"]),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark_remove, color: Colors.red),
              onPressed: () {
                setState(() {
                  favoriteLinks.remove(filteredLinks[index]);
                });
              },
            ),
            onTap: () async {
              final Uri url = Uri.parse(filteredLinks[index]["url"]);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Could not open link")),
                );
              }
            },
          ),
        );
      },
    );
  }
}
=======
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
  bool isBankSelected = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    favoriteLinks = List<Map<String, dynamic>>.from(widget.favoriteLinks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
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
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(10),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           _toggleButton("Bank Forms", isBankSelected),
      //           const SizedBox(width: 10),
      //           _toggleButton("Scholarship Forms", !isBankSelected),
      //         ],
      //       ),
      //     ),
      //     Expanded(child: _buildFavoritesList()),
      //   ],
      // ),
    );
  }

  // Widget _toggleButton(String text, bool isSelected) {
  //   return GestureDetector(
  //     onTap: () => setState(() => isBankSelected = text == "Bank Forms"),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
  //       decoration: BoxDecoration(
  //         color: isSelected ? Colors.orange : Colors.grey[300],
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           color: isSelected ? Colors.white : Colors.black,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFavoritesList() {
    String query = _searchController.text.toLowerCase();

    List<Map<String, dynamic>> filteredLinks = favoriteLinks
        .where((link) =>
    link["category"] == (isBankSelected ? "Bank" : "Scholarship") &&
        (link["title"].toLowerCase().contains(query) ||
            link["description"].toLowerCase().contains(query)))
        .toList();

    if (filteredLinks.isEmpty) {
      return const Center(child: Text("No favorite links available."));
    }

    return ListView.builder(
      itemCount: filteredLinks.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: Text(filteredLinks[index]["title"]),
            subtitle: Text(filteredLinks[index]["description"]),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark_remove, color: Colors.red),
              onPressed: () {
                setState(() {
                  favoriteLinks.remove(filteredLinks[index]);
                });
              },
            ),
            onTap: () async {
              final Uri url = Uri.parse(filteredLinks[index]["url"]);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Could not open link")),
                );
              }
            },
          ),
        );
      },
    );
  }
}
>>>>>>> 90d5fa9 (Fix line endings)
