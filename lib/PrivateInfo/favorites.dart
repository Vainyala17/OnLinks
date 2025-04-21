import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../PrivateInfo/FavoriteProvider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text("My Favorites")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites yet!", style: TextStyle(fontSize: 18)))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final form = favorites[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    form['image']!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  ),
                ),
                title: Text(form['title'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(form['description'] ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: Colors.redAccent, size: 24),
                  onPressed: () {
                    _showRemoveDialog(context, form['title']!);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Remove Favorite"),
        content: Text("Really want to remove this item from favorites?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text("Remove", style: TextStyle(color: Colors.red)),
            onPressed: () {
              Provider.of<FavoriteProvider>(context, listen: false).removeFavorite(title);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Removed from favorites")),
              );
            },
          ),
        ],
      ),
    );
  }
}
