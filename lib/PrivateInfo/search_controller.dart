<<<<<<< HEAD
import 'package:flutter/material.dart';

class CustomSearchController with ChangeNotifier {
  final List<String> allItems = [
    "Health Form A",
    "Health Form B",
    "Health Guide C",
    "COVID-19 Vaccination Form",
    "General Health Checkup Form",
  ];

  List<String> filteredItems = [];

  CustomSearchController() {
    filteredItems = allItems; // Initialize with all items
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = allItems; // Show all items if search query is empty
    } else {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter items based on the query
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  List<String> get getFilteredItems => filteredItems;
}
=======
import 'package:flutter/material.dart';

class CustomSearchController with ChangeNotifier {
  final List<String> allItems = [
    "Health Form A",
    "Health Form B",
    "Health Guide C",
    "COVID-19 Vaccination Form",
    "General Health Checkup Form",
  ];

  List<String> filteredItems = [];

  CustomSearchController() {
    filteredItems = allItems; // Initialize with all items
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = allItems; // Show all items if search query is empty
    } else {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter items based on the query
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  List<String> get getFilteredItems => filteredItems;
}
>>>>>>> 90d5fa9 (Fix line endings)
