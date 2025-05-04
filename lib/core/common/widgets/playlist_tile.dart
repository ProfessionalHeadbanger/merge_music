import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/animated_overflowed_text.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

class PlaylistTile extends StatelessWidget {
  final PlaylistEntity playlistEntity;
  final VoidCallback? onTap;

  const PlaylistTile({
    super.key,
    required this.playlistEntity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.color.primaryBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  playlistEntity.photo300,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              AnimatedOverflowedText(
                text: playlistEntity.title,
                style: context.text.trackName!,
              ),
              if (playlistEntity.mainArtists != null &&
                  playlistEntity.mainArtists!.isNotEmpty)
                AnimatedOverflowedText(
                  text: playlistEntity.mainArtists!
                      .map((artist) => artist.name)
                      .join(', '),
                  style: context.text.artistName!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
