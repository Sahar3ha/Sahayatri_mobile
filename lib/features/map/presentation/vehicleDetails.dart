import 'package:flutter/material.dart';
import 'package:sahayatri/features/map/presentation/routeCoordinates.dart';

class VehicleDetailsPage extends StatelessWidget {
  final String vehicleName;
  final String origin;
  final String destination;

  const VehicleDetailsPage({
    super.key,
    required this.vehicleName,
    required this.origin,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
        backgroundColor: const Color.fromARGB(255, 112, 255, 136),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Vehicle Name:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              vehicleName,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RouteCoordinatesPage(
                      origin: origin,
                      destination: destination,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 112, 255, 136),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Show Route',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
