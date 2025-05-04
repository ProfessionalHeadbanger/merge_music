import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/animated_overflowed_text.dart';
import 'package:merge_music/core/constants/images_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/service_locator.dart';

class MiniPlayer extends StatelessWidget {
  final VoidCallback? onTap;

  const MiniPlayer({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final audioHandler = serviceLocator.get<AudioHandler>();

    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, mediaSnapshot) {
        final mediaItem = mediaSnapshot.data;
        if (mediaItem == null) {
          return const SizedBox.shrink();
        }

        return StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, playbackSnapshot) {
            final state = playbackSnapshot.data;
            final isPlaying = state?.playing ?? false;
            final duration = mediaItem.duration ?? Duration.zero;
            final position = state?.updatePosition ?? Duration.zero;
            final progress = duration.inMilliseconds > 0
                ? position.inMilliseconds / duration.inMilliseconds
                : 0.0;
            return SizedBox(
              height: 64,
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 2,
                    backgroundColor: context.color.selectedNavBarItemBoxColor,
                    color: context.color.selectedNavBarItem,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.color.primaryBackground,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: mediaItem.artUri != null
                                    ? Image.network(
                                        mediaItem.artUri.toString(),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        ImagesConstants.defaultCover,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedOverflowedText(
                                    key: ValueKey(mediaItem.title),
                                    text: mediaItem.title,
                                    style: context.text.trackName!,
                                  ),
                                  AnimatedOverflowedText(
                                    key: ValueKey(mediaItem.artist),
                                    text: mediaItem.artist ?? '',
                                    style: context.text.artistName!,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                color: context.color.primaryText,
                                size: 30,
                              ),
                              onPressed: () {
                                audioHandler.stop();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: IconButton(
                                icon: Icon(
                                  isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: context.color.primaryText,
                                  size: 30,
                                ),
                                onPressed: () {
                                  if (isPlaying) {
                                    audioHandler.pause();
                                  } else {
                                    audioHandler.play();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
