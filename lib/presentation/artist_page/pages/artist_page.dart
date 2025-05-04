import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/animated_overflowed_text.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/core/common/widgets/loading_widget.dart';
import 'package:merge_music/core/common/widgets/mini_player.dart';
import 'package:merge_music/core/common/widgets/retry_button.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_audio_list.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/presentation/artist_page/bloc/artist_page_bloc.dart';

class ArtistPage extends StatefulWidget {
  final ArtistEntity artist;

  const ArtistPage({
    super.key,
    required this.artist,
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        if (mounted) {
          context.read<ArtistPageBloc>().add(
                LoadArtistPage(
                  artistId: widget.artist.id,
                ),
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArtistPageBloc, ArtistPageState>(
        builder: (context, state) {
          if (state is ArtistPageLoading) {
            return const Center(child: LoadingWidget());
          }
          if (state is ArtistPageError) {
            return Center(
              child: RetryButton(
                onPressed: () {
                  context.read<ArtistPageBloc>().add(
                        LoadArtistPage(artistId: widget.artist.id),
                      );
                },
              ),
            );
          }
          if (state is ArtistPageLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.artist.photo!,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: AnimatedOverflowedText(
                              text: widget.artist.name,
                              style: context.text.invertedLargeTitle!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.more_vert_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: HorizontalScrollablePlaylistList(
                    playlists: state.albums,
                    title: context.l10n.albums,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: VerticalScrollableAudioList(
                    audios: state.audios,
                    title: context.l10n.tracks,
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
