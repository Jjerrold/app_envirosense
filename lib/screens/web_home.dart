import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
    try {
      // Replace with your actual backend URL
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/get-sensor-data'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          for (var reading in data) {
            switch (reading['sensor_name']) {
              case "Temperature":
                temperature = double.parse(reading['sensor_value']);
                break;
              case "Humidity":
                humidity = double.parse(reading['sensor_value']);
                break;
              case "Gas":
                gas = double.parse(reading['sensor_value']);
                break;
              case "Noise":
                noise = double.parse(reading['sensor_value']);
                break;
              case "Dust":
                dust = double.parse(reading['sensor_value']);
                break;
            }
          }
        });
      } else {
        print("Failed to fetch sensor data: ${response.statusCode}");
      }
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

    return Scaffold(
      body: Padding(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchSensorData(); // Trigger data refresh
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.blue,
        tooltip: 'Refresh Data',
      ),
    );
  }
}
