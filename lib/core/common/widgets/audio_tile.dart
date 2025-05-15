import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/audio_cover/audio_cover_cubit.dart';
import 'package:merge_music/core/constants/images_constants.dart';
import 'package:merge_music/core/constants/size_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/core/utils/utils.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

class AudioTile extends StatefulWidget {
  final AudioEntity audio;
  final VoidCallback? onTap;
  final bool needCover;
  const AudioTile({
    super.key,
    required this.audio,
    this.onTap,
    this.needCover = true,
  });

  @override
  State<AudioTile> createState() => _AudioTileState();
}

class _AudioTileState extends State<AudioTile> {
  @override
  void initState() {
    super.initState();
    if (widget.needCover) {
      final cubit = context.read<AudioCoverCubit>();
      if (cubit.state[widget.audio.id]?.coverUrl100 == null) {
        cubit.fetchAudioCover(widget.audio);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCoverCubit, Map<int, AudioEntity>>(
      buildWhen: (previous, current) =>
          previous[widget.audio.id]?.coverUrl100 !=
          current[widget.audio.id]?.coverUrl100,
      builder: (context, state) {
        final updatedAudio = state[widget.audio.id] ?? widget.audio;

        return InkWell(
          onTap: widget.onTap,
          child: SizedBox(
            width: SizeConstants.audioTileWidth,
            height: SizeConstants.audioTileHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.color.primaryBackground,
              ),
              child: Row(
                children: [
                  if (widget.needCover)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: updatedAudio.coverUrl100?.isNotEmpty == true
                          ? Image.network(
                              updatedAudio.coverUrl100!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              ImagesConstants.defaultCover,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                    ),
                  if (widget.needCover) const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          updatedAudio.title,
                          style: context.text.trackName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          updatedAudio.artist,
                          style: context.text.artistName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    Utils.formatDurationFromInt(updatedAudio.duration),
                    style: context.text.artistName,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
