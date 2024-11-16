import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http; // Import HTTP package
import 'about_page.dart'; // Make sure to import the AboutPage
import 'change_password.dart'; // Import the ChangePasswordPage

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Function to log out
  Future<void> logout(BuildContext context) async {
    final url = 'http://10.0.2.2/EnviroSense_Backend/logout.php'; // URL of your logout.php
    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        // Handle successful logout (e.g., navigate to login page)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out successfully')));
        // Navigate to login page or any other appropriate page
        Navigator.pushReplacementNamed(context, '/login'); // Adjust this route as necessary
      } else {
        // Handle error if logout fails
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout failed')));
      }
    } catch (e) {
      // Handle any errors in the HTTP request
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.itim(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Container(
        color: Colors.lightBlue[400],
        child: Column(
          children: [
            // Profile image section
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_image.png'), // Replace with your profile image
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Admin", // Replace with dynamic username
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            // General gray container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30), // Space above the email/phone container
                    // Invisible container around email and phone number
                    Container(
                      color: Colors.grey[200], // Same color as general container for invisibility
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // Email container
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Ionicons.mail, color: Colors.red),
                                const SizedBox(width: 10),
                                const Text("brgy.balagtas2018@gmail.com", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          // Phone number container
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Ionicons.call, color: Colors.green),
                                const SizedBox(width: 10),
                                const Text("(043) 409 0119", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add space between email/phone section and "Change Password"
                    const SizedBox(height: 20),
                    // Clickable Change Password container
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Change Password screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Ionicons.lock_closed, color: Colors.lightBlue),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Change Password",
                                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                              ),
                            ),
                            const Icon(Ionicons.chevron_forward, color: Colors.grey), // ">" icon
                          ],
                        ),
                      ),
                    ),
                    // Clickable About container
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Ionicons.information_circle, color: Color.fromARGB(255, 69, 69, 69)),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "About",
                                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 63, 63, 63)),
                              ),
                            ),
                            const Icon(Ionicons.chevron_forward, color: Colors.grey), // ">" icon
                          ],
                        ),
                      ),
                    ),
                    // Add space between About section and Logout button
                    const SizedBox(height: 20),
                    // Clickable Logout container
                    GestureDetector(
                      onTap: () {
                        logout(context); // Call logout function when tapped
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent, // Change color for logout button
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Ionicons.log_out, color: Colors.white),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Logout",
                                style: TextStyle(fontSize: 18, color: Colors.white), // Change text color for logout
                              ),
                            ),
                            const Icon(Ionicons.chevron_forward, color: Color.fromARGB(255, 255, 255, 255)), // ">" icon
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
