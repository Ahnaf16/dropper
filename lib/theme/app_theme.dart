import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const primary = Colors.indigo;
  static const error = Color.fromARGB(255, 246, 58, 83);
  static const success = Color.fromARGB(255, 51, 250, 124);
  static const waring = Color.fromARGB(255, 255, 216, 43);

  static ThemeData theme(bool isLight) => _mainTheme(isLight).copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      );

  static ThemeData _mainTheme(bool isLight) => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: isLight ? Brightness.light : Brightness.dark,
          error: error,
          errorContainer: success,
        ),
        useMaterial3: true,
      );
}
