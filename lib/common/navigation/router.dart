import 'package:flutter/material.dart';
import 'package:merge_music/presentation/library_page/pages/library_page.dart';
import 'package:merge_music/presentation/main_page/pages/main_page.dart';
import 'package:merge_music/common/navigation/routes.dart';
import 'package:merge_music/presentation/root_page/root_page.dart';
import 'package:merge_music/presentation/search_page/pages/search_page.dart';
import 'package:merge_music/presentation/settings_page/pages/settings_page.dart';
import 'package:merge_music/presentation/vk_login/pages/vk_login_input_login_page.dart';
import 'package:merge_music/presentation/vk_login/pages/vk_login_2fa_page.dart';
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
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.searchPage,
              builder: (_, __) => const SearchPage(),
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
      path: Routes.vkLogin,
      builder: (_, __) => const VkLoginWelcomePage(),
      routes: [
        GoRoute(
          path: Routes.inputLogin,
          builder: (_, __) => const VkLoginInputLoginPage(),
          routes: [
            GoRoute(
              path: Routes.confirmSms,
              builder: (_, __) => const VkLogin2faPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
