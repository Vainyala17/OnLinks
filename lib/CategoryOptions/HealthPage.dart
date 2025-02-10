// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../PrivateInfo/search_controller.dart';
//
// class HealthPage extends StatefulWidget {
//   const HealthPage({super.key});
//
//   @override
//   State<HealthPage> createState() => _HealthPageState();
// }
//
// class _HealthPageState extends State<HealthPage> {
//   final TextEditingController _searchController = TextEditingController();
//   String selectedCategory = 'All';
//   List<String> recentForms = [];
//   List<String> favoriteForms = [];
//
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//   }
//
//   void _initializeNotifications() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     const androidSettings = AndroidInitializationSettings('app_icon');
//     const initializationSettings = InitializationSettings(android: androidSettings);
//
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> _showNotification(String formName) async {
//     const androidDetails = AndroidNotificationDetails(
//       'health_channel',
//       'Health Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const platformDetails = NotificationDetails(android: androidDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Reminder',
//       '$formName is nearing expiry!',
//       platformDetails,
//     );
//   }
//
//   void _addToRecent(String formName) {
//     if (!recentForms.contains(formName)) {
//       setState(() {
//         recentForms.insert(0, formName);
//       });
//     }
//     _showNotification(formName);
//   }
//
//   void _toggleFavorite(String formName) {
//     setState(() {
//       if (favoriteForms.contains(formName)) {
//         favoriteForms.remove(formName);
//       } else {
//         favoriteForms.add(formName);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final searchController = Provider.of<CustomSearchController>(context);
//
//     List<String> filteredList = selectedCategory == 'All'
//         ? searchController.getFilteredItems
//         : searchController.getFilteredItems.where((item) => item.contains(selectedCategory)).toList();
//     filteredList.sort();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Health Forms"),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               _buildSearchBar(),
//               const SizedBox(height: 16),
//               _buildCategoryDropdown(),
//               const SizedBox(height: 16),
//               _buildQuickActions(),
//               const SizedBox(height: 16),
//               _buildFormsList(filteredList),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return TextField(
//       controller: _searchController,
//       decoration: InputDecoration(
//         hintText: 'Search health forms...',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         prefixIcon: const Icon(Icons.search),
//       ),
//       onChanged: (query) {
//         Provider.of<CustomSearchController>(context, listen: false).filterItems(query);
//       },
//     );
//   }
//
//   Widget _buildCategoryDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedCategory,
//       items: ['All', 'Health Forms', 'COVID Forms', 'Checkups']
//           .map((category) => DropdownMenuItem(value: category, child: Text(category)))
//           .toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedCategory = value!;
//         });
//       },
//       decoration: InputDecoration(
//         labelText: "Select Category",
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
//
//   Widget _buildQuickActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildActionButton("New Form", Icons.add, Colors.green),
//         _buildActionButton("History", Icons.history, Colors.orange),
//         _buildActionButton("Favorites", Icons.favorite, Colors.red),
//       ],
//     );
//   }
//
//   Widget _buildActionButton(String label, IconData icon, Color color) {
//     return ElevatedButton.icon(
//       onPressed: () {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$label clicked")));
//       },
//       icon: Icon(icon, color: Colors.white),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
//
//   Widget _buildFormsList(List<String> forms) {
//     final Map<String, IconData> healthIcons = {
//       "Health Form A": Icons.local_hospital,
//       "Health Form B": Icons.medical_services,
//       "Health Guide C": Icons.health_and_safety,
//       "COVID-19 Vaccination Form": Icons.vaccines,
//       "General Health Checkup Form": Icons.check,
//     };
//
//     if (forms.isEmpty) {
//       return const Text("No forms available in this category.");
//     }
//
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: forms.length,
//       itemBuilder: (context, index) {
//         final formName = forms[index];
//
//         return Card(
//           child: ListTile(
//             leading: Icon(healthIcons[formName] ?? Icons.insert_drive_file),
//             title: Text(formName),
//             trailing: Icon(
//               favoriteForms.contains(formName) ? Icons.favorite : Icons.favorite_border,
//               color: Colors.red,
//             ),
//             onTap: () {
//               _addToRecent(formName);
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$formName selected")));
//             },
//             onLongPress: () {
//               _toggleFavorite(formName);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("$formName ${favoriteForms.contains(formName) ? 'added to' : 'removed from'} favorites")),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => CustomSearchController(),
//       child: const MaterialApp(home: HealthPage()),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthPage extends StatefulWidget {
  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Forms')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(200, 50),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClosedFormsPage()),
              ),
              child: Text(
                "Closed Forms",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(200, 50),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OpenedFormsPage()),
              ),
              child: Text(
                "Latest Opened Forms",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClosedFormsPage extends StatefulWidget {
  @override
  _ClosedFormsPageState createState() => _ClosedFormsPageState();
}

class _ClosedFormsPageState extends State<ClosedFormsPage> {
  final List<Map<String, String>> closedForms = [
    {
      'title': 'Supreme Court of India',
      'description': 'Supreme Court of India Application Form',
      'url': 'https://cdn3.digialm.com/EForms/configuredHtml/32912/92214/Index.html',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/9/96/Insignia_of_the_Supreme_Court_of_India.svg',
    },
    {
      'title': 'Supreme Court of India',
      'description': 'Supreme Court of India Application Form',
      'url': 'https://cdn3.digialm.com/EForms/configuredHtml/32912/92214/Index.html',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/9/96/Insignia_of_the_Supreme_Court_of_India.svg',
    },
    {
      'title': 'Supreme Court of India',
      'description': 'Supreme Court of India Application Form',
      'url': 'https://cdn3.digialm.com/EForms/configuredHtml/32912/92214/Index.html',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/9/96/Insignia_of_the_Supreme_Court_of_India.svg',
    },
  ];
  String searchQuery = "";

  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = closedForms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text('Closed Forms')),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildFormsList(filteredForms)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          setState(() {
            searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: "Search closed forms...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildFormsList(List<Map<String, String>> forms) {
    return ListView.builder(
      itemCount: forms.length,
      itemBuilder: (context, index) {
        return _buildHealthCard(forms[index]);
      },
    );
  }

  Widget _buildHealthCard(Map<String, String> form) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(form['image']!, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(form['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(form['description']!),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6366F1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => _launchURL(form['url']!),
          child: Text("Open", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class OpenedFormsPage extends StatefulWidget {
  @override
  _OpenedFormsPageState createState() => _OpenedFormsPageState();
}

class _OpenedFormsPageState extends State<OpenedFormsPage> {
  final List<Map<String, String>> openedForms = [
    {
      'title': 'AIIMS Bhubaneswar Application Form',
      'description': 'Apply for an AIIMS Bhubaneswar.',
      'url': 'https://aiimsbbsrrecruitment.nic.in/Index/institute_register/ins/NzBjbmdUNi9IZ0hGOW1SSDZFWjRJUT09',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvtVQuWr0xI_Hlsu_AcsBhR2SdxwbfRTXNXQ&s',
    },
    {
      'title': 'RRB Application Form',
      'description': 'Railway Recruitment Board.. Ministry of Railways, Government of India',
      'url': 'https://www.rrbapply.gov.in/#/auth/home?flag=true',
      'image': 'https://w7.pngwing.com/pngs/236/834/png-transparent-railway-recruitment-board-exam-rrb-rail-transport-south-eastern-railway-zone-indian-railways-others-miscellaneous-text-logo.png',
    },
  ];

  String searchQuery = "";

  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = openedForms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text('Latest Opened Forms')),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildFormsList(filteredForms)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          setState(() {
            searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: "Search opened forms...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildFormsList(List<Map<String, String>> forms) {
    return ListView.builder(
      itemCount: forms.length,
      itemBuilder: (context, index) {
        return _buildHealthCard(forms[index]);
      },
    );
  }

  Widget _buildHealthCard(Map<String, String> form) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(form['image']!, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(form['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(form['description']!),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6366F1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => _launchURL(form['url']!),
          child: Text("Open", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}


