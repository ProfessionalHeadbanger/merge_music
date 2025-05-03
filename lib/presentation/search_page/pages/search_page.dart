import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/widgets/loading_widget.dart';
import 'package:merge_music/core/common/widgets/mini_player.dart';
import 'package:merge_music/core/common/widgets/retry_button.dart';
import 'package:merge_music/core/common/widgets/sliver_divider.dart';
import 'package:merge_music/core/constants/icons_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';
import 'package:merge_music/presentation/search_page/widgets/empty_history_widget.dart';
import 'package:merge_music/presentation/search_page/widgets/searched_artists_sliver.dart';
import 'package:merge_music/presentation/search_page/widgets/searched_playlists_sliver.dart';
import 'package:merge_music/presentation/search_page/widgets/searched_tracks_sliver.dart';
import 'package:merge_music/presentation/search_page/widgets/loaded_history_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  bool _showClearButton = false;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitQuery(String query) {
    final trimmed = query.trim();
    if (trimmed.isNotEmpty) {
      context.read<SearchPageBloc>().add(AddQueryToHistory(query: trimmed));
      context.read<SearchPageBloc>().add(SearchByQuery(query: trimmed));
      _lastQuery = trimmed;
    } else {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: context.color.secondaryBackground,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconsConstants.searchOutline,
                  colorFilter: ColorFilter.mode(
                      context.color.unselectedNavBarItem!, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: context.text.subtitle,
                    onSubmitted: (query) => _submitQuery(query),
                    decoration: InputDecoration(
                      hintText: context.l10n.search,
                      hintStyle: context.text.subtitle,
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
                if (_showClearButton)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      context
                          .read<SearchPageBloc>()
                          .add(ClearSearchTextField());
                    },
                    child: SvgPicture.asset(
                      IconsConstants.cancelCircleOutline,
                      colorFilter: ColorFilter.mode(
                          context.color.unselectedNavBarItem!, BlendMode.srcIn),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: BlocBuilder<SearchPageBloc, SearchPageState>(
          builder: (context, state) {
            if (state is SearchPageEmptyHistory) {
              return EmptyHistoryWidget();
            }
            if (state is SearchPageHistoryLoaded) {
              return LoadedHistoryWidget(
                history: state.history,
                onQueryTap: (query) => _submitQuery(query),
                setControllerText: (text) => _controller.text = text,
              );
            }
            if (state is SearchPageError) {
              return Center(
                child: RetryButton(
                  onPressed: () {
                    context
                        .read<SearchPageBloc>()
                        .add(SearchByQuery(query: _lastQuery));
                  },
                ),
              );
            }
            if (state is SearchPageLoading) {
              return const Center(child: LoadingWidget());
            }
            if (state is SearchPageLoaded) {
              final likedTracks =
                  state.tracks.where((track) => track.like ?? false).toList();
              final notLikedTracks =
                  state.tracks.where((track) => track.like == null).toList();

              final userState = context.read<UserCubit>().state as UserLoggedIn;
              final inMyPlaylists = state.playlists
                  .where((playlist) =>
                      (playlist.ownerId == userState.user.id ||
                          playlist.isFollowing) &&
                      playlist.type == 0)
                  .toList();
              final allPlaylists = state.playlists
                  .where((playlist) =>
                      (playlist.ownerId != userState.user.id &&
                          !playlist.isFollowing) &&
                      playlist.type == 0)
                  .toList();

              final likedAlbums =
                  state.albums.where((album) => album.isFollowing).toList();
              final notLikedAlbums =
                  state.albums.where((album) => !album.isFollowing).toList();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(
                  slivers: [
                    SliverDivider(color: context.color.tertiaryText!),
                    SearchedTracksSliver(
                      tracks: likedTracks,
                      title: context.l10n.inMyTracks,
                    ),
                    SliverDivider(color: context.color.auxiliaryText!),
                    SearchedTracksSliver(
                      tracks: notLikedTracks,
                      title: context.l10n.allTracks,
                    ),
                    SliverDivider(color: context.color.tertiaryText!),
                    SearchedPlaylistsSliver(
                      playlists: inMyPlaylists,
                      title: context.l10n.inMyPlaylists,
                    ),
                    SliverDivider(color: context.color.auxiliaryText!),
                    SearchedPlaylistsSliver(
                      playlists: allPlaylists,
                      title: context.l10n.allPlaylists,
                    ),
                    SliverDivider(color: context.color.auxiliaryText!),
                    SearchedPlaylistsSliver(
                        playlists: likedAlbums, title: context.l10n.inMyAlbums),
                    SliverDivider(color: context.color.auxiliaryText!),
                    SearchedPlaylistsSliver(
                        playlists: notLikedAlbums,
                        title: context.l10n.allAlbums),
                    SliverDivider(color: context.color.tertiaryText!),
                    SearchedArtistsSliver(artists: state.artists),
                    SliverDivider(color: context.color.tertiaryText!),
                  ],
                ),
              );
            }
            return EmptyHistoryWidget();
          },
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
