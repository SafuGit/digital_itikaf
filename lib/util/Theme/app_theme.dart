import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF11D442);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF0A110C);
  static const Color textLight = Colors.black87;
  static const Color textDark = Colors.white;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    fontFamily: GoogleFonts.lexend().fontFamily,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.lexend(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      headlineMedium: GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
      headlineSmall: GoogleFonts.lexend(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textLight,
      ),
      bodyLarge: GoogleFonts.lexend(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textLight,
      ),
      bodyMedium: GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: textLight,
      ),
      bodySmall: GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Colors.grey[600],
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: textLight,
      elevation: 0,
      iconTheme: const IconThemeData(color: primary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white70,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark,
    fontFamily: GoogleFonts.lexend().fontFamily,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.lexend(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineSmall: GoogleFonts.lexend(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.lexend(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textDark,
      ),
      bodyMedium: GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: textDark,
      ),
      bodySmall: GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Colors.grey[400],
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: textDark,
      elevation: 0,
      iconTheme: const IconThemeData(color: primary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1A1A1A),
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF121212),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: GoogleFonts.lexend(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}
