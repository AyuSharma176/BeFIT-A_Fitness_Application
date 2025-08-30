import 'dart:ui';

import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  var notificationsEnabled = true.obs;

  VoidCallback? onThemeChanged;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    onThemeChanged?.call();
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }
}
