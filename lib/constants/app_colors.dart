import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF090D16);
  static const Color backgroundSecondary = Color(0xFF0F172A);
  static const Color cardGlass = Color(0xCC111827);
  static const Color cardGlassBorder = Color(0x26FFFFFF);

  static const Color primary = Color(0xFF6366F1); // Electric Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color emerald = Color(0xFF10B981);
  static const Color rose = Color(0xFFF43F5E);
  static const Color amber = Color(0xFFF59E0B);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGlow = LinearGradient(
    colors: [Color(0x336366F1), Color(0x1A06B6D4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
