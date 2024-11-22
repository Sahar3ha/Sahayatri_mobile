import 'package:flutter/material.dart';
import 'package:sahayatri/config/routes/app_routes.dart';
import 'package:sahayatri/config/themes/themedata.dart';

class SahayatriApp extends StatelessWidget {
  const SahayatriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sahayatri App",
      initialRoute: AppRoute.splashscreenRoute,
      theme: getApplicationTheme(),
      routes: AppRoute.getApplication(),
    );
  }
}
