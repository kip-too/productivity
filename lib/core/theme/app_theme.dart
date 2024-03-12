import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    fontFamily: 'Kalam', // Set font family to Kalam
    // Define your light theme properties here
    // Example: textTheme, etc.
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    fontFamily: 'Kalam', // Set font family to Kalam
    // Define your dark theme properties here
    // Example: textTheme, etc.
  );

  // Function to get the current theme based on the isDarkMode boolean
  static ThemeData getCurrentTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}

