import 'package:flutter/material.dart';

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  final TextStyle? largeTitle;
  final TextStyle? mediumTitle;
  final TextStyle? smallTitle;
  final TextStyle? subtitle;
  final TextStyle? trackName;
  final TextStyle? artistName;

  const TextStyleExtension({
    this.largeTitle,
    this.mediumTitle,
    this.smallTitle,
    this.subtitle,
    this.trackName,
    this.artistName,
  });

  @override
  ThemeExtension<TextStyleExtension> copyWith({
    TextStyle? largeTitle,
    TextStyle? mediumTitle,
    TextStyle? smallTitle,
    TextStyle? subtitle,
    TextStyle? trackName,
    TextStyle? artistName,
  }) {
    return TextStyleExtension(
      largeTitle: largeTitle ?? this.largeTitle,
      mediumTitle: mediumTitle ?? this.mediumTitle,
      smallTitle: smallTitle ?? this.smallTitle,
      subtitle: subtitle ?? this.subtitle,
      trackName: trackName ?? this.trackName,
      artistName: artistName ?? this.artistName,
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
      mediumTitle: TextStyle.lerp(mediumTitle, other.mediumTitle, t),
      smallTitle: TextStyle.lerp(smallTitle, other.smallTitle, t),
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t),
      trackName: TextStyle.lerp(trackName, other.trackName, t),
      artistName: TextStyle.lerp(artistName, other.artistName, t),
    );
  }
}
