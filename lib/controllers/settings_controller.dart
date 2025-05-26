import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key for SharedPreferences
const String _themePrefKey = 'appThemeMode';

class SettingsController extends GetxController {
  // Default to system theme
  final Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  ThemeMode get theme => currentTheme.value;

  Future<void> changeTheme(ThemeMode newThemeMode) async {
    if (currentTheme.value == newThemeMode) return; // No change

    currentTheme.value = newThemeMode;
    Get.changeThemeMode(
        newThemeMode); // Directly tell GetX to change theme mode

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePrefKey, newThemeMode.toString());
    Get.snackbar('Theme Changed', 'Theme updated to ${newThemeMode.name}',
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final String? themeString = prefs.getString(_themePrefKey);

    if (themeString != null) {
      if (themeString == ThemeMode.light.toString()) {
        currentTheme.value = ThemeMode.light;
      } else if (themeString == ThemeMode.dark.toString()) {
        currentTheme.value = ThemeMode.dark;
      } else {
        currentTheme.value =
            ThemeMode.system; // Default if stored value is unrecognized
      }
    } else {
      // If no preference is stored, use the initial value (ThemeMode.system)
    }
    // Apply the loaded theme to GetX state as well
    // This is important if the app starts and directly uses the theme controller
    Get.changeThemeMode(currentTheme.value);
  }

  // Helper to get a display string for ThemeMode
  String getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
      default:
        return 'System Default';
    }
  }
}
