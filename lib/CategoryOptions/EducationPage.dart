
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Education Forms')),
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


