import 'package:flutter/material.dart';

class LightColorStyles extends ThemeExtension<LightColorStyles> {
  final Color? primaryBackground;
  final Color? primaryText;
  final Color? secondaryBackground;

  const LightColorStyles({
    this.primaryBackground,
    this.primaryText,
    this.secondaryBackground,
  });

  @override
  ThemeExtension<LightColorStyles> copyWith({
    Color? primaryBackground,
    Color? primaryText,
    Color? secondaryBackground,
  }) {
    return LightColorStyles(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryText: primaryText ?? this.primaryText,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
    );
  }

  @override
  ThemeExtension<LightColorStyles> lerp(
      ThemeExtension<LightColorStyles>? other, double t) {
    if (other is! LightColorStyles) {
      return this;
    }
    return LightColorStyles(
      primaryBackground:
          Color.lerp(primaryBackground, other.primaryBackground, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      secondaryBackground:
          Color.lerp(secondaryBackground, other.secondaryBackground, t),
    );
  }
}
