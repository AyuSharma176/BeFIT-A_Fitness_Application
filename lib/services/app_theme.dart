import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  // static const Color primaryColor = Color(0xFF8EB69B); // Muted Mint
  // static const Color backgroundColor = Color(0xFFDAF1DE); // Pale Sage
  // static const Color appBarBg = Color(0xFF051F20); // Deep Forest Green
  // static const Color drawerHeaderBg = Color(0xFF082B26); // Dark Emerald
  // static const Color drawerIconColor = Color(0xFF163832); // Jungle Green
  // static const Color logoutColor = Color(0xFF253547); // Deep Teal
  // static const Color titleTextColor = Colors.white;

  // static const Color primaryColor = Color(0xFF586D75); // Muted Mint
  // static const Color backgroundColor = Color(0xFF8A9BA2); // Pale Sage
  // static const Color appBarBg = Color(0xFF273E47);
  // static const Color drawerHeaderBg = Color(0xFFBCC8CD); // Dark Emerald
  // static const Color drawerIconColor = Color(0xFFDFE5E7); // Jungle Green
  // static const Color logoutColor = Color(0xFFF2F5F6); // Deep Teal
  // static const Color titleTextColor = Colors.white;
  //
  static const Color primaryColor = Color(0xFF333333); // Muted Mint
  static const Color backgroundColor = Color(0xFFAAAAAA); // Pale Sage
  static const Color appBarBg = Color(0xFF000000);
  static const Color drawerHeaderBg = Color(0xFF555555); // Dark Emerald
  static const Color drawerIconColor = Color(0xFF777777); // Jungle Green
  static const Color logoutColor = Color(0xFF999999); // Deep Teal
  static const Color titleTextColor = Colors.white;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Segoe UI',
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        background: backgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF051F20),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
