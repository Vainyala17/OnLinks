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
      'title': 'MAHA DBT Scholarship',
      'description': 'Aaple Sarkar MahaDBT Scholarship Form',
      'url': 'https://mahadbt.maharashtra.gov.in/RegistrationLogin/RegistrationLogin',
      'image': 'data:image/png;base64,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',
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
