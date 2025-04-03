import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';

Future<void> logoutDialogBuilder(
    BuildContext context, VoidCallback? onCancel, VoidCallback? onExit) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: context.color.primaryBackground,
        title: Text(
          context.l10n.logout,
          style: context.text.mediumTitle,
        ),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: Text(
              context.l10n.cancel,
              style: context.text.textButton?.copyWith(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: onExit,
            child: Text(
              context.l10n.exit,
              style: context.text.textButton?.copyWith(fontSize: 16),
            ),
          ),
        ],
      );
    },
  );
}
