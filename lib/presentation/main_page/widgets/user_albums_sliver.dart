import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';

class UserAlbumsSliver extends StatelessWidget {
  const UserAlbumsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAlbumsCubit, UserAlbumsState>(
      builder: (context, state) {
        if (state is! UserAlbumsLoaded) {
          return const SliverToBoxAdapter();
        }

        final albums = state.albums
            .take(CommonConstants.numberOfPlaylistsInHorizontalList)
            .toList();

        return HorizontalScrollablePlaylistList(
          playlists: albums,
          title: context.l10n.myAlbums,
          onShowAllPressed: () {
            context.read<MainPageBloc>().add(
                  OpenShowAllPlaylistsPage(
                    title: context.l10n.myAlbums,
                    playlists: state.albums,
                  ),
                );
          },
          onTileTapped: (album) {
            context.read<MainPageBloc>().add(
                  OpenAlbumPage(album: album),
                );
          },
        );
      },
    );
  }
}
