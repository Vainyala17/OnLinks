import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'favourites.dart';
import 'instructionalVideos.dart';
import 'userProfile.dart'; // Import the user profile page
import 'HealthPage.dart';
import 'BankingPage.dart';
import 'EducationPage.dart';
import 'GovernmentPage.dart';
import 'settingPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


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
  final List<String> imageUrls = [
    'https://egov.eletsonline.com/wp-content/uploads/2016/04/MahaLogo-1.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVD5h2x2fZ1DozJ5aJwToB1CH9X0UwOhAfeGHm9usD-HgZLuL1SlmDYkHrVJB7JOd2oA&usqp=CAU',
    'https://www.eprashasan.com/myimg/logo.png',
    'https://www.uvic.ca/retirees/assets/docs/scholarship.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkgmj-AmZNelpJa1uLc2phMjL6eOuM7n_sr8CT_bMlYT3xHkKW0U6N2OgiVflLSOs5DME&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2h3_C2bDX119k2M_oxMqCXHEEpkviNT2HDQ&s',
  ];

  List<String> favoriteLinks = [];
  List<String> filteredForms = [];
  String? selectedCategory;
  final List<String> categories = [
    'Health',
    'Banking',
    'Education',
    'Government'
  ];
  final List<String> popularForms = [
    'Health Form A',
    'Bank Form B',
    'Education Form C',
    'Bank Form D',
    'Health Form E',
    'Education Form F',
  ];
  @override
  void initState() {
    super.initState();
    _setupFCM();
  }
  void _setupFCM() async {
    _messaging = FirebaseMessaging.instance;

    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permissions for notifications.");

      // Get the FCM token
      String? token = await _messaging.getToken();
      print("FCM Token: $token");

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          print('Message Title: ${message.notification!.title}');
          print('Message Body: ${message.notification!.body}');
          _showNotificationDialog(message.notification!.title, message.notification!.body);
        }
      });
    } else {
      print("User denied notification permissions.");
    }
  }
  void _showNotificationDialog(String? title, String? body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Notification'),
        content: Text(body ?? 'No content'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(String link) {
    setState(() {
      if (favoriteLinks.contains(link)) {
        favoriteLinks.remove(link);
      } else {
        favoriteLinks.add(link);
      }
    });
  }

  void _filterForms(String query) {
    setState(() {
      filteredForms = popularForms
          .where((form) => form.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _shareContent(String content) {
    Share.share(content);
  }

  void _navigateToCategoryPage(String category) {
    print("Navigating to $category page...");
    switch (category) {
      case 'Health':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HealthPage()),
        );
        break;
      case 'Banking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BankingPage()),
        );
        break;
      case 'Education':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EducationPage()),
        );
        break;
      case 'Government':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GovernmentPage()),
        );
        break;
      default:
        break;
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[800], // Dark background like the image
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white), // Drawer icon
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white, // White background for search
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search, color: Colors.black54), // Search icon
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        // actions: [
        //   DropdownButton<ThemeMode>(
        //     value: Theme
        //         .of(context)
        //         .brightness == Brightness.dark
        //         ? ThemeMode.dark
        //         : ThemeMode.light,
        //     onChanged: (ThemeMode? mode) {
        //       if (mode != null) {
        //         widget.onThemeModeChanged(
        //             mode); // Call the onThemeModeChanged callback
        //       }
        //     },
        //     items: const [
        //       DropdownMenuItem(
        //         value: ThemeMode.light,
        //         child: Text('Light Mode'),
        //       ),
        //       DropdownMenuItem(
        //         value: ThemeMode.dark,
        //         child: Text('Dark Mode'),
        //       ),
        //       DropdownMenuItem(
        //         value: ThemeMode.system,
        //         child: Text('System Default'),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfilePage(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: currentUser?.photoURL != null
                          ? NetworkImage(currentUser!.photoURL!)
                          : const AssetImage(
                            'assets/default_profile.png') as ImageProvider,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentUser?.displayName ?? 'Guest User',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Other menu options here
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                print('History clicked');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {
                _shareContent(
                    "Check out this amazing app or link: https://yourlink.com");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate'),
              onTap: () {
                print('Rate clicked');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text('Download'),
              onTap: () {
                print('Download clicked');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Privacy Policy'),
              onTap: () {
                print('Privacy Policy clicked');
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FavoritesPage(favoriteLinks: favoriteLinks),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Instructional Videos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstructionalVideosPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: categories
                      .map((category) =>
                      DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                      _navigateToCategoryPage(value);
                    }
                  },
                  hint: const Text('Choose'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = imageUrls[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            favoriteLinks.contains(imageUrl)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteLinks.contains(imageUrl)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            _toggleFavorite(imageUrl);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: imageUrls.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Popular Forms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: filteredForms.isNotEmpty
                    ? filteredForms.length
                    : popularForms.length,
                itemBuilder: (context, index) {
                  final form = filteredForms.isNotEmpty
                      ? filteredForms [index]
                      : popularForms[index];
                  return Card(
                    child: GridTile(
                      footer: IconButton(
                        icon: Icon(
                          favoriteLinks.contains(form)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoriteLinks.contains(form)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          _toggleFavorite(form);
                        },
                      ),
                      child: Center(
                        child: Text(form),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

