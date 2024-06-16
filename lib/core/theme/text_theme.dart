import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thousand_app/core/theme/colors.dart';

class AppTextStyles {
  static TextStyle _defaultTextStyle({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textColor,
  }) {
    return GoogleFonts.josefinSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static final textTheme = TextTheme(
    displayLarge: _defaultTextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: _defaultTextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: _defaultTextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: _defaultTextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: _defaultTextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: _defaultTextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: _defaultTextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: _defaultTextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: _defaultTextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: _defaultTextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: _defaultTextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}