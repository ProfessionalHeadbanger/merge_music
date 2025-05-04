import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:merge_music/core/common/global_state/audio_handler/audio_handler.dart';
import 'package:merge_music/core/common/widgets/audio_tile.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/service_locator.dart';

class VerticalScrollableAudioList extends StatelessWidget {
  final List<AudioEntity> audios;
  final String? title;
  final bool isAlbum;
  const VerticalScrollableAudioList({
    super.key,
    required this.audios,
    this.title,
    this.isAlbum = false,
  });

  @override
  Widget build(BuildContext context) {
    if (audios.isEmpty) {
      return const SliverToBoxAdapter();
    }

    return SliverList.list(
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(title!, style: context.text.mediumTitle),
          ),
        ...audios.map(
          (audio) => AudioTile(
            audio: audio,
            needCover: !isAlbum,
            onTap: () async {
              final index = audios.indexOf(audio);
              final items = audios.map((audio) => audio.toMediaItem()).toList();
              final audioHandler =
                  serviceLocator.get<AudioHandler>() as AppAudioHandler;
              audioHandler.playMediaItemList(items, index);
            },
          ),
        ),
      ],
    );
  }
}
