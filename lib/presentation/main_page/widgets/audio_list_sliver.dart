import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/audio_tile.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioListSliver extends StatelessWidget {
  final List<AudioEntity> audios;

  const AudioListSliver({super.key, required this.audios});

  @override
  Widget build(BuildContext context) {
    final List<List<AudioEntity>> groupedAudios = [];
    for (int i = 0; i < audios.length; i += 3) {
      groupedAudios.add(audios.sublist(i, (i + 3).clamp(0, audios.length)));
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(context.l10n.myTracks,
                    style: context.text.mediumTitle),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  context.l10n.showAll,
                  style: context.text.textButton,
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConstants.audioListSliverHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupedAudios.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Column(
                    children: groupedAudios[index]
                        .map((audio) => AudioTile(audio: audio))
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
