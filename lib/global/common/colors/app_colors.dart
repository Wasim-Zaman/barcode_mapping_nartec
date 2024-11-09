import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF4B0082); // Deep Purple for logo
  static const Color secondary = Color(0xFF008B75); // Teal green for button

  // Background Colors
  static const Color background = Color(0xFFE8F5F5); // Light mint background
  static const Color scaffoldBackground =
      Color(0xFFE8F5F5); // Same as background
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color fields = Color(0xFFE0F7F7); // Light cyan for text fields

  // Input Field Colors
  static const Color inputBackground =
      Color(0xFFE0F7F7); // Light cyan for inputs
  static const Color inputBorder =
      Color(0xFFB8E8E8); // Slightly darker cyan for borders
  static const Color inputText = Color(0xFF333333); // Dark gray for input text
  static const Color inputHint = Color(0xFF757575); // Medium gray for hints

  // Button Colors
  static const Color buttonPrimary =
      Color(0xFF008B75); // Teal green for main button
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFFCCCCCC);

  // Text Colors
  static const Color textPrimary =
      Color(0xFF333333); // Dark gray for primary text
  static const Color textSecondary =
      Color(0xFF757575); // Medium gray for secondary text
  static const Color textLight = Color(0xFFAAAAAA);

  // Status Colors
  static const Color success = Color(0xFF228B22);
  static const Color danger = Color(0xFFFF0000);
  static const Color warning = Color(0xFFFFA500);
  static const Color info = Color(0xFF0088CC);

  // Accent Colors
  static const Color skyBlue = Color(0xFF0FB5DA);
  static const Color pink = Color(0xFFE02266);
  static const Color green = Color(0xFF1DAE11);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF757575);

  // Transparent Colors
  static const Color transparent = Colors.transparent;
  static const Color transparentColor = Color(0x80000000);
  static const Color shadow = Color(0x1A000000);

  // Border Colors
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color dividerColor = Color(0xFFEEEEEE);

  // Checkbox Colors
  static const Color checkboxActive =
      Color(0xFF008B75); // Teal green for checkbox
  static const Color checkboxBorder =
      Color(0xFFB8E8E8); // Light cyan for checkbox border
}
