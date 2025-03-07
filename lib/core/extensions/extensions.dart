import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merge_music/core/themes/styles/text_styles.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  TextStyles get text => Theme.of(this).extension<TextStyles>()!;
}
