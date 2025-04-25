import 'package:flutter/material.dart';
import 'package:merge_music/core/common/navigation/navigation_args.dart';
import 'package:merge_music/presentation/album_page/pages/album_page.dart';
import 'package:merge_music/presentation/library_page/pages/library_page.dart';
import 'package:merge_music/presentation/main_page/pages/main_page.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/presentation/root_page/root_page.dart';
import 'package:merge_music/presentation/search_page/pages/search_page.dart';
import 'package:merge_music/presentation/settings_page/pages/settings_page.dart';
import 'package:merge_music/presentation/show_all_artists_page/show_all_artists_page.dart';
import 'package:merge_music/presentation/show_all_playlists_page/pages/show_all_playlists_page.dart';
import 'package:merge_music/presentation/show_all_tracks_page/show_all_tracks_page.dart';
import 'package:merge_music/presentation/vk_login/pages/vk_login_input_login_page.dart';
import 'package:merge_music/presentation/vk_login/pages/vk_login_welcome_page.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.mainPage,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.mainPage,
              builder: (_, __) => const MainPage(),
              routes: [
                GoRoute(
                  path: Routes.showAllTracksPage,
                  builder: (context, state) {
                    final args = state.extra as ShowAllTracksPageArgs;
                    return ShowAllTracksPage(
                      title: args.title,
                      audios: args.audios,
                    );
                  },
                ),
                GoRoute(
                  path: Routes.showAllPlaylistsPage,
                  builder: (context, state) {
                    final args = state.extra as ShowAllPlaylistsPageArgs;
                    return ShowAllPlaylistsPage(
                      title: args.title,
                      playlists: args.playlists,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.searchPage,
              builder: (_, __) => const SearchPage(),
              routes: [
                GoRoute(
                  path: Routes.showAllTracksPage,
                  builder: (context, state) {
                    final args = state.extra as ShowAllTracksPageArgs;
                    return ShowAllTracksPage(
                      title: args.title,
                      audios: args.audios,
                    );
                  },
                ),
                GoRoute(
                  path: Routes.showAllPlaylistsPage,
                  builder: (context, state) {
                    final args = state.extra as ShowAllPlaylistsPageArgs;
                    return ShowAllPlaylistsPage(
                      title: args.title,
                      playlists: args.playlists,
                    );
                  },
                ),
                GoRoute(
                  path: Routes.showAllArtistsPage,
                  builder: (context, state) {
                    final args = state.extra as ShowAllArtistsPageArgs;
                    return ShowAllArtistsPage(
                      title: args.title,
                      artists: args.artists,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.libraryPage,
              builder: (_, __) => const LibraryPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingsPage,
              builder: (_, __) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.welcomePage,
      builder: (_, __) => const VkLoginWelcomePage(),
      routes: [
        GoRoute(
          path: Routes.inputLogin,
          builder: (_, __) => const VkLoginInputLoginPage(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.albumPage,
      name: Routes.albumPage,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final args = state.extra as AlbumPageArgs;
        return AlbumPage(album: args.album);
      },
    ),
  ],
);
