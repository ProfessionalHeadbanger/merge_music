import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

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
        height: 180,
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
              OverflowTextAnimated(
                text: playlistEntity.title,
                style: context.text.trackName,
                curve: Curves.easeInOut,
                animation: OverFlowTextAnimations.scrollOpposite,
                animateDuration: const Duration(milliseconds: 3000),
                delay: const Duration(milliseconds: 1000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
