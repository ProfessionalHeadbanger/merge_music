import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/core/common/widgets/loading_widget.dart';
import 'package:merge_music/core/common/widgets/retry_button.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_audio_list.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/presentation/artist_page/bloc/artist_page_bloc.dart';
import 'package:overflow_text_animated/src.dart';

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
      appBar: AppBar(
        title: OverflowTextAnimated(
          text: widget.artist.name,
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
                        LoadArtistPage(
                          artistId: widget.artist.id,
                        ),
                      );
                },
              ),
            );
          }
          if (state is ArtistPageLoaded) {
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
                            child: Image.network(
                              widget.artist.photo!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HorizontalScrollablePlaylistList(
                    playlists: state.albums,
                    title: context.l10n.albums,
                  ),
                  VerticalScrollableAudioList(
                    audios: state.audios,
                    title: context.l10n.tracks,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
