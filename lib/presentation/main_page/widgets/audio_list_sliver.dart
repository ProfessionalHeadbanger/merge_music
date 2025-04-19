import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_audio_list.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';

class AudioListSliver extends StatelessWidget {
  const AudioListSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserTracksCubit, UserTracksState>(
      builder: (context, state) {
        if (state is! UserTracksLoaded) {
          return const SliverToBoxAdapter();
        }

        final audios = state.audios
            .take(CommonConstants.numberOfTracksInHorizontalList)
            .toList();

        return HorizontalScrollableAudioList(
          audios: audios,
          title: context.l10n.myTracks,
        );
      },
    );
  }
}
