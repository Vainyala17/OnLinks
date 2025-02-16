import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'app_drawer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'CategoryOptions/BankingPage.dart';
import 'CategoryOptions/EducationPage.dart';
import 'CategoryOptions/GovernmentPage.dart';
import 'CategoryOptions/HealthPage.dart';
import 'PrivateInfo/favourites.dart';
import 'PrivateInfo/instructionalVideos.dart';
import 'PrivateInfo/privacy_policy.dart';
import 'PrivateInfo/settingPage.dart';
import 'PrivateInfo/userProfile.dart';

class HomePage extends StatefulWidget {
  final void Function(ThemeMode mode) onThemeModeChanged;
  const HomePage({super.key, required this.onThemeModeChanged});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseMessaging _messaging;
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  late Timer _timer;
  int _currentIndex = 0;
  int _currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> imageUrls = [
    'https://egov.eletsonline.com/wp-content/uploads/2016/04/MahaLogo-1.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVD5h2x2fZ1DozJ5aJwToB1CH9X0UwOhAfeGHm9usD-HgZLuL1SlmDYkHrVJB7JOd2oA&usqp=CAU',
    'https://www.eprashasan.com/myimg/logo.png',
    'https://www.uvic.ca/retirees/assets/docs/scholarship.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkgmj-AmZNelpJa1uLc2phMjL6eOuM7n_sr8CT_bMlYT3xHkKW0U6N2OgiVflLSOs5DME&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2h3_C2bDX119k2M_oxMqCXHEEpkviNT2HDQ&s',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
    _setupFCM();
  }

  void _setupFCM() async {
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(alert: true, badge: true, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      print("FCM Token: $token");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          _showNotificationDialog(message.notification!.title, message.notification!.body);
        }
      });
    }
  }

  void _showNotificationDialog(String? title, String? body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Notification'),
        content: Text(body ?? 'No content'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
            },
          ),
          items: imageUrls.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(url, fit: BoxFit.contain, width: double.infinity),
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

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed:() {
             _scaffoldKey.currentState?.openDrawer();
          }
        ),
        title: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(hintText: "Search...", prefixIcon: Icon(Icons.search, color: Colors.black54), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
      ),
      drawer: AppDrawer(favoriteLinks: [],),
      body: Column(
        children:
         [
          _buildImageSlider(),
          SizedBox(height: 8),
          Expanded(child: Center(child: Text("Home Page Content Here"))),
        ],
      ),
    );
  }
}
