import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/widgets/mini_player.dart';
import 'package:merge_music/core/common/widgets/retry_button.dart';
import 'package:merge_music/core/common/widgets/sliver_divider.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
import 'package:merge_music/presentation/main_page/widgets/audio_list_sliver.dart';
import 'package:merge_music/presentation/main_page/widgets/playlists_sliver.dart';
import 'package:merge_music/presentation/main_page/widgets/vk_mix_sliver.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.mainPage,
        ),
      ),
      body: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          if (state is MainPageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MainPageError) {
            return Center(
              child: RetryButton(
                onPressed: () {
                  context.read<MainPageBloc>().add(LoadMainPageData());
                },
              ),
            );
          }
          if (state is MainPageLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                slivers: [
                  SliverDivider(color: context.color.tertiaryText!),
                  VkMixSliver(
                    onPressed: () {
                      context.read<MainPageBloc>().add(PlayRecommendations());
                    },
                  ),
                  SliverDivider(color: context.color.tertiaryText!),
                  AudioListSliver(),
                  SliverDivider(color: context.color.tertiaryText!),
                  BlocBuilder<UserAlbumsCubit, UserAlbumsState>(
                    builder: (context, state) {
                      if (state is! UserAlbumsLoaded) {
                        return const SliverToBoxAdapter();
                      }

                      return PlaylistsSliver(
                        playlists: state.albums
                            .take(CommonConstants
                                .numberOfPlaylistsInHorizontalList)
                            .toList(),
                        title: context.l10n.myAlbums,
                      );
                    },
                  ),
                  SliverDivider(color: context.color.auxiliaryText!),
                  BlocBuilder<FollowedPlaylistsCubit, FollowedPlaylistsState>(
                    builder: (context, state) {
                      if (state is! FollowedPlaylistsLoaded) {
                        return const SliverToBoxAdapter();
                      }

                      return PlaylistsSliver(
                        playlists: state.playlists
                            .take(CommonConstants
                                .numberOfPlaylistsInHorizontalList)
                            .toList(),
                        title: context.l10n.myFollowedPlaylists,
                      );
                    },
                  ),
                  SliverDivider(color: context.color.auxiliaryText!),
                  BlocBuilder<UserPlaylistsCubit, UserPlaylistsState>(
                    builder: (context, state) {
                      if (state is! UserPlaylistsLoaded) {
                        return const SliverToBoxAdapter();
                      }

                      return PlaylistsSliver(
                        playlists: state.playlists
                            .take(CommonConstants
                                .numberOfPlaylistsInHorizontalList)
                            .toList(),
                        title: context.l10n.myPlaylists,
                      );
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 8),
                    sliver: SliverDivider(color: context.color.tertiaryText!),
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
