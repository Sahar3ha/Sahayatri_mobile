import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteCoordinatesPage extends StatefulWidget {
  final String origin;
  final String destination;

  const RouteCoordinatesPage({
    super.key,
    required this.origin,
    required this.destination,
  });

  @override
  State<RouteCoordinatesPage> createState() => _RouteCoordinatesPageState();
}

class _RouteCoordinatesPageState extends State<RouteCoordinatesPage> {
  List<LatLng> routePoints = [];
  final PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _fetchCoordinates();
  }

  Future<void> _fetchCoordinates() async {
    const apiKey =
        'pk.eyJ1Ijoicm9hZHdheW1hbiIsImEiOiJjbGY3ejR3ZjkwYnlrM3NudjJkYzgxcnRtIn0.jdReqoWAgSK93Ruy1iPRSQ';
    final originUrl =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${widget.origin}.json?access_token=$apiKey';
    final destinationUrl =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${widget.destination}.json?access_token=$apiKey';

    final originResponse = await http.get(Uri.parse(originUrl));
    final destinationResponse = await http.get(Uri.parse(destinationUrl));

    if (originResponse.statusCode == 200 &&
        destinationResponse.statusCode == 200) {
      final originData = json.decode(originResponse.body);
      final destinationData = json.decode(destinationResponse.body);

      final originCoords = originData['features'][0]['center'];
      final destinationCoords = destinationData['features'][0]['center'];

      _fetchRoute(originCoords, destinationCoords);
    } else {
      // Handle error
      print('Failed to fetch coordinates');
    }
  }

  Future<void> _fetchRoute(
      List<dynamic> originCoords, List<dynamic> destinationCoords) async {
    const apiKey =
        'pk.eyJ1Ijoicm9hZHdheW1hbiIsImEiOiJjbGY3ejR3ZjkwYnlrM3NudjJkYzgxcnRtIn0.jdReqoWAgSK93Ruy1iPRSQ'; // Replace with your Mapbox API key
    final url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${originCoords[0]},${originCoords[1]};${destinationCoords[0]},${destinationCoords[1]}?access_token=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final geometry = decoded['routes'][0]['geometry'];
      final List<PointLatLng> result = polylinePoints.decodePolyline(geometry);

      setState(() {
        routePoints = result
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    } else {
      // Handle error
      print('Failed to fetch route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Coordinates'),
        backgroundColor: const Color.fromARGB(255, 112, 255, 136),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          if (routePoints.isNotEmpty) _buildMap(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoTile('From', widget.origin),
          const SizedBox(height: 10),
          _buildInfoTile('To', widget.destination),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Flexible(
      child: FlutterMap(
        options: MapOptions(
          initialCenter: routePoints.first,
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/roadwayman/clt635o6c00vf01pihz2hgxea/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9hZHdheW1hbiIsImEiOiJjbGY3ejR3ZjkwYnlrM3NudjJkYzgxcnRtIn0.jdReqoWAgSK93Ruy1iPRSQ',
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: routePoints.first,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 36.0,
                ),
              ),
              Marker(
                width: 40.0,
                height: 40.0,
                point: routePoints.last,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
