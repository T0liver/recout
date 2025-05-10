import 'package:flutter/material.dart';

class AppColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;
  final Color tertiary;
  final Color cardBackground;
  final Color button;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.tertiary,
    required this.cardBackground,
    required this.button
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
      onPrimary: colors.button,
      secondary: colors.secondary,
      onSecondary: Colors.white,
      tertiary: colors.tertiary,
      error: Colors.red,
      onError: Colors.white,
      surface: colors.background,
      onSurface: colors.text,
      primaryContainer: colors.cardBackground,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: colors.text),
    ),
    dividerColor: colors.secondary
  );
}

extension AppcolorExtension on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get tertiaryColor  => Theme.of(this).colorScheme.tertiary;
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get textColor => Theme.of(this).textTheme.bodyMedium?.color ?? Colors.black;
  Color get cardBackgroundColor  => Theme.of(this).colorScheme.primaryContainer;
  Color get buttonColor  => Theme.of(this).colorScheme.onPrimary;
}