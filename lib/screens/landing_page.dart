import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart'; // Import LoginPage
import 'mobile_home.dart';
import 'web_home.dart';
import 'profile_page.dart'; // Import ProfilePage
import 'about_page.dart'; // Import AboutPage
import 'records_page.dart'; // Import RecordsPage if you want to add a route for records
import 'location_page.dart'; // Import LocationPage
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fontSize: 24, // Adjust the size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // You can change this to match your theme
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text("Records"),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordsPage()), // Navigate to RecordsPage
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("Location"),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationPage()), // Navigate to LocationPage
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()), // Navigate to AboutPage
              );
            },
          ),
          // Add the Logout ListTile below About
          ListTile(
            leading: const Icon(Icons.logout), // Icon for Logout
            title: const Text("Logout"),
            onTap: () async {
              // Show a confirmation dialog
              bool? confirmLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false), // Cancel
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true), // Confirm
                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) {
                // Send a request to the backend to logout
                var url = Uri.parse('http://10.0.2.2/EnviroSense_Backend/logout.php'); // Change the URL to your actual backend
                var response = await http.post(url);

                if (response.statusCode == 200) {
                  // If logout is successful, navigate to login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  // Handle logout failure if necessary
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed. Try again.')),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
}
