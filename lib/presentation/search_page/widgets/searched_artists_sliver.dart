import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/artist_tile.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';
import 'package:provider/provider.dart';

class SearchedArtistsSliver extends StatelessWidget {
  final List<ArtistEntity> artists;

  const SearchedArtistsSliver({
    super.key,
    required this.artists,
  });

  @override
  Widget build(BuildContext context) {
    final displayedArtists =
        artists.take(CommonConstants.numberOfArtistsInSliver).toList();

    if (artists.isEmpty) return const SliverToBoxAdapter();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.allArtists,
                  style: context.text.mediumTitle,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<SearchPageBloc>().add(
                        OpenShowAllArtistsPage(
                          title: context.l10n.allArtists,
                          artists: artists,
                        ),
                      );
                },
                child: Text(
                  context.l10n.showAll,
                  style: context.text.textButton,
                ),
              ),
            ],
          ),
          ...displayedArtists.map(
            (artist) => ArtistTile(
              artist: artist,
              onTap: () {
                context.read<SearchPageBloc>().add(
                      OpenArtistPage(artist: artist),
                    );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
