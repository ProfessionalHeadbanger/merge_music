import 'package:flutter/material.dart';
import 'package:merge_music/core/common/widgets/vertical_scrollable_artist_list.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';

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
            ),
          ],
        ),
      ),
    );
  }
}
