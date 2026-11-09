
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.charcoal,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.charcoal,
        ),
        bodyMedium: TextStyle(
          color: AppColors.charcoal,
        ),
        titleLarge: TextStyle(
          color: AppColors.charcoal,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
