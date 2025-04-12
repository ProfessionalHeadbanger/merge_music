import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_audio_list.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_audio_list.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class SearchedTracksWidget extends StatelessWidget {
  final List<AudioEntity> tracks;

  const SearchedTracksWidget({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    final likedTracks = tracks.where((track) => track.like ?? false).toList();
    final notLikedTracks = tracks.where((track) => track.like == null).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          HorizontalScrollableAudioList(
              audios: likedTracks, title: context.l10n.inMyTracks),
          VerticalScrollableAudioList(
              audios: notLikedTracks, title: context.l10n.allTracks),
        ],
      ),
    );
  }
}
