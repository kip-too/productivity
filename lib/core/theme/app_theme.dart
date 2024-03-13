import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    fontFamily: 'Kalam',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    fontFamily: 'Kalam',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Adjust text color for dark theme
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.white70, // Adjust text color for dark theme
      ),
    ),
  );

  // Function to get the current theme based on the isDarkMode boolean
  static ThemeData getCurrentTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}

