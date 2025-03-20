import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioListSliver extends StatelessWidget {
  final List<AudioEntity> audios;

  const AudioListSliver({super.key, required this.audios});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(context.l10n.myTracks,
                      style: context.text.mediumTitle)),
              TextButton(
                onPressed: () {},
                child: Text(
                  context.l10n.showAll,
                  style: context.text.textButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
