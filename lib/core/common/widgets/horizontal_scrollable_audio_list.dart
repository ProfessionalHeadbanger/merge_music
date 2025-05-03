import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:merge_music/core/common/global_state/audio_handler/audio_handler.dart';
import 'package:merge_music/core/common/widgets/audio_tile.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/service_locator.dart';

class HorizontalScrollableAudioList extends StatelessWidget {
  final List<AudioEntity> audios;
  final String title;
  final VoidCallback? onShowAllPressed;

  const HorizontalScrollableAudioList({
    super.key,
    required this.audios,
    required this.title,
    this.onShowAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (audios.isEmpty) return const SliverToBoxAdapter();

    if (audios.length <= 3) {
      return SliverList.list(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(title, style: context.text.mediumTitle),
          ),
          const SizedBox(height: 8),
          ...audios.map(
            (audio) => AudioTile(audio: audio),
          ),
          const SizedBox(height: 8),
        ],
      );
    }

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
                child: Text(
                  title,
                  style: context.text.mediumTitle,
                ),
              ),
              TextButton(
                onPressed: onShowAllPressed,
                child:
                    Text(context.l10n.showAll, style: context.text.textButton),
              ),
            ],
          ),
          SizedBox(
            height: SizeConstants.audioTileHeight * 3 + 16,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupedAudios.length,
              itemBuilder: (context, index) {
                final group = groupedAudios[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: group
                        .map((audio) => AudioTile(
                              audio: audio,
                              onTap: () async {
                                final index = audios.indexOf(audio);
                                final items = audios
                                    .map((audio) => audio.toMediaItem())
                                    .toList();
                                final audioHandler = serviceLocator
                                    .get<AudioHandler>() as AppAudioHandler;
                                audioHandler.playMediaItemList(items, index);
                              },
                            ))
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
