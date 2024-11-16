import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the image path based on the platform
    String imagePath = kIsWeb
        ? '../../assets/device.png' // Path for web view
        : 'assets/device.png'; // Path for mobile view

    // Determine the image width based on the platform
    double imageWidth = kIsWeb
        ? screenWidth * 0.2 // 20% of screen width for web view
        : screenWidth * 0.5; // 50% of screen width for mobile view

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About Envirosense",
          style: GoogleFonts.itim(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: SingleChildScrollView( // Enable scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image of the IoT device with responsive sizing
              Center(
                child: Image.asset(
                  imagePath, // Use the determined image path
                  width: imageWidth, // Use the determined image width
                  fit: BoxFit.contain, // Maintain aspect ratio
                  semanticLabel: "Envirosense IoT Device", // Alt text for accessibility
                ),
              ),
              const SizedBox(height: 20),

              // Combined container for overview and features
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Left-align text
                  children: [
                    // Overview Section
                    Text(
                      "EnviroSense Overview",
                      style: GoogleFonts.itim(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "EnviroSense aims to collect and assess real-time data "
                      "to ensure public health and environmental safety. "
                      "The IoT device monitors temperature, humidity, gas, noise, "
                      "and dust levels in nearby areas.",
                      style: GoogleFonts.itim(fontSize: 16),
                    ),
                    const SizedBox(height: 20), // Space between sections

                    // Features Section
                    Text(
                      "Features",
                      style: GoogleFonts.itim(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "1. Real-Time Monitoring of:\n"
                      "• Humidity and Temperature\n"
                      "• Particulate Matter\n"
                      "• Total Volatile Organic Compound (TVOC)\n"
                      "• Noise Levels\n"
                      "2. LTE Communication: Data transmission via LTE technology.\n"
                      "3. Web and Mobile Platform: Accessible on both web and mobile for environmental monitoring.\n",
                      style: GoogleFonts.itim(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Add space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
