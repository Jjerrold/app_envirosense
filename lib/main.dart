import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';

void main() {
  runApp(EnviroSenseApp());
}

class EnviroSenseApp extends StatelessWidget {
  Future<bool> checkLoginStatus() async {
    // Placeholder for actual login status check
    return false; // Change this based on your actual logic
  }

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
      initialRoute: '/', // Home screen after checking login status
      routes: {
        '/': (context) => FutureBuilder<bool>(
              future: checkLoginStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  bool isLoggedIn = snapshot.data ?? false;
                  if (isLoggedIn) {
                    return LandingPage();
                  } else {
                    return LoginPage(); // Show LoginPage if not logged in
                  }
                }
              },
            ),
        '/landingpage': (context) => LandingPage(), // Add this route for landing page
        '/login': (context) => LoginPage(), // Explicitly define login route
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LoginPage(), // Navigate to LoginPage if route not found
        );
      },
    );
  }
}
