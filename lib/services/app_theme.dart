import 'package:flutter/material.dart';
import 'color_utils.dart';
//
// class AppTheme {
//   // Color Palette
//   // static Color primaryColor = Color(0xFF8EB69B); // Muted Mint
//   // static Color backgroundColor = Color(0xFFDAF1DE); // Pale Sage
//   // static Color appBarBg = Color(0xFF051F20); // Deep Forest Green
//   // static Color drawerHeaderBg = Color(0xFF082B26); // Dark Emerald
//   // static Color drawerIconColor = Color(0xFF163832); // Jungle Green
//   // static Color logoutColor = Color(0xFF253547); // Deep Teal
//   // static Color titleTextColor = Colors.white;
//
//   // static Color primaryColor = Color(0xFFB3A3D9); // Muted Lilac
//   // static Color backgroundColor = Color(0xFFEAEAF2); // Pale Lavender
//   // static Color appBarBg = Color(0xFF2C2A3B); // Deep Plum
//   // static Color drawerHeaderBg = Color(0xFF403A59); // Dark Indigo
//   // static Color drawerIconColor = Color(0xFF6A5F8B); // Medium Slate Blue
//   // static Color logoutColor = Color(0xFF4D4C6B); // Dark Slate Blue
//   // static Color titleTextColor = Colors.white;
//
//   // static Color primaryColor = Color(0xFF586D75); // Muted Mint
//   // static Color backgroundColor = Color(0xFF8A9BA2); // Pale Sage
//   // static Color appBarBg = Color(0xFF273E47);
//   // static Color drawerHeaderBg = Color(0xFFBCC8CD); // Dark Emerald
//   // static Color drawerIconColor = Color(0xFFDFE5E7); // Jungle Green
//   // static Color logoutColor = Color(0xFFF2F5F6); // Deep Teal
//   // static Color titleTextColor = Colors.white;
//
//   static Color primaryColor = Color(0xFFE4B9BF); // Muted Blush
//   static Color backgroundColor = Color(0xFFF9EDEF); // Pale Rose
//   static Color appBarBg = Color(0xFFB76E79); // Dusty Mauve
//   static Color drawerHeaderBg = Color(0xFFC38790); // Rosewood
//   static Color drawerIconColor = Color(0xFF8A545D); // Deep Mauve
//   static Color logoutColor = Color(0xFF8A545D); // Deep Mauve
//   static Color titleTextColor = Colors.white;
//
//   // static Color primaryColor = Color(0xFF333333); // Muted Mint
//   // static Color backgroundColor = Color(0xFFAAAAAA); // Pale Sage
//   // static Color appBarBg = Color(0xFF000000);
//   // static Color drawerHeaderBg = Color(0xFF555555); // Dark Emerald
//   // static Color drawerIconColor = Color(0xFF777777); // Jungle Green
//   // static Color logoutColor = Color(0xFF999999); // Deep Teal
//   // static Color titleTextColor = Colors.white;
//   static Color textColor = Colors.white;
//   static Color textShadowColor = Colors.white;
//
//   static ThemeData get theme {
//     return ThemeData(
//       useMaterial3: true,
//       fontFamily: 'Segoe UI',
//       scaffoldBackgroundColor: backgroundColor,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: primaryColor,
//         primary: primaryColor,
//         background: backgroundColor,
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: appBarBg,
//         elevation: 0,
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.w800,
//           letterSpacing: 2,
//           color: Colors.white,
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       drawerTheme: const DrawerThemeData(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: Color(0xFF051F20),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         elevation: 0,
//       ),
//       textTheme: const TextTheme(
//         titleLarge: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//         ),
//         labelSmall: TextStyle(
//           fontSize: 12,
//           color: Colors.grey,
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryColor,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         hintStyle: TextStyle(
//           color: Colors.grey.shade500,
//         ),
//       ),
//     );
//   }
// }

class AppTheme {
  static late Color primaryColor;
  static late Color backgroundColor;
  static late Color appBarBg;
  static late Color drawerHeaderBg;
  static late Color drawerIconColor;
  static late Color logoutColor;
  static late Color titleTextColor;
  static late Color textColor;
  static late Color textShadowColor;
  static late Color iconColor;
  static late Color boxColor;

  static void setCustomColor(Color userColor) {
    appBarBg = userColor;
    primaryColor = ColorUtils.lighten(userColor, 0.15);
    backgroundColor = ColorUtils.lighten(userColor, 0.4);
    drawerHeaderBg = ColorUtils.darken(userColor, 0.1);
    drawerIconColor = ColorUtils.desaturate(userColor, 0.3);
    logoutColor = drawerIconColor;
    boxColor = Colors.black;
    textColor =
        textShadowColor =
        iconColor =
        titleTextColor = ColorUtils.isDark(userColor) ? Colors.white : Colors.black;

  }
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
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
          color: titleTextColor,
        ),
        iconTheme: IconThemeData(color: titleTextColor),
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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appBarBg,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
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
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        labelSmall: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500),
      ),
    );
  }
}
