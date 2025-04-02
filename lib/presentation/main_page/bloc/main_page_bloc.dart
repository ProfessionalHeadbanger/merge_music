import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final UserTracksCubit userTracksCubit;
  final UserAlbumsCubit userAlbumsCubit;
  final AccessTokenCubit accessTokenCubit;

  late final StreamSubscription userTracksSubscription;
  late final StreamSubscription userAlbumsSubscription;
  late final StreamSubscription accessTokenSubscription;

  MainPageBloc({
    required this.userTracksCubit,
    required this.userAlbumsCubit,
    required this.accessTokenCubit,
  }) : super(MainPageInitial()) {
    on<CheckMainPageState>(_onCheckMainPageState);
    on<LoadMainPageData>(_onLoadMainPageData);

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
  }

  void _onLoadMainPageData(
      LoadMainPageData event, Emitter<MainPageState> emit) {
    userTracksCubit.loadUserTracks();
    userAlbumsCubit.loadUserAlbums();
  }

  void _onCheckMainPageState(
      CheckMainPageState event, Emitter<MainPageState> emit) {
    final states = [
      userTracksCubit.state,
      userAlbumsCubit.state,
    ];

    if (states.any(
        (state) => state is UserTracksLoading || state is UserAlbumsLoading)) {
      emit(MainPageLoading());
      return;
    }

    if (states
        .any((state) => state is UserTracksError || state is UserAlbumsError)) {
      emit(MainPageError(message: "Ошибка загрузки данных"));
      return;
    }

    if (states.every(
        (state) => state is UserTracksLoaded || state is UserAlbumsLoaded)) {
      emit(MainPageLoaded());
    }
  }

  @override
  Future<void> close() {
    accessTokenSubscription.cancel();
    userTracksSubscription.cancel();
    userAlbumsSubscription.cancel();
    return super.close();
  }
}
