import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificatesPage extends StatefulWidget {
  @override
  _CertificatesPageState createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Certificates Forms')),
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
      'title': 'SBI Clerk Application Form',
      'description': 'Apply for an SBI Clerk Post.',
      'url': 'https://ibpsonline.ibps.in/sbijaoct23/',
      'image': 'https://images.careerindia.com/img/2021/06/sbiclerkadmitcard2021-1624963884.jpg',
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
        return _buildCertificatesCard(forms[index]);
      },
    );
  }

  Widget _buildCertificatesCard(Map<String, String> form) {
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
      'title': 'Union Bank Saving Account Form',
      'description': 'Apply for a Union Digital Savings Account!',
      'url': 'https://casa.unionbankofindia.co.in/savings-account/#/basic-details',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-3VhitzYajMduxAA-1KWY2ox_wMhvjsxLNA&s',
    },
    {
      'title': 'Aadhaar Services',
      'description': 'Update, Retrieve, or Download your Aadhaar.',
      'url': 'https://myaadhaar.uidai.gov.in/en_IN',
      'image': 'https://i0.wp.com/techsevi.com/wp-content/uploads/2019/06/Aadhar-Card.jpg?fit=640%2C426&ssl=1',
    },
    {
      'title': 'HDFC Bank Recruitment',
      'description': 'Recruitment of Relationship Managers - Probationary Officer Program',
      'url': 'https://ibpsonline.ibps.in/hdfcrmaug24/',
      'image': 'https://1000logos.net/wp-content/uploads/2021/06/HDFC-Bank-emblem.png',
    },
    {
      'title': 'Aadhaar Services',
      'description': 'Update, Retrieve, or Download your Aadhaar.',
      'url': 'https://myaadhaar.uidai.gov.in/en_IN',
      'image': 'https://i0.wp.com/techsevi.com/wp-content/uploads/2019/06/Aadhar-Card.jpg?fit=640%2C426&ssl=1',
    },
    {
      'title': 'Aadhaar Services',
      'description': 'Update, Retrieve, or Download your Aadhaar.',
      'url': 'https://myaadhaar.uidai.gov.in/en_IN',
      'image': 'https://i0.wp.com/techsevi.com/wp-content/uploads/2019/06/Aadhar-Card.jpg?fit=640%2C426&ssl=1',
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
        return _buildCertificatesCard(forms[index]);
      },
    );
  }

  Widget _buildCertificatesCard(Map<String, String> form) {
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
