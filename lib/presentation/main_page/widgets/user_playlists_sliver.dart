import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/core/constants/common_constants.dart';
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

        final playlists = state.playlists
            .take(CommonConstants.numberOfPlaylistsInHorizontalList)
            .toList();

        return HorizontalScrollablePlaylistList(
          playlists: playlists,
          title: context.l10n.myPlaylists,
        );
      },
    );
  }
}
