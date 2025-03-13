import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../PrivateInfo/favourites.dart';

class BankingPage extends StatefulWidget {
  @override
  _BankingPageState createState() => _BankingPageState();
}

class _BankingPageState extends State<BankingPage> {
  List<Map<String, String>> favoriteForms = [];
  final List<Map<String, String>> forms = [
    {
      'title': 'SBI Clerk Application Form',
      'description': 'Apply for an SBI Clerk Post.',
      'url': 'https://ibpsonline.ibps.in/sbijaoct23/',
      'image': 'https://images.careerindia.com/img/2021/06/sbiclerkadmitcard2021-1624963884.jpg',
      'video': 'https://www.youtube.com/watch?v=Ha4trn_DiYI',
    },
    {
      'title': 'Union Bank Saving Account Form',
      'description': 'Apply for a Union Digital Savings Account!',
      'url': 'https://casa.unionbankofindia.co.in/savings-account/#/basic-details',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-3VhitzYajMduxAA-1KWY2ox_wMhvjsxLNA&s',
      'video': 'https://www.youtube.com/watch?v=T-AVDhEUsck',
    },
    {
      'title': 'Aadhaar Services',
      'description': 'Update, Retrieve, or Download your Aadhaar.',
      'url': 'https://myaadhaar.uidai.gov.in/en_IN',
      'image': 'https://i0.wp.com/techsevi.com/wp-content/uploads/2019/06/Aadhar-Card.jpg?fit=640%2C426&ssl=1',
      'video': 'https://www.youtube.com/watch?v=5SyObqsb3kw',
    },
    {
      'title': 'HDFC Bank Recruitment',
      'description': 'Recruitment of Relationship Managers - Probationary Officer Program',
      'url': 'https://ibpsonline.ibps.in/hdfcrmaug24/',
      'image': 'https://1000logos.net/wp-content/uploads/2021/06/HDFC-Bank-emblem.png',
      'video': 'https://www.youtube.com/watch?v=3STF8Jgn-NA',
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = forms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Banking Forms')),
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
        return _buildBankingCard(forms[index]);
      },
    );
  }

  Widget _buildBankingCard(Map<String, String> form) {
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
                    onFavorite(form);
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
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.blue),
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
