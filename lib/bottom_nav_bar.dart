  import 'package:flutter/material.dart';
  import 'package:flutter_project/services/chat_screen.dart';
  import 'PrivateInfo/favourites.dart';
  import 'PrivateInfo/instructionalVideos.dart';
  import 'PrivateInfo/userProfile.dart';
  import 'home.dart';


  class BottomNavBar extends StatefulWidget {
    @override
    _BottomNavBarState createState() => _BottomNavBarState();
  }

  class _BottomNavBarState extends State<BottomNavBar> {
    int _currentIndex = 0;

    final List<Widget> _pages = [
      HomePage(onThemeModeChanged: (ThemeMode mode) {  },),
      FavoritesPage(favoriteLinks: [],),
      ChatScreen(),
      InstructionalVideosPage(),
      UserProfilePage(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _pages[_currentIndex], // Display the selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      );
    }
  }
