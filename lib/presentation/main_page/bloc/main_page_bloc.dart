import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/audio_handler/audio_handler.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_playlists/user_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/common/navigation/navigation_args.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/get_recommendations_for_user.dart';
import 'package:merge_music/service_locator.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final UserTracksCubit userTracksCubit;
  final UserAlbumsCubit userAlbumsCubit;
  final UserPlaylistsCubit userPlaylistsCubit;
  final FollowedPlaylistsCubit followedPlaylistsCubit;
  final AccessTokenCubit accessTokenCubit;

  final GetRecommendationsForUser _getRecommendationsForUser;

  late final StreamSubscription userTracksSubscription;
  late final StreamSubscription userAlbumsSubscription;
  late final StreamSubscription userPlaylistsSubscription;
  late final StreamSubscription followedPlaylistsSubscription;
  late final StreamSubscription accessTokenSubscription;

  MainPageBloc({
    required this.userTracksCubit,
    required this.userAlbumsCubit,
    required this.userPlaylistsCubit,
    required this.followedPlaylistsCubit,
    required this.accessTokenCubit,
    required GetRecommendationsForUser getRecommendationsForUser,
  })  : _getRecommendationsForUser = getRecommendationsForUser,
        super(MainPageInitial()) {
    on<CheckMainPageState>(_onCheckMainPageState);
    on<LoadMainPageData>(_onLoadMainPageData);
    on<OpenShowAllTracksPage>(_onShowAllTracksPage);
    on<OpenShowAllPlaylistsPage>(_onShowAllPlaylistsPage);
    on<OpenPlaylistPage>(_onOpenPlaylistPage);
    on<PlayRecommendations>(_onPlayRecommendations);

    accessTokenSubscription = accessTokenCubit.stream.listen(
      (state) {
        if (state is AccessTokenLoaded) {
          add(LoadMainPageData());
        }
      },
    );

    userTracksSubscription = userTracksCubit.stream.listen((_) {
      add(CheckMainPageState());
    });
    userAlbumsSubscription = userAlbumsCubit.stream.listen((_) {
      add(CheckMainPageState());
    });
    userPlaylistsSubscription = userPlaylistsCubit.stream.listen((_) {
      add(CheckMainPageState());
    });
    followedPlaylistsSubscription = followedPlaylistsCubit.stream.listen((_) {
      add(CheckMainPageState());
    });
  }

  void _onLoadMainPageData(
      LoadMainPageData event, Emitter<MainPageState> emit) {
    userTracksCubit.loadUserTracks();
    userAlbumsCubit.loadUserAlbums();
    userPlaylistsCubit.loadUserPlaylists();
    followedPlaylistsCubit.loadFollowedPlaylists();
  }

  void _onCheckMainPageState(
      CheckMainPageState event, Emitter<MainPageState> emit) {
    final states = [
      userTracksCubit.state,
      userAlbumsCubit.state,
      userPlaylistsCubit.state,
      followedPlaylistsCubit.state,
    ];

    if (states.any((state) =>
        state is UserTracksLoading ||
        state is UserAlbumsLoading ||
        state is UserPlaylistsLoading ||
        state is FollowedPlaylistsLoading)) {
      emit(MainPageLoading());
      return;
    }

    if (states.any((state) =>
        state is UserTracksError ||
        state is UserAlbumsError ||
        state is UserPlaylistsError ||
        state is FollowedPlaylistsError)) {
      emit(MainPageError(message: "Ошибка загрузки данных"));
      return;
    }

    if (states.every((state) =>
        state is UserTracksLoaded ||
        state is UserAlbumsLoaded ||
        state is UserPlaylistsLoaded ||
        state is FollowedPlaylistsLoaded)) {
      emit(MainPageLoaded());
    }
  }

  void _onShowAllTracksPage(
      OpenShowAllTracksPage event, Emitter<MainPageState> emit) {
    router.pushNamed(
      Routes.showAllTracksPage,
      extra: ShowAllTracksPageArgs(title: event.title, audios: event.audios),
    );
  }

  void _onShowAllPlaylistsPage(
      OpenShowAllPlaylistsPage event, Emitter<MainPageState> emit) {
    router.pushNamed(
      Routes.showAllPlaylistsPage,
      extra: ShowAllPlaylistsPageArgs(
          title: event.title, playlists: event.playlists),
    );
  }

  void _onOpenPlaylistPage(
      OpenPlaylistPage event, Emitter<MainPageState> emit) {
    if (event.playlist.type == 0) {
      router.pushNamed(
        Routes.playlistPage,
        extra: PlaylistPageArgs(playlist: event.playlist),
      );
    } else {
      router.pushNamed(
        Routes.albumPage,
        extra: AlbumPageArgs(album: event.playlist),
      );
    }
  }

  void _onPlayRecommendations(
      PlayRecommendations event, Emitter<MainPageState> emit) async {
    final result = await _getRecommendationsForUser(NoParams());
    result.fold(
      (failure) => {},
      (success) {
        final mediaItems = success.map((audio) => audio.toMediaItem()).toList();
        final audioHandler =
            serviceLocator.get<AudioHandler>() as AppAudioHandler;
        audioHandler.playMediaItemList(mediaItems, 0);
      },
    );
  }

  @override
  Future<void> close() {
    accessTokenSubscription.cancel();
    userTracksSubscription.cancel();
    userAlbumsSubscription.cancel();
    userPlaylistsSubscription.cancel();
    followedPlaylistsSubscription.cancel();
    return super.close();
  }
}
