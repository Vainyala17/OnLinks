import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'CategoryOptions/BankingPage.dart';
import 'CategoryOptions/CertificatesPage.dart';
import 'CategoryOptions/PrivateJobsPage.dart';
import 'CategoryOptions/EducationPage.dart';
import 'CategoryOptions/GovernmentPage.dart';
import 'CategoryOptions/HealthPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_drawer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final void Function(ThemeMode mode) onThemeModeChanged;
  const HomePage({super.key, required this.onThemeModeChanged});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  final List<Map<String, String>> categories = [
    {'name': 'Education', 'image': 'assets/images/education.png'},
    {'name': 'Bank', 'image': 'assets/images/bank.png'},
    {'name': 'Government', 'image': 'assets/images/government.png'},
    {'name': 'Healthcare', 'image': 'assets/images/health.png'},
    {'name': 'Certificates', 'image': 'assets/images/certificate.png'},
    {'name': 'Private Jobs', 'image': 'assets/images/privateJob.png'},
  ];

  final List<String> imageUrls = [
    'https://egov.eletsonline.com/wp-content/uploads/2016/04/MahaLogo-1.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVD5h2x2fZ1DozJ5aJwToB1CH9X0UwOhAfeGHm9usD-HgZLuL1SlmDYkHrVJB7JOd2oA&usqp=CAU',
    'https://app.eprashasan.com/assets/images/logos/logo.png',
    'https://www.uvic.ca/retirees/assets/docs/scholarship.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkgmj-AmZNelpJa1uLc2phMjL6eOuM7n_sr8CT_bMlYT3xHkKW0U6N2OgiVflLSOs5DME&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2h3_C2bDX119k2M_oxMqCXHEEpkviNT2HDQ&s',
  ];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _setupFCM();
  }

  void _initializeSpeech() async {
    await Permission.microphone.request(); // Ensure microphone access
    bool available = await _speech.initialize(
      onError: (error) => print("Speech Error: $error"),
      onStatus: (status) => print("Speech Status: $status"),
    );
    if (!available) {
      print("Speech recognition is not available");
    }
  }

  void _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true, badge: true, sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          _showNotificationDialog(
              message.notification!.title, message.notification!.body);
        }
      });
    }
  }

  void _showNotificationDialog(String? title, String? body) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(title ?? 'Notification'),
            content: Text(body ?? 'No content'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
          ),
    );
  }

  void _toggleListening() async {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
      _performSearch(_searchController.text);
    } else {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _searchController.text = result.recognizedWords;
            });
          },
          listenFor: Duration(seconds: 5),
        );
      } else {
        print("Speech recognition not available");
      }
    }
  }
  void _performSearch(String query) {
    print("Searching for: $query");
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _speech.stop();
    super.dispose();
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.3,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          items: imageUrls.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                url,
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/placeholder.png', height: 200),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: imageUrls.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.white,
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            switch (categories[index]['name']) {
              case 'Education':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EducationPage()));
                break;
              case 'Bank':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BankingPage()));
                break;
              case 'Government':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GovernmentPage()));
                break;
              case 'Healthcare':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HealthPage()));
                break;
              case 'Certificates':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CertificatePage()));
                break;
              case 'Private Jobs':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivateJobsPage()));
                break;
              default:
                break;
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(categories[index]['image']!, height: 130),
                SizedBox(height: 8),
                Text(categories[index]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black54),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                  ),
                  onSubmitted: (query) => _performSearch(query),
                ),
              ),
              IconButton(
                icon: Icon(_isListening ? Icons.mic_off : Icons.mic,
                    color: Colors.grey),
                onPressed: _toggleListening,
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(favoriteLinks: [],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageSlider(),
            SizedBox(height: 20),
            _buildCategoryGrid()
          ],
        ),
      ),
    );
  }
}
