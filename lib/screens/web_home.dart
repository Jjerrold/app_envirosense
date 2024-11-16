import 'package:flutter/material.dart';
import '../widgets/sensor_gauge.dart';
import 'dart:async';

class WebHome extends StatefulWidget {
  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  double temperature = 0.0;
  double humidity = 0.0;
  double gas = 0.0;
  double noise = 0.0;
  double dust = 0.0;

  @override
  void initState() {
    super.initState();
    // Fetch sensor data when the widget initializes and set up a timer for periodic updates
    fetchSensorData();
    Timer.periodic(Duration(seconds: 10), (timer) => fetchSensorData()); // Refresh every 10 seconds
  }

  Future<void> fetchSensorData() async {
    // Replace this with your actual data-fetching code.
    // For example, if you use an HTTP GET request to fetch JSON data, parse it, and update the sensor values
    try {
      // Example: Mocking real-time data (replace with actual HTTP request)
      setState(() {
        temperature = 26.5; // Replace with actual temperature from backend
        humidity = 58.0;    // Replace with actual humidity from backend
        gas = 20.0;         // Replace with actual gas level from backend
        noise = 35.0;       // Replace with actual noise level from backend
        dust = 12.5;        // Replace with actual dust level from backend
      });
    } catch (e) {
      print("Error fetching sensor data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth > 1000) {
      crossAxisCount = 3;
      childAspectRatio = 1.0;
    } else if (screenWidth > 600) {
      crossAxisCount = 2;
      childAspectRatio = 1.1;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 1.2;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        children: [
          SensorGauge(title: "Temperature", value: temperature, icon: Icons.thermostat),
          SensorGauge(title: "Humidity", value: humidity, icon: Icons.water),
          SensorGauge(title: "Gas", value: gas, icon: Icons.cloud),
          SensorGauge(title: "Noise", value: noise, icon: Icons.hearing),
          SensorGauge(title: "Dust", value: dust, icon: Icons.filter_drama),
        ],
      ),
    );
  }
}
