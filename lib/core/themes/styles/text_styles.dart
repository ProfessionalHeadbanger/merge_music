import 'package:flutter/material.dart';
import 'package:merge_music/core/themes/constants/app_colors.dart';
import 'package:merge_music/core/themes/style_extensions/text_style_extension.dart';

class TextStyles {
  static const lightTextStyle = TextStyleExtension(
    largeTitle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: LightAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    mediumTitle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    smallTitle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    subtitle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    customButtonText: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: LightAppColors.invertedPrimaryText,
      fontFamily: 'VK Sans Display',
    ),
    textButton: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: LightAppColors.textButton,
      fontFamily: 'VK Sans Display',
    ),
  );

  static const darkTextStyle = TextStyleExtension(
    largeTitle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: DarkAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    mediumTitle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    smallTitle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    subtitle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: DarkAppColors.primaryText,
      fontFamily: 'VK Sans Display',
    ),
    customButtonText: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: DarkAppColors.invertedPrimaryText,
      fontFamily: 'VK Sans Display',
    ),
    textButton: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.textButton,
      fontFamily: 'VK Sans Display',
    ),
  );
}
