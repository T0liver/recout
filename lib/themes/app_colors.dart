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

extension AppcolorExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get textColor => Theme.of(this).textTheme.bodyMedium?.color ?? Colors.black;
}