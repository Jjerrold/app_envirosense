import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/sensor_gauge.dart';

class MobileHome extends StatefulWidget {
  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  List<String> sensors = ["Temperature", "Humidity", "Gas", "Noise", "Dust"];
  List<double> values = [0.0, 0.0, 0.0, 0.0, 0.0];
  List<IconData> sensorIcons = [
    Icons.thermostat,
    Icons.water,
    Icons.cloud,
    Icons.hearing,
    Icons.filter_drama,
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  fetchSensorData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get-sensor-data'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        for (var reading in data) {
          int index = sensors.indexOf(reading['sensor_name']);
          if (index != -1) {
            values[index] = double.parse(reading['sensor_value']);
          }
        }
      });
    } else {
      print("Failed to fetch sensor data: ${response.statusCode}");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Colors.blueGrey[50],
            child: Center(
              child: Text(
                "Realtime Sensor Data",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 23,
                ),
              ),
            ),
          ),

          // Sensor gauge
          Expanded(
            child: Center(
              child: SensorGauge(
                title: sensors[_currentIndex],
                value: values[_currentIndex],
                icon: sensorIcons[_currentIndex],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: sensors.asMap().entries.map((entry) {
          int index = entry.key;
          String sensor = entry.value;
          return BottomNavigationBarItem(
            icon: Icon(sensorIcons[index]),
            label: sensor,
          );
        }).toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightBlue[300],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
