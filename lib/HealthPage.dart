import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'search_controller.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';
  List<String> recentForms = [];
  List<String> favoriteForms = [];

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(android: androidSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String formName) async {
    const androidDetails = AndroidNotificationDetails(
      'health_channel',
      'Health Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Reminder',
      '$formName is nearing expiry!',
      platformDetails,
    );
  }

  void _addToRecent(String formName) {
    if (!recentForms.contains(formName)) {
      setState(() {
        recentForms.insert(0, formName);
      });
    }
    _showNotification(formName);
  }

  void _toggleFavorite(String formName) {
    setState(() {
      if (favoriteForms.contains(formName)) {
        favoriteForms.remove(formName);
      } else {
        favoriteForms.add(formName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<CustomSearchController>(context);

    List<String> filteredList = selectedCategory == 'All'
        ? searchController.getFilteredItems
        : searchController.getFilteredItems.where((item) => item.contains(selectedCategory)).toList();
    filteredList.sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Forms"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCategoryDropdown(),
              const SizedBox(height: 16),
              _buildQuickActions(),
              const SizedBox(height: 16),
              _buildFormsList(filteredList),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search health forms...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.search),
      ),
      onChanged: (query) {
        Provider.of<CustomSearchController>(context, listen: false).filterItems(query);
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      items: ['All', 'Health Forms', 'COVID Forms', 'Checkups']
          .map((category) => DropdownMenuItem(value: category, child: Text(category)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
      },
      decoration: InputDecoration(
        labelText: "Select Category",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton("New Form", Icons.add, Colors.green),
        _buildActionButton("History", Icons.history, Colors.orange),
        _buildActionButton("Favorites", Icons.favorite, Colors.red),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$label clicked")));
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildFormsList(List<String> forms) {
    final Map<String, IconData> healthIcons = {
      "Health Form A": Icons.local_hospital,
      "Health Form B": Icons.medical_services,
      "Health Guide C": Icons.health_and_safety,
      "COVID-19 Vaccination Form": Icons.vaccines,
      "General Health Checkup Form": Icons.check,
    };

    if (forms.isEmpty) {
      return const Text("No forms available in this category.");
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forms.length,
      itemBuilder: (context, index) {
        final formName = forms[index];

        return Card(
          child: ListTile(
            leading: Icon(healthIcons[formName] ?? Icons.insert_drive_file),
            title: Text(formName),
            trailing: Icon(
              favoriteForms.contains(formName) ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onTap: () {
              _addToRecent(formName);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$formName selected")));
            },
            onLongPress: () {
              _toggleFavorite(formName);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$formName ${favoriteForms.contains(formName) ? 'added to' : 'removed from'} favorites")),
              );
            },
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CustomSearchController(),
      child: const MaterialApp(home: HealthPage()),
    ),
  );
}
