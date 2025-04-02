import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/audio_tile.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
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

        final audios = state.audios.take(15).toList();

        if (audios.isEmpty) {
          return const SliverToBoxAdapter();
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
                      context.l10n.myTracks,
                      style: context.text.mediumTitle,
                    ),
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
      },
    );
  }
}
