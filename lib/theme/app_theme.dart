import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBackground = Color(0xFFFFD700); // Bright Yellow
  static const Color actionColor = Color(0xFFADFF2F); // Neon Green
  static const Color alertColor = Color(0xFFFF6B6B); // Coral Red
  static const Color black = Colors.black;

  static const double borderWidth = 3.0;
  static const Offset shadowOffset = Offset(4, 4);

  static BoxDecoration neoBrutalDecoration({
    Color color = Colors.white,
    double radius = 0,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: black, width: borderWidth),
      borderRadius: BorderRadius.circular(radius),
      boxShadow: const [
        BoxShadow(
          color: black,
          offset: shadowOffset,
          blurRadius: 0,
        ),
      ],
    );
  }

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryBackground,
      scaffoldBackgroundColor: primaryBackground,
      fontFamily: 'Roboto', // Defaulting to Roboto but with w900 for headings
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.w900,
          fontSize: 32,
        ),
        headlineMedium: TextStyle(
          color: black,
          fontWeight: FontWeight.w900,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: black),
        titleTextStyle: TextStyle(
          color: black,
          fontWeight: FontWeight.w900,
          fontSize: 24,
        ),
      ),
    );
  }
}
