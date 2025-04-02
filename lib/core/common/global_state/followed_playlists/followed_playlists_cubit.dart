import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/get_followed_playlists.dart';

part 'followed_playlists_state.dart';

class FollowedPlaylistsCubit extends Cubit<FollowedPlaylistsState> {
  final UserCubit _userCubit;
  final GetFollowedPlaylists _getFollowedPlaylists;

  FollowedPlaylistsCubit(
      GetFollowedPlaylists getFollowedPlaylists, UserCubit userCubit)
      : _getFollowedPlaylists = getFollowedPlaylists,
        _userCubit = userCubit,
        super(FollowedPlaylistsInitial());

  Future<void> loadFollowedPlaylists() async {
    if (_userCubit.state is UserLoggedIn) {
      await load();
    } else {
      late StreamSubscription userSubscription;
      userSubscription = _userCubit.stream.listen(
        (state) async {
          if (state is UserLoggedIn) {
            await load();
            userSubscription.cancel();
          }
        },
      );
    }
  }

  Future<void> load() async {
    emit(FollowedPlaylistsLoading());

    final result = await _getFollowedPlaylists(NoParams());

    result.fold(
      (failure) => emit(
          FollowedPlaylistsError(message: failure.message ?? 'Error occured')),
      (success) => emit(FollowedPlaylistsLoaded(playlists: success)),
    );
  }
}
