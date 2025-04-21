import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../PrivateInfo/FavoriteProvider.dart';

class GovernmentPage extends StatefulWidget {
  @override
  _GovernmentPageState createState() => _GovernmentPageState();
}

class _GovernmentPageState extends State<GovernmentPage> {
  List<Map<String, String>> favoriteForms = [];
  final List<Map<String, String>> forms = [
    {
      'title': 'Indian Navy',
      'description': 'Apply for an Indian Navy.',
      'url': 'https://www.joinindiannavy.gov.in/en/account/account/state',
      'image': 'https://images.careerindia.com/img/2022/03/indiannavy-1647586762.jpg',
      'video': 'https://www.youtube.com/watch?v=_9lflKxKB-8',
    },
    {
      'title': 'Union Bank Saving Account Form',
      'description': 'Apply for a Union Digital Savings Account!',
      'url': 'https://casa.unionbankofindia.co.in/savings-account/#/basic-details',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-3VhitzYajMduxAA-1KWY2ox_wMhvjsxLNA&s',
      'video': 'https://www.youtube.com/watch?v=T-AVDhEUsck',
    },
    {
      'title': 'MahaGenco',
      'description': 'Recruitment for the post of Technician',
      'url': 'https://ibpsonline.ibps.in/mspgctjun23/',
      'image': 'https://getlogo.net/wp-content/uploads/2020/01/mahagenco-maharashtra-state-power-generation-co-ltd-logo-vector.png',
      'video': 'https://www.youtube.com/watch?v=TBEfQdNSQWE',
    },
    {
      'title': 'CIDCO we make Cities',
      'description': 'CIDCO we make Cities Application form',
      'url': 'https://ibpsonline.ibps.in/cidcojul24/',
      'image': 'https://pbs.twimg.com/profile_images/1564205620274016256/J4dZtUo4_400x400.jpg',
      'video': 'https://www.youtube.com/watch?v=dQQ7wNh5Pi0',
    },
    {
      'title': 'Indian Navy',
      'description': 'Apply for an Indian Navy.',
      'url': 'https://www.joinindiannavy.gov.in/en/account/account/state',
      'image': 'https://images.careerindia.com/img/2022/03/indiannavy-1647586762.jpg',
      'video': 'https://www.youtube.com/watch?v=_9lflKxKB-8',
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = forms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Government Forms')),
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
          hintText: "Search forms...",
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
        return _buildGovernmentCard(forms[index]);
      },
    );
  }

  Widget _buildGovernmentCard(Map<String, String> form) {
    return Card(
      margin: EdgeInsets.all(20),
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
            backgroundColor: Color(0xFF2196F3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormDetailsPage(
                  form: form,
                  onFavorite: (favoriteForm) {
                    setState(() {
                      favoriteForms.add(favoriteForm);
                    });
                  },
                ),
              ),
            );
          },
          child: Text("Open", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class FormDetailsPage extends StatelessWidget {
  final Map<String, String> form;
  final Function(Map<String, String>) onFavorite;

  FormDetailsPage({required this.form, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(form['title']!)),
      body: Center(  // Ensures the grid is centered
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centers content vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: GridView.count(
                shrinkWrap: true,  // Ensures the GridView doesn't take full height
                crossAxisCount: 2,  // 2 columns
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,  // Adjust the height of the grid items
                children: [
                  _buildGridItem(Icons.edit, "Fill the form here", () => _launchURL(form['url']!)),
                  _buildGridItem(Icons.play_circle_fill, "Watch the video", () {
                    if (form.containsKey('video') && form['video']!.isNotEmpty) {
                      _launchURL(form['video']!);
                    } else {
                      _showError(context);
                    }
                  }),
                  _buildGridItem(Icons.share, "Share the link", () {
                    _shareContent("Check out this form: ${form['url']!}");
                  }),
                  _buildGridItem(Icons.favorite, "Favorite", () {
                    Provider.of<FavoriteProvider>(context, listen: false).addFavorite(form);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added to favorites!")),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGridItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
void _shareContent(String content) {
  Share.share(content);
}
void _showError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('No video available for this form.')),
  );
}
void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
