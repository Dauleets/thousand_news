import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';

class DefaultTheme {
  static final dark = AppTheme(
    id: 'dark',
    data: ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      colorScheme: darkColors,
      textTheme: AppTextStyles.textTheme,
      extensions: const [CustomColors.value],
    ),
    description: 'App dark theme',
  );

  static final light = AppTheme(
    id: 'light',
    data: ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: lightColors,
      textTheme: AppTextStyles.textTheme,
      extensions: const [CustomColors.value],
    ),
    description: 'App light theme',
  );

  static ColorScheme darkColors = const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.black,
    surface: AppColors.darkBackgroundColor,
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.white,
  );

  static ColorScheme lightColors = const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  );
}

