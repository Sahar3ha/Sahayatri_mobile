import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';

class ProximityScreen extends StatefulWidget {
  const ProximityScreen({Key? key}) : super(key: key);

  @override
  State<ProximityScreen> createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  double _proximityValue = 0;
  late StreamSubscription<ProximityEvent> _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription =
        proximityEvents!.listen((ProximityEvent event) {
          setState(() {
            _proximityValue = event.proximity;
            if (_proximityValue < 3) {
              // If proximity is less than 3 cm, navigate to another page
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => Next(), // Replace NextScreen with your desired screen
                ),
              );
            }
          });
        });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proximity'),
      ),
      body: Center(
        child: _proximityValue >= 4
            ? const Text(
          "Object is far",
          style: TextStyle(
            fontSize: 25,
          ),
        )
            : const Text(
          'Object is near',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

// Replace NextScreen with your desired screen
class Next extends StatelessWidget {
  const Next({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text(
          'You are close to the sensor!',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
