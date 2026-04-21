import 'package:flutter/material.dart';

class AppColors {
  // Primary palette
  static const Color primary = Color(0xFFD4477C);
  static const Color primaryDark = Color(0xFFAA2E5E);
  static const Color primaryLight = Color(0xFFFFB6C1);
  static const Color primarySoft = Color(0xFFFFF0F5);

  // Background
  static const Color background = Color(0xFFFFF5F8);
  static const Color surface = Colors.white;

  // Text
  static const Color textDark = Color(0xFF2D1B25);
  static const Color textMedium = Color(0xFF7A4F60);
  static const Color textLight = Color(0xFFB0879A);

  // Gold accent
  static const Color gold = Color(0xFFD4A843);
  static const Color goldLight = Color(0xFFFFF3D6);

  // Utility
  static const Color divider = Color(0xFFFFE0EC);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);

  // Category colors
  static const Color lipstickColor = Color(0xFFE53935);
  static const Color powderColor = Color(0xFFFF8F00);
  static const Color brushColor = Color(0xFF8E24AA);
  static const Color nailColor = Color(0xFFD4477C);
  static const Color eyeshadowColor = Color(0xFF1E88E5);
  static const Color blushColor = Color(0xFFEC407A);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFD4477C), Color(0xFFFF6B9D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bannerGradient = LinearGradient(
    colors: [Color(0xFF8B1A4A), Color(0xFFD4477C), Color(0xFFFF6B9D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}