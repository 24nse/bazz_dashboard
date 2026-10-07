import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF3525CD),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFF4F46E5),
        onPrimaryContainer: Color(0xFFDAD7FF),
        secondary: Color(0xFF855300),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFFEA619),
        onSecondaryContainer: Color(0xFF684000),
        tertiary: Color(0xFF960014),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFBC1D25),
        onTertiaryContainer: Color(0xFFFFD0CC),
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF93000A),
        surface: Color(0xFFFAF8FF),
        onSurface: Color(0xFF131B2E),
        surfaceContainerHighest: Color(0xFFDAE2FD),
        onSurfaceVariant: Color(0xFF464555),
        outline: Color(0xFF777587),
        outlineVariant: Color(0xFFC7C4D8),
        shadow: Color(0xFF0F172A),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFF283044),
        onInverseSurface: Color(0xFFEEF0FF),
        inversePrimary: Color(0xFFC3C0FF),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 32, fontWeight: FontWeight.w800, height: 1.25, color: Color(0xFF131B2E)),
        displayMedium: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 26, fontWeight: FontWeight.w700, height: 1.3, color: Color(0xFF131B2E)),
        displaySmall: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 20, fontWeight: FontWeight.w700, height: 1.4, color: Color(0xFF131B2E)),
        headlineMedium: TextStyle(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.w600, height: 1.33, color: Color(0xFF131B2E)),
        bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, color: Color(0xFF464555)),
        bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400, height: 1.42, color: Color(0xFF464555)),
        bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w400, height: 1.33, color: Color(0xFF464555)),
        labelLarge: TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.w600, height: 1.33, color: Color(0xFF464555)),
        labelMedium: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600, height: 1.38, color: Color(0xFF464555)),
        labelSmall: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w600, height: 1.27, color: Color(0xFF464555)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: const Color(0xFFFFFFFF),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
          textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 1,
        shadowColor: const Color(0xFF0F172A).withOpacity(0.06),
      ),
    );
  }
}
