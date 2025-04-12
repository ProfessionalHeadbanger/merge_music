import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/custom_button_with_icon.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class VkMixSliver extends StatelessWidget {
  const VkMixSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: context.color.tertiaryText!),
          ),
          color: context.color.primaryBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.listenVKMix, style: context.text.mediumTitle),
              Text(context.l10n.recsForYou, style: context.text.subtitle),
              const SizedBox(height: 12),
              CustomButtonWithIcon(
                onPressed: () {},
                text: context.l10n.listen,
                icon: Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
