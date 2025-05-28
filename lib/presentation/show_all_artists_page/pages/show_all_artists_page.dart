import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/mini_player.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_artist_list.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/presentation/show_all_artists_page/bloc/show_all_artists_page_bloc.dart';

class ShowAllArtistsPage extends StatelessWidget {
  final String title;
  final List<ArtistEntity> artists;
  const ShowAllArtistsPage({
    super.key,
    required this.title,
    required this.artists,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            VerticalScrollableArtistList(
              artists: artists,
              onTileTapped: (artist) {
                context.read<ShowAllArtistsPageBloc>().add(
                      OpenArtistPage(artist: artist),
                    );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
