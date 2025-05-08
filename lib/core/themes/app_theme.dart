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
      scrolledUnderElevation: 0,
    ),
    sliderTheme: SliderThemeData(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      thumbColor: ColorStyles.lightColorStyle.primaryText,
      overlayColor: ColorStyles.lightColorStyle.primaryText!.withOpacity(0.2),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
      activeTrackColor: ColorStyles.lightColorStyle.primaryText,
      inactiveTrackColor:
          ColorStyles.lightColorStyle.primaryText!.withOpacity(0.2),
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
      scrolledUnderElevation: 0,
    ),
    sliderTheme: SliderThemeData(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      thumbColor: ColorStyles.darkColorStyle.primaryText,
      overlayColor: ColorStyles.darkColorStyle.primaryText!.withOpacity(0.2),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
      activeTrackColor: ColorStyles.darkColorStyle.primaryText,
      inactiveTrackColor:
          ColorStyles.darkColorStyle.primaryText!.withOpacity(0.2),
    ),
    extensions: [
      TextStyles.darkTextStyle,
      ColorStyles.darkColorStyle,
    ],
  );
}
