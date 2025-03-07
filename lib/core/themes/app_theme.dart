import 'package:flutter/material.dart';
import 'package:merge_music/core/themes/constants/app_colors.dart';
import 'package:merge_music/core/themes/styles/color_styles.dart';
import 'package:merge_music/core/themes/styles/text_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: LightAppColors.primaryBackground,
    extensions: [
      TextStyles(
        largeTitle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: LightAppColors.primaryText,
          fontFamily: 'VK Sans Display',
        ),
        mediumTitle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: LightAppColors.primaryText,
          fontFamily: 'VK Sans Display',
        ),
      ),
      const LightColorStyles(
        primaryBackground: LightAppColors.primaryBackground,
      ),
    ],
  );
}
