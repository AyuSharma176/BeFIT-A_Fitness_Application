import 'package:flutter/material.dart';

class ColorUtils {
  static Color lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightened = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightened.toColor();
  }
  static Color darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final darkened = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkened.toColor();
  }
  static Color desaturate(Color color, [double amount = 0.2]) {
    final hsl = HSLColor.fromColor(color);
    final desaturated = hsl.withSaturation((hsl.saturation - amount).clamp(0.0, 1.0));
    return desaturated.toColor();
  }
  static bool isDark(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
  }
}
