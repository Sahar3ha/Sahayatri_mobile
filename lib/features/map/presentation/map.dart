import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class DirectionView extends StatefulWidget {
  const DirectionView({super.key});

  @override
  State<DirectionView> createState() => _DirectionViewState();
}

class _DirectionViewState extends State<DirectionView> {
  late MapController mapController;
  List<LatLng> routePoints = [];
  final LatLng origin = const LatLng(37.7749, -122.4194); // San Francisco
  final LatLng destination = const LatLng(34.0522, -118.2437); // Los Angeles

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    const apiKey =
        'pk.eyJ1Ijoicm9hZHdheW1hbiIsImEiOiJjbGY3ejR3ZjkwYnlrM3NudjJkYzgxcnRtIn0.jdReqoWAgSK93Ruy1iPRSQ'; // Replace with your Mapbox API key
    final url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?access_token=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final geometry = decoded['routes'][0]['geometry'];
      final PolylinePoints polylinePoints = PolylinePoints();
      final List<PointLatLng> result = polylinePoints.decodePolyline(geometry);
      final List<LatLng> routePoints = result.map((PointLatLng point) {
        return LatLng(point.latitude, point.longitude);
      }).toList();

      setState(() {
        this.routePoints = routePoints;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Route'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng((origin.latitude + destination.latitude) / 2,
              (origin.longitude + destination.longitude) / 2),
          zoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://api.mapbox.com/styles/v1/roadwayman/clsvi6ssd005701qwddzzdkcf/wmts?access_token=pk.eyJ1Ijoicm9hZHdheW1hbiIsImEiOiJjbGY3ejR3ZjkwYnlrM3NudjJkYzgxcnRtIn0.jdReqoWAgSK93Ruy1iPRSQ',
            subdomains: const ['a', 'b', 'c'],
          ),
          if (routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  color: Colors.blue,
                  strokeWidth: 4,
                ),
              ],
            ),
        ],
      ),
    );
  }
}