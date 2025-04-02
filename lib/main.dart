import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/core/themes/app_theme.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
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
          create: (context) => serviceLocator<UserPlaylistsCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<FollowedPlaylistsCubit>(),
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
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
