import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sahayatri/features/home/presentation/view_model/home_viewmodel.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents!.listen((AccelerometerEvent event) {
      if (_isShakeDetected(event)) {
        final homeState = ref.read(homeViewModelProvider);
        if (homeState.index != 1) {
          ref.read(homeViewModelProvider.notifier).changeIndex(1);
        }
      }
    });
  }

  bool _isShakeDetected(AccelerometerEvent event) {
    const double threshold = 15.0;
    return event.x.abs() > threshold ||
        event.y.abs() > threshold ||
        event.z.abs() > threshold;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      body: homeState.lstWidgets[homeState.index],
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: const Color.fromARGB(255, 0, 241, 141),
        snakeShape: SnakeShape.circle,
        snakeViewColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        currentIndex: homeState.index,
        onTap: (index) {
          ref.read(homeViewModelProvider.notifier).changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }
}
