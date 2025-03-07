import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> {
  final TextStyle? largeTitle;
  final TextStyle? mediumTitle;

  const TextStyles({
    this.largeTitle,
    this.mediumTitle,
  });

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? largeTitle,
    TextStyle? mediumTitle,
  }) {
    return TextStyles(
      largeTitle: largeTitle ?? this.largeTitle,
      mediumTitle: mediumTitle ?? this.mediumTitle,
    );
  }

  @override
  ThemeExtension<TextStyles> lerp(ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) {
      return this;
    }
    return TextStyles(
      largeTitle: TextStyle.lerp(largeTitle, other.largeTitle, t),
      mediumTitle: TextStyle.lerp(mediumTitle, other.mediumTitle, t),
    );
  }
}
