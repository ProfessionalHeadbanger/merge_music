import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/artist_tile.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';

class VerticalScrollableArtistList extends StatelessWidget {
  final List<ArtistEntity> artists;
  final void Function(ArtistEntity)? onTileTapped;

  const VerticalScrollableArtistList({
    super.key,
    required this.artists,
    this.onTileTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) {
      return const SliverToBoxAdapter();
    }

    return SliverList.list(
      children: [
        ...artists.map(
          (artist) => ArtistTile(
            artist: artist,
            onTap: () => onTileTapped?.call(artist),
          ),
        ),
      ],
    );
  }
}
