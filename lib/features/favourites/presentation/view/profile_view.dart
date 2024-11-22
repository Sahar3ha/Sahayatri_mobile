import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/core/shared_pref/user_shared_prefs.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  String? userName;
  bool isLoading = true;
  late StreamSubscription<ProximityEvent> _proximitySubscription;

  @override
  void initState() {
    super.initState();
    fetchUserName();
    _initializeProximitySensor();
  }

  @override
  void dispose() {
    _proximitySubscription.cancel();
    super.dispose();
  }

  Future<void> fetchUserName() async {
    final userSharedPrefs = ref.read(userSharedPrefsProvider);
    final firstName = await userSharedPrefs.getUserFirstName();
    setState(() {
      userName = firstName;
      isLoading = false;
    });
  }

  void _initializeProximitySensor() {
    _proximitySubscription =
        proximityEvents!.listen((ProximityEvent event) async {
      // Adjust the proximity threshold as needed
      const double proximityThreshold = 3.0;
      if (event.proximity < proximityThreshold) {
        await _logoutAndNavigateToLogin();
      }
    });
  }

  Future<void> _logoutAndNavigateToLogin() async {
    await Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.loginRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SAHAYATRI"),
        backgroundColor: const Color.fromARGB(255, 37, 243, 43),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildProfileContent(),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Column(
      children: [
        const SizedBox(height: 15),
        SizedBox(
          height: 100,
          child: Image.asset("assets/icons/user (3).png"),
        ),
        Card(
          shadowColor: Colors.grey,
          color: const Color.fromARGB(255, 232, 232, 232),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                userName ?? 'Unknown User',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 30),
              ListTile(
                title: const Text(
                  "Give Feedback",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.feedbackRoute,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _logoutAndNavigateToLogin,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 209, 57, 33),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
