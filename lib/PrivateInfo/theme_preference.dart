import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemePreference {
  static const String themeKey = "theme_mode";

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(themeKey, mode.toString());
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    String? themeString = prefs.getString(themeKey);
    if (themeString == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    } else if (themeString == ThemeMode.light.toString()) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
