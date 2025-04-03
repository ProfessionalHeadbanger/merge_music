import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/network/internet_connection_checker.dart';
import 'package:merge_music/data/data_sources/remote/audio_remote_data_source.dart';
import 'package:merge_music/data/data_sources/remote/vk_login_data_source.dart';
import 'package:merge_music/data/repositories/audio_repository_impl.dart';
import 'package:merge_music/data/repositories/vk_login_repository_impl.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';
import 'package:merge_music/domain/usecases/get_followed_playlists.dart';
import 'package:merge_music/domain/usecases/get_user_albums.dart';
import 'package:merge_music/domain/usecases/get_user_audios.dart';
import 'package:merge_music/domain/usecases/get_user_info.dart';
import 'package:merge_music/domain/usecases/get_user_playlists.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
import 'package:merge_music/presentation/settings_page/bloc/settings_page_bloc_bloc.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Common services
  serviceLocator.registerSingleton<Logger>(
    Logger(),
  );
  serviceLocator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        headers: {
          "User-Agent":
              "KateMobileAndroid/109.1 lite-550 (Android 13; SDK 33; x86_64; Google Pixel 5; ru)",
        },
      ),
    ),
  );
  serviceLocator.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(),
  );
  serviceLocator.registerFactory<InternetConnection>(
    () => InternetConnection(),
  );
  serviceLocator.registerFactory<InternetConnectionChecker>(
    () => InternetConnectionCheckerImpl(
      serviceLocator(),
    ),
  );

  // Global State
  serviceLocator.registerLazySingleton<AccessTokenCubit>(
    () => AccessTokenCubit(),
  );

  // VK Login Page
  serviceLocator.registerFactory<VkLoginDataSource>(
    () => VkLoginDataSourceImpl(),
  );
  serviceLocator.registerFactory<VkLoginRepository>(
    () => VkLoginRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetUserInfo(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<VkLoginBloc>(
    () => VkLoginBloc(
      internetConnectionChecker: serviceLocator(),
      getUserInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserCubit>(
    () => UserCubit(
      serviceLocator(),
    ),
  );

  // Main Page
  serviceLocator.registerFactory<AudioRemoteDataSource>(
    () => AudioRemoteDataSourceImpl(),
  );
  serviceLocator.registerFactory<AudioRepository>(
    () => AudioRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetUserAudios(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetUserAlbums(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetUserPlaylists(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetFollowedPlaylists(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserTracksCubit>(
    () => UserTracksCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserAlbumsCubit>(
    () => UserAlbumsCubit(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserPlaylistsCubit>(
    () => UserPlaylistsCubit(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<FollowedPlaylistsCubit>(
    () => FollowedPlaylistsCubit(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<MainPageBloc>(
    () => MainPageBloc(
      userTracksCubit: serviceLocator(),
      userAlbumsCubit: serviceLocator(),
      userPlaylistsCubit: serviceLocator(),
      followedPlaylistsCubit: serviceLocator(),
      accessTokenCubit: serviceLocator<AccessTokenCubit>(),
    ),
  );

  serviceLocator.registerLazySingleton<SettingsPageBlocBloc>(
    () => SettingsPageBlocBloc(
      accessTokenCubit: serviceLocator<AccessTokenCubit>(),
    ),
  );
}
