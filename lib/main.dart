import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/admin_landing.dart';

void main() {
  runApp(EnviroSenseApp());
}

class EnviroSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnviroSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[300],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue[300],
          elevation: 0,
        ),
      ),
      initialRoute: '/', // Set the landing page as the initial route
      routes: {
        '/': (context) => LandingPage(), // LandingPage is now the initial screen
        '/landingpage': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/admin_landing': (context) => AdminLandingPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LandingPage(), // Fallback to LandingPage
        );
      },
    );
  }
}
