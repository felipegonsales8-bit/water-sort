import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg, // Deep Off-Black (#121212)
    fontFamily: 'BebasNeue', // Set default fallback font family globally
    colorScheme: ColorScheme.dark(
      primary: AppColors.accent,
      secondary: const Color(0xFF7A5AA6),
      surface: AppColors.darkSurface,
      onSurface: AppColors.headingWhite,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.accent.withValues(alpha: 0.28)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'BebasNeue',
        fontSize: 26,
        fontWeight: FontWeight.w900,
        color: AppColors.headingWhite, // Solid White (#FFFFFF)
        letterSpacing: 1.0,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.gridLines, // Faint Charcoal (#222222)
      thickness: 1,
    ),
    textTheme: TextTheme(
      // All headings in all caps, high-impact condensed sans-serif (Bebas Neue)
      displayLarge: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: 0.5,
      ),
      titleMedium: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        letterSpacing: 0.5,
      ),
      // Body Text & Buttons using BebasNeue
      bodyLarge: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.subtext, // Muted Gray (#808080)
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'BebasNeue',
        color: AppColors.headingWhite,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData get light =>
      dark; // No light theme - same game aesthetic universally
}
