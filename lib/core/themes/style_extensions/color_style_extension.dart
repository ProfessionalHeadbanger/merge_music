import 'package:flutter/material.dart';

class ColorStyleExtension extends ThemeExtension<ColorStyleExtension> {
  final Color? primaryBackground;
  final Color? secondaryBackground;

  final Color? primaryText;
  final Color? secondaryText;
  final Color? tertiaryText;
  final Color? auxiliaryText;
  final Color? textButton;

  final Color? selectedNavBarItem;
  final Color? unselectedNavBarItem;
  final Color? selectedNavBarItemBoxColor;

  final Color? customButtonColor;
  final Color? invertedPrimaryText;

  const ColorStyleExtension({
    this.primaryBackground,
    this.secondaryBackground,
    this.primaryText,
    this.secondaryText,
    this.tertiaryText,
    this.auxiliaryText,
    this.textButton,
    this.selectedNavBarItem,
    this.unselectedNavBarItem,
    this.selectedNavBarItemBoxColor,
    this.customButtonColor,
    this.invertedPrimaryText,
  });

  @override
  ThemeExtension<ColorStyleExtension> copyWith({
    Color? primaryBackground,
    Color? secondaryBackground,
    Color? primaryText,
    Color? secondaryText,
    Color? tertiaryText,
    Color? auxiliaryText,
    Color? textButton,
    Color? selectedNavBarItem,
    Color? unselectedNavBarItem,
    Color? selectedNavBarItemBoxColor,
    Color? customButtonColor,
    Color? invertedPrimaryText,
  }) {
    return ColorStyleExtension(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      tertiaryText: tertiaryText ?? this.tertiaryText,
      auxiliaryText: auxiliaryText ?? this.auxiliaryText,
      textButton: textButton ?? this.textButton,
      selectedNavBarItem: selectedNavBarItem ?? this.selectedNavBarItem,
      unselectedNavBarItem: unselectedNavBarItem ?? this.unselectedNavBarItem,
      selectedNavBarItemBoxColor:
          selectedNavBarItemBoxColor ?? this.selectedNavBarItemBoxColor,
      customButtonColor: customButtonColor ?? this.customButtonColor,
      invertedPrimaryText: invertedPrimaryText ?? this.invertedPrimaryText,
    );
  }

  @override
  ThemeExtension<ColorStyleExtension> lerp(
      ThemeExtension<ColorStyleExtension>? other, double t) {
    if (other is! ColorStyleExtension) {
      return this;
    }
    return ColorStyleExtension(
      primaryBackground:
          Color.lerp(primaryBackground, other.primaryBackground, t),
      secondaryBackground:
          Color.lerp(secondaryBackground, other.secondaryBackground, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
      tertiaryText: Color.lerp(tertiaryText, other.tertiaryText, t),
      auxiliaryText: Color.lerp(auxiliaryText, other.auxiliaryText, t),
      textButton: Color.lerp(textButton, other.textButton, t),
      selectedNavBarItem:
          Color.lerp(selectedNavBarItem, other.selectedNavBarItem, t),
      unselectedNavBarItem:
          Color.lerp(unselectedNavBarItem, other.unselectedNavBarItem, t),
      selectedNavBarItemBoxColor: Color.lerp(
          selectedNavBarItemBoxColor, other.selectedNavBarItemBoxColor, t),
      customButtonColor:
          Color.lerp(customButtonColor, other.customButtonColor, t),
      invertedPrimaryText:
          Color.lerp(invertedPrimaryText, other.invertedPrimaryText, t),
    );
  }
}
