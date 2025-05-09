import 'package:flutter/material.dart';

class AppColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text
  });
}

ThemeData createTheme(AppColors colors, Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.background,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: Colors.white,
      secondary: colors.secondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: colors.background,
      onSurface: colors.text,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: colors.text),
    ),
  );
}