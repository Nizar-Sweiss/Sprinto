import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4C5BD4)),
    scaffoldBackgroundColor: const Color(0xFFEFF2F9),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontFamily: 'Roboto'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C5BD4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        foregroundColor: Colors.white, // This sets the text color inside buttons
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

  );

}
EdgeInsets kPadding([double horizontal = 0, double vertical = 0]) =>
    EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
  SizedBox get phw => SizedBox(height: toDouble(), width: toDouble());
}


const kButtonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: l1Black,
);