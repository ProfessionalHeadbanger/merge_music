import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/mini_player.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_playlist_list.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/presentation/show_all_playlists_page/bloc/show_all_playlists_page_bloc.dart';

class ShowAllPlaylistsPage extends StatelessWidget {
  final String title;
  final List<PlaylistEntity> playlists;

  const ShowAllPlaylistsPage({
    super.key,
    required this.title,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            VerticalScrollablePlaylistList(
              playlists: playlists,
              onTileTapped: (album) {
                context.read<ShowAllPlaylistsPageBloc>().add(
                      OpenPlaylistPage(playlist: album),
                    );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
