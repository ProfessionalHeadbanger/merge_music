import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';

class PlaylistsSliver extends StatelessWidget {
  final String title;
  final List<PlaylistEntity> playlists;

  const PlaylistsSliver({
    super.key,
    required this.title,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollablePlaylistList(
      playlists: playlists,
      title: title,
      onShowAllPressed: () {
        context.read<MainPageBloc>().add(
              OpenShowAllPlaylistsPage(
                title: title,
                playlists: playlists,
              ),
            );
      },
      onTileTapped: (album) {
        context.read<MainPageBloc>().add(
              OpenPlaylistPage(album: album),
            );
      },
    );
  }
}
