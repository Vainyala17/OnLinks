import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project/services/firebase_messaging_service.dart';
import 'CategoryOptions/BankingPage.dart';
import 'CategoryOptions/EducationPage.dart';
import 'CategoryOptions/GovernmentPage.dart';
import 'CategoryOptions/HealthPage.dart';
import 'LogReg/Login.dart';
import 'LogReg/password.dart';
import 'LogReg/register.dart';
import 'PrivateInfo/favorites.dart';
import 'PrivateInfo/instructionalVideos.dart';
import 'PrivateInfo/search_controller.dart';
import 'PrivateInfo/theme_preference.dart';
import 'WebViewPage.dart';
import 'bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print("Background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  try {
    await Firebase.initializeApp();
    print("✅ Firebase Initialized Successfully!");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,  // Use debug mode during development
      webProvider: ReCaptchaV3Provider('your-actual-site-key'),  // Set actual site key
    );

    await FirebaseMessagingService.initialize();
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  getToken();
  final themePreference = ThemePreference();
  final savedThemeMode = await themePreference.getThemeMode();
  print("Initial Theme Mode in main(): $savedThemeMode"); // Debugging
  runApp(MyApp(savedThemeMode: savedThemeMode));
}
void getToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("✅ FCM Token: $token");
  } catch (e) {
    print("❌ Error Fetching Token: $e");
  }
}
void setupNotifications() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      var flutterLocalNotificationsPlugin;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.high,
          ),
        ),
      );
    }
  });
}
void saveFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  if (token != null) {
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fcmToken': token,
    }, SetOptions(merge: true));
  }
}
class MyApp extends StatefulWidget {
  final ThemeMode savedThemeMode;
  const MyApp({super.key, required this.savedThemeMode});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.savedThemeMode;
  }


  void _updateThemeMode(ThemeMode mode) async {
    final themePreference = ThemePreference();
    await themePreference.saveThemeMode(mode);

    setState(() {
      _themeMode = mode; // Update the theme mode
    });
    print("Theme Updated to: $_themeMode"); // Debugging
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Base design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (_) => CustomSearchController(),
          child: MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: 'home',
            routes: {
              'login': (context) => MyLogin(),
              'register': (context) => MyRegister(),
              'password': (context) => SetPassword(),
              'home': (context) => BottomNavBar(),
              'favorite': (context) => FavoritesPage(),
              'instruVideo': (context) => InstructionalVideosPage(),
              'HealthPage': (context) => HealthPage(),
              'BankingPage': (context) => BankingPage(),
              'GovernmentPage': (context) => GovernmentPage(),
              'EducationPage': (context) => EducationPage(),
              'webviewPage': (context) => WebViewPage(url: '',),
            },
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}

class AppInitializer extends StatelessWidget {
  final Function(ThemeMode) onThemeModeChanged;

  const AppInitializer({super.key, required this.onThemeModeChanged});

  Future<void> _initializeApp() async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference users = db.collection('users');
      final DocumentSnapshot snapshot = await users.doc('user').get();
      final userFields = snapshot.data() as Map<String, dynamic>? ?? {};
      print("🔍 User data fetched: $userFields"); // Debugging // You can use this data if needed
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("🚨 Failed to load app. Please restart.")),
          );
        } else {
          return MyLogin(); // Show login screen after initialization
        }
      },
    );
  }
}