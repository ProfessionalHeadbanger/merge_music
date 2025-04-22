import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/mini_playlist_tile.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

class VerticalScrollablePlaylistList extends StatelessWidget {
  final List<PlaylistEntity> playlists;

  const VerticalScrollablePlaylistList({
    super.key,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    if (playlists.isEmpty) {
      return const SliverToBoxAdapter();
    }

    return SliverList.list(
      children: [
        ...playlists.map(
          (playlist) => MiniPlaylistTile(playlistEntity: playlist),
        ),
      ],
    );
  }
}
