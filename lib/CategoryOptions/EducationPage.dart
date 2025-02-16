import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final List<Map<String, String>> forms = [
    {
      'title': 'Supreme Court of India',
      'description': 'Supreme Court of India Application Form',
      'url': 'https://cdn3.digialm.com/EForms/configuredHtml/32912/92214/Index.html',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Insignia_of_the_Supreme_Court_of_India.png',
    },
    {
      'title': 'Supreme Court of India',
      'description': 'Supreme Court of India Application Form',
      'url': 'https://cdn3.digialm.com/EForms/configuredHtml/32912/92214/Index.html',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Insignia_of_the_Supreme_Court_of_India.png',
    },
    {
      'title': 'CUET (PG)',
      'description': 'Common University Entrance Test CUET (PG)',
      'url': 'https://exams.nta.ac.in/CUET-PG/',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS66QxirBSeO9zyt5FV0DzreRjApOZT7nr3Dw&s',
    },
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

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = forms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Education Forms')),
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
        return _buildEducationCard(forms[index]);
      },
    );
  }

  Widget _buildEducationCard(Map<String, String> form) {
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
                builder: (context) => FormDetailsPage(form: form),
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

  FormDetailsPage({required this.form});

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
                    // Add your video link logic here
                  }),
                  _buildGridItem(Icons.share, "Share the link", () {
                    // Add sharing logic
                  }),
                  _buildGridItem(Icons.favorite, "Favorite", () {
                    // Add favorite logic
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

void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
