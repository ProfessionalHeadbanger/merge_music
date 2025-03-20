import 'package:flutter/material.dart';
import 'package:merge_music/core/constants/images_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioTile extends StatelessWidget {
  final AudioEntity audio;
  final VoidCallback? onTap;
  const AudioTile({super.key, required this.audio, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.color.primaryBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                ImagesConstants.defaultCover,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
