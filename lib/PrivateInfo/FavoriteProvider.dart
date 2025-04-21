import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get favorites => _favorites;

  void addFavorite(Map<String, String> form) {
    if (!_favorites.any((item) => item['title'] == form['title'])) {
      _favorites.add(form);
      notifyListeners();
    }
  }

  void removeFavorite(String title) {
    _favorites.removeWhere((item) => item['title'] == title);
    notifyListeners();
  }
}
