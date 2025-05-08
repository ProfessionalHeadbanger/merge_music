import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merge_music/core/common/widgets/animated_overflowed_text.dart';
import 'package:merge_music/core/common/widgets/queue_sheet.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/core/utils/utils.dart';
import 'package:merge_music/service_locator.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  double? _dragSliderValue;
  bool _isSliderDragging = false;

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
              final repeatMode = playbackSnapshot.data?.repeatMode;
              final isRepeatActive = repeatMode != AudioServiceRepeatMode.none;
              final shuffleMode = playbackSnapshot.data?.shuffleMode;
              final isShuffleActive =
                  shuffleMode != AudioServiceShuffleMode.none;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
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
                    ),
                    StatefulBuilder(
                      builder: (context, setInnerState) {
                        final total = duration.inMilliseconds.toDouble();
                        final current = position.inMilliseconds.toDouble();

                        final sliderValue = _isSliderDragging
                            ? _dragSliderValue ?? 0.0
                            : (total > 0
                                ? (current / total).clamp(0.0, 1.0)
                                : 0.0);

                        return Slider(
                          value: sliderValue,
                          onChangeStart: (_) {
                            setInnerState(() => _isSliderDragging = true);
                          },
                          onChanged: (value) {
                            setInnerState(() => _dragSliderValue = value);
                          },
                          onChangeEnd: (value) {
                            audioHandler.seek(Duration(
                                milliseconds: (total * value).toInt()));
                            setInnerState(
                              () {
                                _isSliderDragging = false;
                                _dragSliderValue = null;
                              },
                            );
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Utils.formatDuration(position),
                            style: context.text.artistName,
                          ),
                          Text(
                            Utils.formatDuration(duration),
                            style: context.text.artistName,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isRepeatActive
                                ? context.color.secondaryBackground
                                : Colors.transparent,
                          ),
                          child: IconButton(
                            onPressed: () {
                              switch (repeatMode) {
                                case AudioServiceRepeatMode.none:
                                  audioHandler.setRepeatMode(
                                      AudioServiceRepeatMode.one);
                                  break;
                                case AudioServiceRepeatMode.one:
                                  audioHandler.setRepeatMode(
                                      AudioServiceRepeatMode.none);
                                  break;
                                default:
                                  audioHandler.setRepeatMode(
                                      AudioServiceRepeatMode.none);
                                  break;
                              }
                            },
                            icon: SvgPicture.asset(
                              IconsConstants.repeatOutline,
                              width: 28,
                              height: 28,
                              colorFilter: ColorFilter.mode(
                                  context.color.primaryText!, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => audioHandler.skipToPrevious(),
                          icon: SvgPicture.asset(
                            IconsConstants.skipBack,
                            width: 36,
                            height: 36,
                            colorFilter: ColorFilter.mode(
                                context.color.primaryText!, BlendMode.srcIn),
                          ),
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
                          onPressed: () => audioHandler.skipToNext(),
                          icon: SvgPicture.asset(
                            IconsConstants.skipForward,
                            width: 36,
                            height: 36,
                            colorFilter: ColorFilter.mode(
                                context.color.primaryText!, BlendMode.srcIn),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isShuffleActive
                                ? context.color.secondaryBackground
                                : Colors.transparent,
                          ),
                          child: IconButton(
                            onPressed: () {
                              switch (shuffleMode) {
                                case AudioServiceShuffleMode.none:
                                  audioHandler.setShuffleMode(
                                      AudioServiceShuffleMode.all);
                                  break;
                                case AudioServiceShuffleMode.all:
                                  audioHandler.setShuffleMode(
                                      AudioServiceShuffleMode.none);
                                  break;
                                default:
                                  audioHandler.setShuffleMode(
                                      AudioServiceShuffleMode.none);
                                  break;
                              }
                            },
                            icon: SvgPicture.asset(
                              IconsConstants.shuffleOutline,
                              width: 28,
                              height: 28,
                              colorFilter: ColorFilter.mode(
                                  context.color.primaryText!, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 86,
                    ),
                    Divider(
                      height: 1,
                      color: context.color.auxiliaryText,
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: context.color.primaryBackground,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (_) => QueueSheet(),
                          );
                        },
                        icon: Icon(
                          Icons.drag_handle,
                          size: 28,
                          color: context.color.primaryText,
                        ),
                      ),
                    )
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
