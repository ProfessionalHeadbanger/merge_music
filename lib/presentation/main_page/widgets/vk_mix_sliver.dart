import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class VkMixSliver extends StatelessWidget {
  const VkMixSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: context.color.primaryBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.listenVKMix, style: context.text.mediumTitle),
              Text(context.l10n.recsForYou, style: context.text.subtitle),
              ElevatedButton(
                onPressed: () {},
                child: Text(context.l10n.listen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
