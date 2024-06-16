import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 3, 55, 107);
  static const Color iconColor = Color.fromARGB(255, 3, 55, 107);
  static const Color backgroundColor = Color.fromARGB(255, 3, 55, 107);
  static const Color secondaryColor = Color.fromARGB(255, 255, 193, 7);
  static const Color accentColor = Color.fromARGB(255, 0, 188, 212);
  static const Color textColor = Color.fromARGB(255, 255, 255, 255);
  static const Color darkBackgroundColor = Color.fromARGB(255, 18, 18, 18);
}
class CustomColors extends ThemeExtension<CustomColors> {
  final Color primary;
  final Color secondary;
  final Color background;

  const CustomColors({
    required this.primary,
    required this.secondary,
    required this.background,
  });

  @override
  CustomColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
  }) {
    return CustomColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }

  static const CustomColors value = CustomColors(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    background: AppColors.backgroundColor,
  );
}