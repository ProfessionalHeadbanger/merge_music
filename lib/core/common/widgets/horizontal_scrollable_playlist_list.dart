import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/playlist_tile.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

class HorizontalScrollablePlaylistList extends StatelessWidget {
  final List<PlaylistEntity> playlists;
  final String title;
  final VoidCallback? onShowAllPressed;

  const HorizontalScrollablePlaylistList({
    super.key,
    required this.playlists,
    required this.title,
    this.onShowAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (playlists.isEmpty) return const SliverToBoxAdapter();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.text.mediumTitle,
                ),
              ),
              TextButton(
                onPressed: onShowAllPressed,
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
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
