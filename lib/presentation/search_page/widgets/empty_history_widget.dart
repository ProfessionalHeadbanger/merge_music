import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.l10n.queryHistory,
            style: context.text.smallTitle,
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Text(
            context.l10n.noHistory,
            style: context.text.subtitle,
          ),
        )
      ],
    );
  }
}
