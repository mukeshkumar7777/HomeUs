import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Colors.black;
  static const Color amber = Colors.amber;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: amber,
      colorScheme: ColorScheme.fromSeed(
        seedColor: amber,
        primary: amber,
        secondary: black,
        surface: white,
        onSurface: Colors.black87,
      ),
      scaffoldBackgroundColor: white,
      appBarTheme: const AppBarTheme(
        backgroundColor: amber,
        foregroundColor: black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: black,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: black, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: amber,
          foregroundColor: black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      // Using default ChipTheme to ensure compatibility across Flutter versions.
      cardTheme: CardThemeData(
        color: white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}



