import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/usecases/get_user_audios.dart';

part 'user_tracks_state.dart';

class UserTracksCubit extends Cubit<UserTracksState> {
  final GetUserAudios _getUserAudios;

  UserTracksCubit(GetUserAudios getUserAudios)
      : _getUserAudios = getUserAudios,
        super(UserTracksInitial());

  Future<void> loadUserTracks() async {
    emit(UserTracksLoading());

    final result = await _getUserAudios(NoParams());

    result.fold(
      (failure) =>
          emit(UserTracksError(message: failure.message ?? 'Error occured')),
      (success) => emit(UserTracksLoaded(audios: success)),
    );
  }
}
