import 'package:flutter/material.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFFE8EBF5),
    scaffoldBackgroundColor: const Color(0xFFF5F7FB),
    shadowColor: const Color(0xFFE2E6F0),
    canvasColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F7FB),
      surfaceTintColor: Color(0xFFF5F7FB),
      foregroundColor: Color(0xFF1E2235),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF1E2235),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E2235)),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E2235)),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E2235)),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF1E2235)),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF4A4D5C)),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF4A4D5C)),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E2235)),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF4A4D5C)),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4A4D5C)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3757CA),
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF3757CA),
      foregroundColor: Colors.white,
      hoverColor: const Color(0xFF6591F7),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Color(0xFF3757CA), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      labelStyle: TextStyle(
        color: Colors.black54,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: Colors.black38,
        fontSize: 13,
      ),
      errorStyle: TextStyle(
        color: Colors.redAccent,
        fontSize: 12,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1C1F30),
    scaffoldBackgroundColor: const Color(0xFF121421),
    shadowColor: const Color(0xFF262B45),
    canvasColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121421),
      surfaceTintColor: Color(0xFF121421),
      foregroundColor: Colors.white70,
      elevation: 1,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: Colors.white70),
      displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.white70),
      displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.white70),
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.white70),
      headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.white70),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: Colors.white70),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: Colors.white70),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.15,
          color: Colors.white70),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.1,
          color: Colors.white70),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
          color: Colors.white70),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: Colors.white70),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: Colors.white70),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: Colors.white70),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: Colors.white70),
      labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 55, 87, 202),
        foregroundColor: Colors.white70,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF3757CA),
      foregroundColor: Colors.white70,
      hoverColor: const Color(0xFF6591F7),
      focusColor: const Color(0xFF6591F7).withValues(alpha: 0.9),
      splashColor: Colors.white70.withValues(alpha: 0.1),
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide:
            BorderSide(color: Color.fromARGB(255, 55, 87, 202), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
      labelStyle: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: Colors.white38,
        fontSize: 13,
      ),
      errorStyle: TextStyle(
        color: Colors.redAccent,
        fontSize: 12,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    ), 
    dialogTheme: const DialogThemeData(
      backgroundColor: Color(0xFF1C1F30),
    ),
  );
}
