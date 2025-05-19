import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/audio_handler/audio_handler.dart';
import 'package:merge_music/core/common/global_state/current_audio/current_audio_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/global_state/user_tracks/user_tracks_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/usecases/add_audio.dart';
import 'package:merge_music/domain/usecases/delete_audio.dart';
import 'package:merge_music/domain/usecases/restore_audio.dart';
import 'package:merge_music/service_locator.dart';

part 'player_page_event.dart';
part 'player_page_state.dart';

class PlayerPageBloc extends Bloc<PlayerPageEvent, PlayerPageState> {
  final AddAudio _addAudio;
  final DeleteAudio _deleteAudio;
  final RestoreAudio _restoreAudio;

  final CurrentAudioCubit currentAudioCubit;

  final Set<int> _recentlyDeletedAudioIds = {};
  Set<int> get recentlyDeletedAudioIds => _recentlyDeletedAudioIds;

  PlayerPageBloc({
    required AddAudio addAudio,
    required DeleteAudio deleteAudio,
    required RestoreAudio restoreAudio,
    required this.currentAudioCubit,
  })  : _addAudio = addAudio,
        _deleteAudio = deleteAudio,
        _restoreAudio = restoreAudio,
        super(PlayerPageInitial()) {
    on<AddAudioEvent>(_onAddAudioEvent);
    on<DeleteAudioEvent>(_onDeleteAudioEvent);
    on<RestoreAudioEvent>(_onRestoreAudioEvent);
  }

  Future<void> _onAddAudioEvent(
      AddAudioEvent event, Emitter<PlayerPageState> emit) async {
    final result = await _addAudio(
      AddAndDeletePartialParams(
        id: event.audio.id,
        ownerId: event.audio.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        final userState = serviceLocator.get<UserCubit>().state as UserLoggedIn;
        final newAudio = event.audio.copyWith(
          id: success,
          ownerId: userState.user.id,
          like: true,
        );

        final userTracksCubit = serviceLocator.get<UserTracksCubit>();
        final userTracksState = userTracksCubit.state as UserTracksLoaded;
        userTracksCubit.emit(
          UserTracksLoaded(
            audios: [newAudio, ...userTracksState.audios],
          ),
        );

        final handler = serviceLocator.get<AudioHandler>() as AppAudioHandler;
        final currentItem = handler.mediaItem.value;
        final newExtras = Map<String, dynamic>.from(currentItem!.extras ?? {});
        newExtras['like'] = true;
        handler.mediaItem.add(currentItem.copyWith(extras: newExtras));

        currentAudioCubit.set(newAudio);
      },
    );
  }

  Future<void> _onDeleteAudioEvent(
      DeleteAudioEvent event, Emitter<PlayerPageState> emit) async {
    final result = await _deleteAudio(
      AddAndDeletePartialParams(
        id: event.audio.id,
        ownerId: event.audio.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        _recentlyDeletedAudioIds.add(event.audio.id);

        final userTracksCubit = serviceLocator.get<UserTracksCubit>();
        final userTracksState = userTracksCubit.state as UserTracksLoaded;
        userTracksCubit.emit(
          UserTracksLoaded(
            audios: userTracksState.audios
                .where((audio) => audio.id != event.audio.id)
                .toList(),
          ),
        );

        final handler = serviceLocator.get<AudioHandler>() as AppAudioHandler;
        final currentItem = handler.mediaItem.value;
        final newExtras = Map<String, dynamic>.from(currentItem!.extras ?? {});
        newExtras['like'] = null;
        handler.mediaItem.add(currentItem.copyWith(extras: newExtras));

        final newAudio = event.audio.copyWith(
          like: null,
        );
        currentAudioCubit.set(newAudio);
      },
    );
  }

  _onRestoreAudioEvent(
      RestoreAudioEvent event, Emitter<PlayerPageState> emit) async {
    final result = await _restoreAudio(
      AddAndDeletePartialParams(
        id: event.audio.id,
        ownerId: event.audio.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        _recentlyDeletedAudioIds.remove(event.audio.id);

        final newAudio = event.audio.copyWith(like: true);

        final userTracksCubit = serviceLocator.get<UserTracksCubit>();
        final userTracksState = userTracksCubit.state as UserTracksLoaded;
        userTracksCubit.emit(
          UserTracksLoaded(
            audios: [newAudio, ...userTracksState.audios],
          ),
        );

        final handler = serviceLocator.get<AudioHandler>() as AppAudioHandler;
        final currentItem = handler.mediaItem.value;
        final newExtras = Map<String, dynamic>.from(currentItem!.extras ?? {});
        newExtras['like'] = true;
        handler.mediaItem.add(currentItem.copyWith(extras: newExtras));

        currentAudioCubit.set(newAudio);
      },
    );
  }
}
