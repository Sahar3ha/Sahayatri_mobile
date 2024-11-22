import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false, 
    fontFamily: 'Montserrat-MediumItalic',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'OpenSans Bold'
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        )
      )
      ),
    );
}
