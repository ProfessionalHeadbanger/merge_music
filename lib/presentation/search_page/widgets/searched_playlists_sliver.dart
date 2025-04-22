import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/widgets/horizontal_scrollable_playlist_list.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';

class SearchedPlaylistsSliver extends StatelessWidget {
  final List<PlaylistEntity> playlists;
  final String title;

  const SearchedPlaylistsSliver({
    super.key,
    required this.playlists,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final list = playlists
        .take(CommonConstants.numberOfPlaylistsInHorizontalList)
        .toList();

    return HorizontalScrollablePlaylistList(
      playlists: list,
      title: title,
      onShowAllPressed: () {
        context.read<SearchPageBloc>().add(
              OpenShowAllPlaylistsPage(
                title: title,
                playlists: playlists,
              ),
            );
      },
    );
  }
}
