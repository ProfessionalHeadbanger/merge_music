import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_audio_list.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class SearchedTracksSliver extends StatelessWidget {
  final List<AudioEntity> tracks;
  final String title;

  const SearchedTracksSliver({
    super.key,
    required this.tracks,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final audios =
        tracks.take(CommonConstants.numberOfTracksInHorizontalList).toList();

    return HorizontalScrollableAudioList(
      audios: audios,
      title: title,
    );
  }
}
