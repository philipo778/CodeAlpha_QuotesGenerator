import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF0B1020);
  static const Color primaryColor = Color(0xFF8B5CF6);
  static const Color accentColor = Color(0xFF22D3EE);
  static const Color secondaryTextColor = Color(0xFFA7B0C0);
  static const Color cardColor = Color(0xFF151D33);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: backgroundColor,

      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: cardColor,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),

        bodyLarge: TextStyle(color: Colors.white, fontSize: 18),

        bodyMedium: TextStyle(color: secondaryTextColor, fontSize: 14),
      ),
    );
  }
}
