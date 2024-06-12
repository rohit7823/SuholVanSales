import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const background = Color(0xFFF5F5F5);
  static const primary = Color(0xFFF4FAFF);
  static const secondary = Color(0xFFFCD561);

  static const bottomMenuLabelColor = Color(0xFF7047C4);

  static const mainColorScheme = ColorScheme.light(
      primary: primary,
      onPrimary: background,
      secondary: secondary,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: background,
      onSurface: Colors.white);
}
