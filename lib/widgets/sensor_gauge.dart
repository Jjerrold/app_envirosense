import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class SensorGauge extends StatelessWidget {
  final String title;
  final double value;
  final double minValue;
  final double maxValue;
  final IconData icon;

  SensorGauge({
    required this.title,
    required this.value,
    this.minValue = 0,
    this.maxValue = 100,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;
        double gaugeSize;

        // Adjust gauge size based on screen width
        if (availableWidth > 800) {
          gaugeSize = 300;
        } else if (availableWidth > 500) {
          gaugeSize = 250;
        } else if (availableWidth > 400) {
          gaugeSize = 200;
        } else {
          gaugeSize = 150;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: Colors.black54)),
            SizedBox(height: 10),
            Container(
              height: gaugeSize + 50,
              width: gaugeSize + 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedRadialGauge(
                    duration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    radius: gaugeSize * 0.45,
                    value: value,
                    axis: GaugeAxis(
                      min: minValue,
                      max: maxValue,
                      degrees: 260,
                      style: const GaugeAxisStyle(
                        thickness: 20,
                        background: Color(0xFFDFE2EC),
                      ),
                      progressBar: const GaugeProgressBar.rounded(
                        color: Color(0xFFB4C2F8),
                      ),
                    ),
                    builder: (context, child, value) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        value.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Icon(icon, size: 40, color: Colors.black54),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class GaugeTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sensor Gauges'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Temperature'),
              Tab(text: 'Humidity'),
              Tab(text: 'Gas'),
              Tab(text: 'Noise'),
              Tab(text: 'Dust'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SensorGauge(
                    title: 'Temperature',
                    value: 75.0, // Update with your dynamic value
                    icon: Icons.thermostat,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SensorGauge(
                    title: 'Humidity',
                    value: 60.0, // Update with your dynamic value
                    icon: Icons.water_damage,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SensorGauge(
                    title: 'Gas',
                    value: 30.0, // Update with your dynamic value
                    icon: Icons.local_gas_station, // Use an appropriate icon
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SensorGauge(
                    title: 'Noise',
                    value: 45.0, // Update with your dynamic value
                    icon: Icons.volume_up,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SensorGauge(
                    title: 'Dust',
                    value: 20.0, // Update with your dynamic value
                    icon: Icons.grain, // Use an appropriate icon
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GaugeTabView(),
  ));
}
