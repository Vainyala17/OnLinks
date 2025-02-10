import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GovernmentPage extends StatefulWidget {
  @override
  _GovernmentPageState createState() => _GovernmentPageState();
}

class _GovernmentPageState extends State<GovernmentPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Government Forms')),
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
      'title': 'Indian Navy',
      'description': 'Apply for an Indian Navy.',
      'url': 'https://www.joinindiannavy.gov.in/en/account/account/state',
      'image': 'https://images.careerindia.com/img/2022/03/indiannavy-1647586762.jpg',
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
        return _buildGoverntmentCard(forms[index]);
      },
    );
  }

  Widget _buildGoverntmentCard(Map<String, String> form) {
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
      'description': 'Joint Director Accounts & Treasuries Nagpur!',
      'url': 'https://casa.unionbankofindia.co.in/savings-account/#/basic-details',
      'image': 'https://st5.depositphotos.com/9851828/62088/v/450/depositphotos_620882968-stock-illustration-government-maharashtra-icon-lamp-sanskrit.jpg',
    },
    {
      'title': 'MahaGenco',
      'description': 'Recruitment for the post of Technician',
      'url': 'https://ibpsonline.ibps.in/mspgctjun23/',
      'image': 'https://getlogo.net/wp-content/uploads/2020/01/mahagenco-maharashtra-state-power-generation-co-ltd-logo-vector.png',
    },
    {
      'title': 'CIDCO we make Cities',
      'description': 'CIDCO we make Cities Application form',
      'url': 'https://ibpsonline.ibps.in/cidcojul24/',
      'image': 'https://pbs.twimg.com/profile_images/1564205620274016256/J4dZtUo4_400x400.jpg',
    },
    {
      'title': 'Indian Navy',
      'description': 'Apply for an Indian Navy.',
      'url': 'https://www.joinindiannavy.gov.in/en/account/account/state',
      'image': 'https://images.careerindia.com/img/2022/03/indiannavy-1647586762.jpg',
    },
    {
      'title': 'CIDCO we make Cities',
      'description': 'CIDCO we make Cities Application form',
      'url': 'https://ibpsonline.ibps.in/cidcojul24/',
      'image': 'https://pbs.twimg.com/profile_images/1564205620274016256/J4dZtUo4_400x400.jpg',
    },
    {
      'title': 'CIDCO we make Cities',
      'description': 'CIDCO we make Cities Application form',
      'url': 'https://ibpsonline.ibps.in/cidcojul24/',
      'image': 'https://pbs.twimg.com/profile_images/1564205620274016256/J4dZtUo4_400x400.jpg',
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
        return _buildGoverntmentCard(forms[index]);
      },
    );
  }

  Widget _buildGoverntmentCard(Map<String, String> form) {
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
