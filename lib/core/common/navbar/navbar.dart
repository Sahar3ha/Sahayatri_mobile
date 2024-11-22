import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sahayatri/config/routes/app_routes.dart';

class SnakeNavigationBarWidget extends StatefulWidget {
  final int selectedIndex;

  const SnakeNavigationBarWidget({
    required this.selectedIndex,
    super.key,
  });

  @override
  State<SnakeNavigationBarWidget> createState() =>
      _SnakeNavigationBarWidgetState();
}

class _SnakeNavigationBarWidgetState extends State<SnakeNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      backgroundColor: const Color.fromARGB(255, 0, 241, 141),
      snakeShape: SnakeShape.circle, // Set snake shape to circle
      snakeViewColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[600],
      showUnselectedLabels: true,
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        // Push different routes based on the selected index
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, AppRoute.vehicleRoute);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, AppRoute.favouritesRoute);
            break;
          case 2:
            Navigator.pushReplacementNamed(context, AppRoute.profileRoute);
            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
      ],
    );
  }
}
