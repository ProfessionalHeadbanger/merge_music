import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/core/extensions/extensions.dart';

class FollowedPlaylistsSliver extends StatelessWidget {
  const FollowedPlaylistsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowedPlaylistsCubit, FollowedPlaylistsState>(
      builder: (context, state) {
        if (state is! FollowedPlaylistsLoaded) {
          return const SliverToBoxAdapter();
        }

        final playlists = state.playlists.take(10).toList();

        return HorizontalScrollablePlaylistList(
          playlists: playlists,
          title: context.l10n.myFollowedPlaylists,
        );
      },
    );
  }
}
