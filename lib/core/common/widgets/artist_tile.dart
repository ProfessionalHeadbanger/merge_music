import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

class ArtistTile extends StatelessWidget {
  final ArtistEntity artist;
  final VoidCallback? onTap;

  const ArtistTile({
    super.key,
    required this.artist,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 280,
        height: 80,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.color.primaryBackground,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(artist.photo),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OverflowTextAnimated(
                  text: artist.name,
                  style: context.text.trackName!.copyWith(fontSize: 16),
                  curve: Curves.easeInOut,
                  animation: OverFlowTextAnimations.scrollOpposite,
                  animateDuration: const Duration(milliseconds: 3000),
                  delay: const Duration(milliseconds: 1000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
