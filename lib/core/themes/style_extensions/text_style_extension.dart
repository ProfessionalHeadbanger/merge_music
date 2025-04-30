import 'package:flutter/material.dart';

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  final TextStyle? largeTitle;
  final TextStyle? invertedLargeTitle;
  final TextStyle? mediumTitle;
  final TextStyle? smallTitle;
  final TextStyle? subtitle;
  final TextStyle? trackName;
  final TextStyle? artistName;
  final TextStyle? customButtonText;
  final TextStyle? textButton;

  const TextStyleExtension({
    this.largeTitle,
    this.invertedLargeTitle,
    this.mediumTitle,
    this.smallTitle,
    this.subtitle,
    this.trackName,
    this.artistName,
    this.customButtonText,
    this.textButton,
  });

  @override
  ThemeExtension<TextStyleExtension> copyWith({
    TextStyle? largeTitle,
    TextStyle? invertedLargeTitle,
    TextStyle? mediumTitle,
    TextStyle? smallTitle,
    TextStyle? subtitle,
    TextStyle? trackName,
    TextStyle? artistName,
    TextStyle? customButtonText,
    TextStyle? textButton,
  }) {
    return TextStyleExtension(
      largeTitle: largeTitle ?? this.largeTitle,
      invertedLargeTitle: invertedLargeTitle ?? this.invertedLargeTitle,
      mediumTitle: mediumTitle ?? this.mediumTitle,
      smallTitle: smallTitle ?? this.smallTitle,
      subtitle: subtitle ?? this.subtitle,
      trackName: trackName ?? this.trackName,
      artistName: artistName ?? this.artistName,
      customButtonText: customButtonText ?? this.customButtonText,
      textButton: textButton ?? this.textButton,
    );
  }

  @override
  ThemeExtension<TextStyleExtension> lerp(
      ThemeExtension<TextStyleExtension>? other, double t) {
    if (other is! TextStyleExtension) {
      return this;
    }
    return TextStyleExtension(
      largeTitle: TextStyle.lerp(largeTitle, other.largeTitle, t),
      invertedLargeTitle:
          TextStyle.lerp(invertedLargeTitle, other.invertedLargeTitle, t),
      mediumTitle: TextStyle.lerp(mediumTitle, other.mediumTitle, t),
      smallTitle: TextStyle.lerp(smallTitle, other.smallTitle, t),
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t),
      trackName: TextStyle.lerp(trackName, other.trackName, t),
      artistName: TextStyle.lerp(artistName, other.artistName, t),
      customButtonText:
          TextStyle.lerp(customButtonText, other.customButtonText, t),
      textButton: TextStyle.lerp(textButton, other.textButton, t),
    );
  }
}
