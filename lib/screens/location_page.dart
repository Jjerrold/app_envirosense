import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // Default coordinates (initial position of the map)
  LatLng _center = LatLng(13.7852, 121.0748);
  double _zoom = 13.0;

  // Function to simulate updating GPS coordinates
  void _updateLocation(double lat, double lon) {
    setState(() {
      _center = LatLng(lat, lon); // Update the center position to GPS coordinates
    });
  }

  // Function to simulate receiving GPS data
  void _refreshMap() {
    // Simulating new GPS data
    double newLat = 13.7612; // New latitude (could be from GPS)
    double newLon = 121.0588; // New longitude (could be from GPS)
    
    _updateLocation(newLat, newLon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 117, 117, 117),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _center,  // Center the map based on the current coordinates
          initialZoom: _zoom,      // Set zoom level
        ),
        children: [
          TileLayer(
            tileProvider: CancellableNetworkTileProvider(),
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _center, // Place marker on the current center position
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshMap, // Calls the refresh function when pressed
        child: Icon(Icons.refresh), // Refresh icon
        backgroundColor: Colors.blue,
      ),
    );
  }
}
