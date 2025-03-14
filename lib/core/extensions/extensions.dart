import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merge_music/core/themes/style_extensions/color_style_extension.dart';
import 'package:merge_music/core/themes/style_extensions/text_style_extension.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  TextStyleExtension get text =>
      Theme.of(this).extension<TextStyleExtension>()!;

  ColorStyleExtension get color =>
      Theme.of(this).extension<ColorStyleExtension>()!;
}
