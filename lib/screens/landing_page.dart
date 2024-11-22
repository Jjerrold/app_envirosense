import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about_page.dart';
import 'mobile_home.dart';
import 'web_home.dart';
import 'login_page.dart'; // Import LoginPage
import 'location_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for the scaffold

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the key for the scaffold
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "EnviroSense",
          style: GoogleFonts.itim(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          // Profile icon that opens a drawer
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Opens the end drawer
            },
          ),
        ],
        backgroundColor: Colors.lightBlue[400],
      ),
      drawer: _buildDrawer(context), // Side navigation drawer
      endDrawer: _buildProfileDrawer(context), // Drawer for the profile icon
      body: isMobile(context) ? MobileHome() : WebHome(),
    );
  }

  // Function to build the main side nav (drawer)
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
        ],
      ),
    );
  }

  // Function to build the drawer for the profile icon
  Widget _buildProfileDrawer(BuildContext context) {
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
            leading: const Icon(Icons.login),
            title: const Text("Admin Login"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to login page
              );
            },
          ),
        ],
      ),
    );
  }

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
}
