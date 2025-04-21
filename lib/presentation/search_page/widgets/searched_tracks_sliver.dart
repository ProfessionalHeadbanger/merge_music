import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_audio_list.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';

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
      onShowAllPressed: () {
        context.read<SearchPageBloc>().add(
              OpenShowAllTracksPage(
                title: context.l10n.myTracks,
                audios: tracks,
              ),
            );
      },
    );
  }
}
