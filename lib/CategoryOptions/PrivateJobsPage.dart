import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class PrivateJobsPage extends StatefulWidget {
  @override
  _PrivateJobsPageState createState() => _PrivateJobsPageState();
}

class _PrivateJobsPageState extends State<PrivateJobsPage> {
  List<Map<String, String>> favoriteForms = [];
  final List<Map<String, String>> forms = [
    {
      'title': 'Infosys',
      'description': 'Infosys IT Jobs',
      'url': 'https://in.findajob.website/registration/index.php?campaign=facebook-infosys-ldn&version=2&utm_medium=paid&utm_source=ig&utm_id=120217055978730327&utm_content=120217055978770327&utm_term=120217055978780327&utm_campaign=120217055978730327&fbclid=PAZXh0bgNhZW0BMABhZGlkAasYxq0wr1cBpuAT_D-Ma-nq3wNMTqVv2DLtB_ArXNViUj96DiSXvPVpqDCfYPsDk11FhA_aem_hJHx-05sPIwJnOb2PvFF5w',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn7pqwQe4ncAaF26On1VRBw3zPHsCoAhGDUQ&s',
      'video': 'https://www.youtube.com/watch?v=IOX_Krhy44Q',
    },
    {
      'title': 'TCS',
      'description': 'TCSNextStep NQT Application form',
      'url': 'https://nextstep.tcs.com/campus/#/',
      'image': 'https://www.freshersnow.com/wp-content/uploads/2022/04/TCS-Company.png',
      'video': 'https://www.youtube.com/watch?v=54RiEhkAJdU'
    },
    {
      'title': 'Amazon',
      'description': 'Amazon Job Application Form',
      'url': 'https://www.amazon.jobs/en/search?base_query=GO-AI+Operations',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMnYPXIDmRTKpj1drsmIRD_0NJJLVIVnMJNA&s',
      'video': 'https://www.youtube.com/watch?v=uZrM7H5Ao3s',
    },
    {
      'title': 'Wipro',
      'description': 'Wipro SIM Hiring',
      'url': 'https://app.joinsuperset.com/join/#/signup/student/jobprofiles/ed576c6d-5565-4f67-96f5-97771dff45c0',
      'image': 'https://w7.pngwing.com/pngs/797/378/png-transparent-wipro-logo-business-information-technology-consulting-business-text-people-logo-thumbnail.png',
      'video': 'https://www.youtube.com/watch?v=qwYXyMW_DUo&list=UULFnYD9b1YZgZlCsuc8CTRfQg',
    },
    {
      'title': 'Cognizant',
      'description': 'Cognizant Off-Campus Hiring',
      'url': 'https://app.joinsuperset.com/join/#/signup/student/jobprofiles/80927bc8-841c-4055-a89d-e207fdb67bd9',
      'image':'https://w7.pngwing.com/pngs/455/885/png-transparent-cognizant-technology-solutions-australia-business-corporation-management-consulting-business-text-people-logo-thumbnail.png',
      'video': 'https://www.youtube.com/watch?v=j6STjA84hRs&list=UULFnYD9b1YZgZlCsuc8CTRfQg',
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = forms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('PrivateJobs Forms')),
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
        return _buildPrivateJobsCard(forms[index]);
      },
    );
  }

  Widget _buildPrivateJobsCard(Map<String, String> form) {
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
