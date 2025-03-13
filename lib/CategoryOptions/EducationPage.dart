import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  List<Map<String, String>> favoriteForms = [];
  final List<Map<String, String>> forms = [
    {
      'title': 'E-Prashasan SFC',
      'description': 'BNN College(SFC) Admission Form',
      'url': 'https://app.eprashasan.com/submit/bnn_sfc',
      'image': 'https://eprashasan2.s3.ap-south-1.amazonaws.com/maindb/cms/sanstha_logo/1216400001/1216400001.png',
      'video': ''
    },
    {
      'title': 'E-Prashasan Sr_College',
      'description': 'BNN College(Sr_College) Admission Form',
      'url': 'https://app.eprashasan.com/submit/Sr_College',
      'image': 'https://eprashasan2.s3.ap-south-1.amazonaws.com/maindb/cms/sanstha_logo/1216400001/1216400001.png',
      'video': ''
    },
    {
      'title': 'Supreme Court of India',
      'description': 'Supreme Court of India Application Form',
      'url': 'https://cdn3.digialm.com/EForms/configuredHtml/32912/92214/Index.html',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Insignia_of_the_Supreme_Court_of_India.png',
      'video': ''
    },
    {
      'title': 'MAHA DBT Scholarship',
      'description': 'Aaple Sarkar MahaDBT Scholarship Form',
      'url': 'https://mahadbt.maharashtra.gov.in/RegistrationLogin/RegistrationLogin',
      'image': 'https://www.examsplanner.in/media/scholarship/mahadbt_logo.png',
      'video': ''
    },
    {
      'title': 'CUET (PG)',
      'description': 'Common University Entrance Test CUET (PG)',
      'url': 'https://exams.nta.ac.in/CUET-PG/',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS66QxirBSeO9zyt5FV0DzreRjApOZT7nr3Dw&s',
      'video': ''
    },
    {
      'title': 'NEET UG Application Form',
      'description': 'Apply for an NEET UG.',
      'url': 'https://examinationservices.nic.in/neet2025/root/Home.aspx?enc=Ei4cajBkK1gZSfgr53ImFcFR+natXIEjJ1rCf6DMgOr/hcv4rs34T5gNmvCx/R+a',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuFXxhCLrUjmKBCUnaKfxpHFT0QE32-_5vRw&s',
      'video': 'https://www.youtube.com/watch?v=rYKw93Z87JI'
    },
    {
      'title': 'Government of maharashtra State Cet Cell',
      'description': 'Apply for an Common Entrance Test Eaxms',
      'url': 'https://cetcell.mahacet.org/',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj1b14waMoQW2e14zFWGVqajtr_o1snO4jHoKs2mony48W_WJSG6wMpCUEklb1RK1_UgU&usqp=CAU',
      'video': 'https://www.youtube.com/results?search_query=how+to+fill+cet+form+2025'
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
