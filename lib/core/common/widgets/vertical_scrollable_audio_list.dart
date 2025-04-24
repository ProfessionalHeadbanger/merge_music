import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/audio_tile.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

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
          ),
        ),
      ],
    );
  }
}
