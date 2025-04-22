import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

class MiniPlaylistTile extends StatelessWidget {
  final PlaylistEntity playlistEntity;
  final VoidCallback? onTap;

  const MiniPlaylistTile({
    super.key,
    required this.playlistEntity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 280,
        height: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.color.primaryBackground,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  playlistEntity.photo300,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  playlistEntity.title,
                  style: context.text.trackName!.copyWith(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
