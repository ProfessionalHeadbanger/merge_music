import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/audio_cover/audio_cover_cubit.dart';
import 'package:merge_music/core/common/global_state/audio_handler/audio_handler.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/theme/theme_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/network/internet_connection_checker.dart';
import 'package:merge_music/data/data_sources/remote/audio_remote_data_source.dart';
import 'package:merge_music/data/data_sources/remote/deezer_remote_data_source.dart';
import 'package:merge_music/data/data_sources/remote/vk_login_data_source.dart';
import 'package:merge_music/data/repositories/audio_repository_impl.dart';
import 'package:merge_music/data/repositories/deezer_repository_impl.dart';
import 'package:merge_music/data/repositories/vk_login_repository_impl.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';
import 'package:merge_music/domain/repositories/deezer_repository.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';
import 'package:merge_music/domain/usecases/get_albums_by_artist.dart';
import 'package:merge_music/domain/usecases/get_audio_cover.dart';
import 'package:merge_music/domain/usecases/get_audios_by_artist.dart';
import 'package:merge_music/domain/usecases/get_followed_playlists.dart';
import 'package:merge_music/domain/usecases/get_playlist_audios.dart';
import 'package:merge_music/domain/usecases/get_recommendations_for_user.dart';
import 'package:merge_music/domain/usecases/get_user_albums.dart';
import 'package:merge_music/domain/usecases/get_user_audios.dart';
import 'package:merge_music/domain/usecases/get_user_info.dart';
import 'package:merge_music/domain/usecases/get_user_playlists.dart';
import 'package:merge_music/domain/usecases/search_albums.dart';
import 'package:merge_music/domain/usecases/search_artists.dart';
import 'package:merge_music/domain/usecases/search_audio.dart';
import 'package:merge_music/domain/usecases/search_playlists.dart';
import 'package:merge_music/presentation/album_page/bloc/album_page_bloc.dart';
import 'package:merge_music/presentation/artist_page/bloc/artist_page_bloc.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
import 'package:merge_music/presentation/playlist_page/bloc/playlist_page_bloc.dart';
import 'package:merge_music/presentation/search_page/bloc/search_page_bloc.dart';
import 'package:merge_music/presentation/settings_page/bloc/settings_page_bloc.dart';
import 'package:merge_music/presentation/show_all_playlists_page/bloc/show_all_playlists_page_bloc.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  serviceLocator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  serviceLocator.registerFactory<InternetConnection>(
    () => InternetConnection(),
  );
  serviceLocator.registerFactory<InternetConnectionChecker>(
    () => InternetConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
  final audioHandler = await AudioService.init(
      builder: () => AppAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.merge_music.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ));

  serviceLocator.registerSingleton<AudioHandler>(audioHandler);

  // Global State
  serviceLocator.registerLazySingleton<AccessTokenCubit>(
    () => AccessTokenCubit(),
  );
  serviceLocator.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<DeezerRemoteDataSource>(
    () => DeezerRemoteDataSourceImpl(),
  );
  serviceLocator.registerFactory<DeezerRepository>(
    () => DeezerRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetAudioCover(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<AudioCoverCubit>(
    () => AudioCoverCubit(
      serviceLocator(),
    ),
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
  serviceLocator.registerFactory(
    () => GetRecommendationsForUser(
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
      getRecommendationsForUser: serviceLocator(),
    ),
  );

  // Search Page
  serviceLocator.registerFactory(
    () => SearchAudio(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SearchArtists(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SearchPlaylists(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SearchAlbums(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SearchPageBloc(
      prefs: serviceLocator(),
      searchAudio: serviceLocator(),
      searchArtists: serviceLocator(),
      searchPlaylists: serviceLocator(),
      searchAlbums: serviceLocator(),
    ),
  );

  // Settings Page
  serviceLocator.registerLazySingleton<SettingsPageBloc>(
    () => SettingsPageBloc(
      accessTokenCubit: serviceLocator<AccessTokenCubit>(),
    ),
  );

  // Show All Playlists Page
  serviceLocator.registerLazySingleton<ShowAllPlaylistsPageBloc>(
    () => ShowAllPlaylistsPageBloc(),
  );

  // Album Page
  serviceLocator.registerFactory(
    () => GetPlaylistAudios(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<AlbumPageBloc>(
    () => AlbumPageBloc(
      getPlaylistAudios: serviceLocator(),
    ),
  );

  // Playlist page
  serviceLocator.registerLazySingleton<PlaylistPageBloc>(
    () => PlaylistPageBloc(
      getPlaylistAudios: serviceLocator(),
    ),
  );

  // Artist page
  serviceLocator.registerFactory(
    () => GetAlbumsByArtist(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetAudiosByArtist(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ArtistPageBloc>(
    () => ArtistPageBloc(
      getAlbumsByArtist: serviceLocator(),
      getAudiosByArtist: serviceLocator(),
    ),
  );
}
