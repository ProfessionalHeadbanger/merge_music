import 'package:merge_music/core/themes/constants/app_colors.dart';
import 'package:merge_music/core/themes/style_extensions/color_style_extension.dart';

class ColorStyles {
  static const lightColorStyle = ColorStyleExtension(
    primaryBackground: LightAppColors.primaryBackground,
    primaryText: LightAppColors.primaryText,
    secondaryText: LightAppColors.secondaryText,
    tertiaryText: LightAppColors.tertiaryText,
    textButton: LightAppColors.textButton,
    selectedNavBarItem: LightAppColors.selectedNavBarItem,
    unselectedNavBarItem: LightAppColors.unselectedNavBarItem,
    selectedNavBarItemBoxColor: LightAppColors.selectedNavBarItemBoxColor,
    customButtonColor: LightAppColors.customButtonColor,
    invertedPrimaryText: LightAppColors.invertedPrimaryText,
  );

  static const darkColorStyle = ColorStyleExtension(
    primaryBackground: DarkAppColors.primaryBackground,
    primaryText: DarkAppColors.primaryText,
    secondaryText: DarkAppColors.secondaryText,
    tertiaryText: DarkAppColors.tertiaryText,
    textButton: DarkAppColors.textButton,
    selectedNavBarItem: DarkAppColors.selectedNavBarItem,
    unselectedNavBarItem: DarkAppColors.unselectedNavBarItem,
    selectedNavBarItemBoxColor: DarkAppColors.selectedNavBarItemBoxColor,
    customButtonColor: DarkAppColors.customButtonColor,
    invertedPrimaryText: DarkAppColors.invertedPrimaryText,
  );
}
