import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/audio_cover/audio_cover_cubit.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/theme/theme_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/core/themes/app_theme.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merge_music/presentation/album_page/bloc/album_page_bloc.dart';
import 'package:merge_music/presentation/artist_page/bloc/artist_page_bloc.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
import 'package:merge_music/presentation/playlist_page/bloc/playlist_page_bloc.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';
import 'package:merge_music/presentation/settings_page/bloc/settings_page_bloc.dart';
import 'package:merge_music/presentation/show_all_playlists_page/bloc/show_all_playlists_page_bloc.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:merge_music/service_locator.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AccessTokenCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<VkLoginBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MainPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserTracksCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserAlbumsCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserPlaylistsCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FollowedPlaylistsCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AudioCoverCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SearchPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SettingsPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AlbumPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PlaylistPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ArtistPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ShowAllPlaylistsPageBloc>(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AccessTokenCubit>().checkToken();

    context.read<AccessTokenCubit>().stream.listen(
      (state) {
        if (state is AccessTokenLoaded) {
          if (mounted) {
            context.read<UserCubit>().loadUser();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccessTokenCubit, AccessTokenState>(
      listener: (context, state) {
        FlutterNativeSplash.remove();
        if (state is AccessTokenLoaded) {
          router.go(Routes.mainPage);
        } else if (state is AccessTokenNull) {
          router.go(Routes.welcomePage);
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
          );
        },
      ),
    );
  }
}
