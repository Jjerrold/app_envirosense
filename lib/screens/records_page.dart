import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor Records"),
      ),
      body: isMobile(context)
          ? buildMobileView(context)
          : buildWebView(context),
      // Floating action button at the bottom right of the screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Trigger a refresh by rebuilding the widget tree
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh),
      ),
      // Set the FAB to be at the bottom right corner
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Function to determine if the screen is mobile or web
  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

  // Mobile view with tabs for each sensor's records
  Widget buildMobileView(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs (5 sensors)
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Temperature"),
              Tab(text: "Humidity"),
              Tab(text: "Particulate Matter"),
              Tab(text: "TVOC"),
              Tab(text: "Noise"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildTable("Temperature Records (°C)"),
                buildTable("Humidity Records (%)"),
                buildTable("Particulate Matter Records (µg/m³)"),
                buildTable("TVOC Records (ppb)"),
                buildTable("Noise Records (dB)"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Web view with all tables in a single column
  Widget buildWebView(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: buildTable("Temperature Records")),
          Expanded(child: buildTable("Humidity Records")),
          Expanded(child: buildTable("Particulate Matter Records")),
          Expanded(child: buildTable("TVOC Records")),
          Expanded(child: buildTable("Noise Records")),
        ],
      ),
    );
  }

  // Table widget for displaying sensor records
  Widget buildTable(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$title',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchSensorData(title.split(" ")[0].toLowerCase()), // Pass sensor type
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text("Timestamp")),
                      DataColumn(label: Text("Value")),
                    ],
                    rows: snapshot.data!.map((record) {
                      return DataRow(cells: [
                        DataCell(Text(record['timestamp'].toString())), // Change 'date' to 'timestamp'
                        DataCell(Text(record['value'].toString())),
                      ]);
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fetch sensor data from the API
  Future<List<Map<String, dynamic>>> fetchSensorData(String sensorType) async {
    final response = await http.get(Uri.parse('https://your-backend-api-url/$sensorType'));

    if (response.statusCode == 200) {
      // Parse the response if successful
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => {
        'timestamp': e['date'], // Change 'date' to 'timestamp'
        'value': e['value'],
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
