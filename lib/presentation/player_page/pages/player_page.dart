import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merge_music/core/common/widgets/animated_overflowed_text.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/core/utils/utils.dart';
import 'package:merge_music/service_locator.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioHandler = serviceLocator.get<AudioHandler>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: context.color.primaryText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_outlined,
              color: context.color.primaryText,
            ),
          ),
        ],
      ),
      body: StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, mediaSnapshot) {
          final mediaItem = mediaSnapshot.data;
          if (mediaItem == null) {
            return const Center(child: Text('Нет активного трека'));
          }
          return StreamBuilder<PlaybackState>(
            stream: audioHandler.playbackState,
            builder: (context, playbackSnapshot) {
              final state = playbackSnapshot.data;
              final isPlaying = state?.playing ?? false;
              final position = state?.updatePosition ?? Duration.zero;
              final duration = mediaItem.duration ?? Duration.zero;
              final progress = duration.inMilliseconds > 0
                  ? position.inMilliseconds / duration.inMilliseconds
                  : 0.0;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: mediaItem.artUri != null
                            ? Image.network(
                                mediaItem.artUri.toString(),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/default_cover.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedOverflowedText(
                                key: ValueKey(mediaItem.title),
                                text: mediaItem.title,
                                style: context.text.largeTitle!,
                              ),
                              AnimatedOverflowedText(
                                key: ValueKey(mediaItem.artist),
                                text: mediaItem.artist ?? '',
                                style: context.text.mediumTitle!,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            IconsConstants.addOutline,
                            width: 28,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                                context.color.primaryText!, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Slider(
                      value: progress.clamp(0.0, 1.0),
                      onChanged: (_) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Utils.formatDuration(position)),
                        Text(Utils.formatDuration(duration)),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(IconsConstants.repeatOutline),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(IconsConstants.skipBack),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.color.selectedNavBarItem,
                          ),
                          child: IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              if (isPlaying) {
                                audioHandler.pause();
                              } else {
                                audioHandler.play();
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(IconsConstants.skipNext),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(IconsConstants.shuffleOutline),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
