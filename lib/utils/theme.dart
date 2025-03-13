import 'package:flutter/material.dart';

// สีหลักของแอป
final Color primaryColor = Color(0xFF5C6BC0); // Indigo สีม่วงอ่อน
final Color secondaryColor = Color(0xFF81C784); // Green สีเขียวอ่อน
final Color backgroundColor = Color(0xFFF5F5F5); // Grey 100
final Color cardColor = Colors.white;
final Color accentColor = Color(0xFFFFB74D); // Orange สีส้มอ่อน

// ธีมหลักของแอป
final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: cardColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    color: cardColor,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: primaryColor),
    ),
  ),
);