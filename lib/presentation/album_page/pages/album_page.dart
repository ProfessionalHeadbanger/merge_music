import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/custom_button_with_icon.dart';
import 'package:merge_music/core/common/widgets/icon_text_button.dart';
import 'package:merge_music/core/common/widgets/loading_widget.dart';
import 'package:merge_music/core/common/widgets/mini_player.dart';
import 'package:merge_music/core/common/widgets/retry_button.dart';
import 'package:merge_music/core/common/widgets/sliver_divider.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_audio_list.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/presentation/album_page/bloc/album_page_bloc.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

class AlbumPage extends StatefulWidget {
  final PlaylistEntity album;

  const AlbumPage({
    super.key,
    required this.album,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        if (mounted) {
          context.read<AlbumPageBloc>().add(
                LoadPlaylistAudios(
                  albumId: widget.album.id,
                  accessKey: widget.album.accessKey,
                  ownerId: widget.album.ownerId,
                ),
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OverflowTextAnimated(
          text: widget.album.title,
          style: context.text.largeTitle,
          curve: Curves.easeInOut,
          animation: OverFlowTextAnimations.scrollOpposite,
          animateDuration: const Duration(milliseconds: 3000),
          delay: const Duration(milliseconds: 1000),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<AlbumPageBloc, AlbumPageState>(
        builder: (context, state) {
          if (state is AlbumPageLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          }
          if (state is AlbumPageError) {
            return Center(
              child: RetryButton(
                onPressed: () {
                  context.read<AlbumPageBloc>().add(
                        LoadPlaylistAudios(
                          albumId: widget.album.id,
                          accessKey: widget.album.accessKey,
                          ownerId: widget.album.ownerId,
                        ),
                      );
                },
              ),
            );
          }
          if (state is AlbumPageLoaded) {
            final totalDurationInSeconds =
                state.audios.map((a) => a.duration).fold(0, (a, b) => a + b);
            final totalMinutes = totalDurationInSeconds ~/ 60;
            final hours = totalMinutes ~/ 60;
            final minutes = totalMinutes % 60;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.album.photo1200,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.album.mainArtists!.first.name,
                            style:
                                context.text.artistName!.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.album.genres!.join(', ')} \u2981 ${widget.album.year}',
                            style: context.text.artistName,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: IconTextButton(
                                    iconPath: IconsConstants.addOutline,
                                    label: context.l10n.add,
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  child: IconTextButton(
                                    iconPath: IconsConstants.playNextOutline,
                                    label: context.l10n.addToQueue,
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  child: IconTextButton(
                                    iconPath: IconsConstants.shareOutline,
                                    label: context.l10n.share,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomButtonWithIcon(
                                  text: context.l10n.listen,
                                  iconPath: IconsConstants.play,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomButtonWithIcon(
                                  text: context.l10n.shuffle,
                                  iconPath: IconsConstants.shuffleOutline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  VerticalScrollableAudioList(
                    audios: state.audios,
                    isAlbum: true,
                  ),
                  SliverDivider(color: context.color.tertiaryText!),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.tracksCount(widget.album.count!),
                            style: context.text.artistName,
                          ),
                          Text(
                            context.l10n.durationHoursMinutes(hours, minutes),
                            style: context.text.artistName,
                          ),
                          Text(
                            context.l10n.listens(widget.album.plays!),
                            style: context.text.artistName,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
