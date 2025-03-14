import 'package:flutter/material.dart';
import 'package:merge_music/core/themes/constants/app_colors.dart';
import 'package:merge_music/core/themes/styles/color_styles.dart';
import 'package:merge_music/core/themes/styles/text_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: ColorStyles.lightColorStyle.primaryBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorStyles.lightColorStyle.primaryBackground,
      titleTextStyle: TextStyles.lightTextStyle.largeTitle,
    ),
    extensions: [
      TextStyles.lightTextStyle,
      ColorStyles.lightColorStyle,
    ],
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: DarkAppColors.primaryBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorStyles.darkColorStyle.primaryBackground,
      titleTextStyle: TextStyles.darkTextStyle.largeTitle,
    ),
    extensions: [
      TextStyles.darkTextStyle,
      ColorStyles.darkColorStyle,
    ],
  );
}
