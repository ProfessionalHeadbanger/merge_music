import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/get_user_playlists.dart';

part 'user_playlists_state.dart';

class UserPlaylistsCubit extends Cubit<UserPlaylistsState> {
  final UserCubit _userCubit;
  final GetUserPlaylists _getUserPlaylists;

  UserPlaylistsCubit(GetUserPlaylists getUserPlaylists, UserCubit userCubit)
      : _getUserPlaylists = getUserPlaylists,
        _userCubit = userCubit,
        super(UserPlaylistsInitial());

  Future<void> loadUserPlaylists() async {
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
    emit(UserPlaylistsLoading());

    final result = await _getUserPlaylists(NoParams());

    result.fold(
      (failure) =>
          emit(UserPlaylistsError(message: failure.message ?? 'Error occured')),
      (success) => emit(UserPlaylistsLoaded(playlists: success)),
    );
  }
}
