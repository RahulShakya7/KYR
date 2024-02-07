import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme() {
    return ThemeData(
      // colorScheme: const ColorScheme.dark(
      //   primary: Colors.black,
      // ),
      fontFamily: 'Poppins',
      useMaterial3: true,
    );
  }
}
