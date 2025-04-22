import 'package:flutter/material.dart';
import 'package:merge_music/core/constants/images_constants.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/core/utils/utils.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioTile extends StatelessWidget {
  final AudioEntity audio;
  final VoidCallback? onTap;
  const AudioTile({
    super.key,
    required this.audio,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: SizeConstants.audioTileWidth,
        height: SizeConstants.audioTileHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.color.primaryBackground,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  ImagesConstants.defaultCover,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      audio.title,
                      style: context.text.trackName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      audio.artist,
                      style: context.text.artistName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                Utils.formatDuration(audio.duration),
                style: context.text.artistName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
