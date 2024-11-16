import 'package:flutter/material.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  // Function to determine if the screen is mobile or web
  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor Records"),
      ),
      body: isMobile(context) 
        ? buildMobileView(context) 
        : buildWebView(context),
    );
  }

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
                buildTable("Temperature Records"),
                buildTable("Humidity Records"),
                buildTable("Particulate Matter Records"),
                buildTable("TVOC Records"),
                buildTable("Noise Records"),
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
      child: Column(
        children: [
          buildTable("Temperature Records"),
          buildTable("Humidity Records"),
          buildTable("Particulate Matter Records"),
          buildTable("TVOC Records"),
          buildTable("Noise Records"),
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
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Value")),
                DataColumn(label: Text("Interval")),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("2024-11-11 12:00 PM")),
                  DataCell(Text("24°C")),
                  DataCell(Text("1 hour")),
                ]),
                DataRow(cells: [
                  DataCell(Text("2024-11-11 01:00 PM")),
                  DataCell(Text("25°C")),
                  DataCell(Text("1 hour")),
                ]),
                // Add more rows dynamically or hardcoded for testing
              ],
            ),
          ],
        ),
      ),
    );
  }
}
