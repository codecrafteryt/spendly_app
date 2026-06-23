import 'package:flutter/material.dart';

/// Centralized color palette — no hardcoded colors in widgets.
class AppColors {
  AppColors._();

  static const accent = Color(0xFF1B7F5C);
  static const accentLight = Color(0xFF2DA87A);
  static const accentDark = Color(0xFF145C42);

  static const lightBackground = Color(0xFFF8FAF9);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF1A1F1C);
  static const lightTextSecondary = Color(0xFF6B7A72);
  static const lightBorder = Color(0xFFE2E8E5);
  static const lightShadow = Color(0x1A1B7F5C);

  static const darkBackground = Color(0xFF0F1412);
  static const darkSurface = Color(0xFF1A211E);
  static const darkTextPrimary = Color(0xFFF0F4F2);
  static const darkTextSecondary = Color(0xFF9BAAA2);
  static const darkBorder = Color(0xFF2D3833);
  static const darkShadow = Color(0x331B7F5C);

  static const error = Color(0xFFE53935);
  static const success = Color(0xFF43A047);
  static const warning = Color(0xFFFFA726);
  static const lockedOverlay = Color(0x99000000);
}
