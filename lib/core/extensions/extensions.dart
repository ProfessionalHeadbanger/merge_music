import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merge_music/core/themes/style_extensions/color_style_extension.dart';
import 'package:merge_music/core/themes/style_extensions/text_style_extension.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  TextStyleExtension get text =>
      Theme.of(this).extension<TextStyleExtension>()!;

  ColorStyleExtension get color =>
      Theme.of(this).extension<ColorStyleExtension>()!;
}

extension AudioEntityMapper on AudioEntity {
  MediaItem toMediaItem() {
    return MediaItem(
      id: url,
      title: title,
      artist: artist,
      duration: Duration(seconds: duration),
    );
  }
}
