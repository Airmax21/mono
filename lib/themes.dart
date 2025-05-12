import 'package:flutter/material.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, foregroundColor: Colors.white),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(
              fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
          bodySmall: TextStyle(fontSize: 14, color: Colors.black87),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.white)));

  static final ThemeData darkTheme = ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Color.fromARGB(225, 55, 87, 202),
      scaffoldBackgroundColor: Color.fromARGB(255, 18, 18, 18),
      shadowColor: Colors.white12,
      canvasColor: Colors.black,
      appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 28, 28, 40),
          foregroundColor: Colors.white70),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 40, color: Colors.white70, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              fontSize: 24, color: Colors.white70, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(
              fontSize: 24, color: Colors.white70, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w300),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w400),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 55, 87, 202),
              foregroundColor: Colors.white70)));
}
