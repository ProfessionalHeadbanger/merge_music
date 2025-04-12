import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/widgets/playlist_tile.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class UserPlaylistsSliver extends StatelessWidget {
  const UserPlaylistsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPlaylistsCubit, UserPlaylistsState>(
      builder: (context, state) {
        if (state is! UserPlaylistsLoaded) {
          return const SliverToBoxAdapter();
        }

        final playlists = state.playlists.take(10).toList();

        if (playlists.isEmpty) {
          return const SliverToBoxAdapter();
        }

        return SliverToBoxAdapter(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: context.color.tertiaryText!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.myPlaylists,
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
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: PlaylistTile(
                          playlistEntity: playlists[index],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
