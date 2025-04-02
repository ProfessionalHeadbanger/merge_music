import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/get_user_albums.dart';

part 'user_albums_state.dart';

class UserAlbumsCubit extends Cubit<UserAlbumsState> {
  final UserCubit _userCubit;
  final GetUserAlbums _getUserAlbums;

  UserAlbumsCubit(GetUserAlbums getUserAlbums, UserCubit userCubit)
      : _getUserAlbums = getUserAlbums,
        _userCubit = userCubit,
        super(UserAlbumsInitial());

  Future<void> loadUserAlbums() async {
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
    emit(UserAlbumsLoading());

    final result = await _getUserAlbums(NoParams());

    result.fold(
      (failure) =>
          emit(UserAlbumsError(message: failure.message ?? 'Error occured')),
      (success) => emit(UserAlbumsLoaded(albums: success)),
    );
  }
}
