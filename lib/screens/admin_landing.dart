import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile_home.dart';
import 'web_home.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'records_page.dart';
import 'location_page.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  bool isLoggedIn = true; // Default to true since this is the admin landing page.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Admin",
          style: GoogleFonts.itim(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.lightBlue[400],
      ),
      drawer: _buildDrawer(context),
      body: isMobile(context) ? MobileHome() : WebHome(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlue[300]),
            child: Column(
              children: [
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 0),
                Text(
                  "EnviroSense",
                  style: GoogleFonts.itim(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("Location"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text("Records"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              var url = Uri.parse('http://10.0.2.2/EnviroSense_Backend/logout.php');
              var response = await http.post(url);

              if (response.statusCode == 200) {
                setState(() {
                  isLoggedIn = false;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout failed. Please try again.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
}
