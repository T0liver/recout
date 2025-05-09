import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recout/themes/dark_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:recout/themes/app_colors.dart';
import 'package:recout/themes/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  static final Map<String, (String, AppColors, Brightness)> themes = {
    'light': ("Világos", LightTheme.lightTheme, Brightness.light),
    'dark': ("Sötét", DarkTheme.theme, Brightness.dark),
  };

  static const _themeKey = 'selected_theme';

  String _currentKey = 'light';
  ThemeData _currentTheme = createTheme(LightTheme.lightTheme, Brightness.light);

  ThemeData get currentTheme => _currentTheme;
  String get currentKey => _currentKey;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedKey = prefs.getString(_themeKey);

    if (savedKey != null && themes.containsKey(savedKey)) {
      final (string, colors, brightness) = themes[savedKey]!;
      _currentTheme = createTheme(colors, brightness);
      _currentKey = savedKey;
      notifyListeners();
    }
  }

  Future<void> setTheme(String key) async {
    final (string, colors, brightness) = themes[key]!;
    _currentTheme = createTheme(colors, brightness);
    _currentKey = key;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, key);
  }
}