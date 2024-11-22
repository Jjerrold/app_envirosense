import 'package:flutter/material.dart';
import '../widgets/sensor_gauge.dart';
import '../mqtt_service.dart';

class MobileHome extends StatefulWidget {
  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  final mqttService = MqttService();

  int _currentIndex = 0;
  final List<String> sensors = ["Temperature", "Humidity", "Gas", "Noise", "Dust"];
  final List<double> values = [0.0, 0.0, 0.0, 0.0, 0.0];
  final List<IconData> sensorIcons = [
    Icons.thermostat,
    Icons.water,
    Icons.cloud,
    Icons.hearing,
    Icons.filter_drama,
  ];

  @override
  void initState() {
    super.initState();
    mqttService.connect().then((_) {
      mqttService.subscribe('sensors/temperature', (message) => _updateSensorValue(0, message));
      mqttService.subscribe('sensors/humidity', (message) => _updateSensorValue(1, message));
      mqttService.subscribe('sensors/gas', (message) => _updateSensorValue(2, message));
      mqttService.subscribe('sensors/noise', (message) => _updateSensorValue(3, message));
      mqttService.subscribe('sensors/dust', (message) => _updateSensorValue(4, message));
    });
  }

  void _updateSensorValue(int index, String message) {
    setState(() {
      values[index] = double.tryParse(message) ?? values[index];
    });
  }

  @override
  void dispose() {
    mqttService.disconnect();
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
