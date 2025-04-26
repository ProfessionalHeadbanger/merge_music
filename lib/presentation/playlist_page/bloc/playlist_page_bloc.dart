import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/usecases/get_playlist_audios.dart';

part 'playlist_page_event.dart';
part 'playlist_page_state.dart';

class PlaylistPageBloc extends Bloc<PlaylistPageEvent, PlaylistPageState> {
  final GetPlaylistAudios _getPlaylistAudios;

  PlaylistPageBloc({required GetPlaylistAudios getPlaylistAudios})
      : _getPlaylistAudios = getPlaylistAudios,
        super(PlaylistPageInitial()) {
    on<LoadPlaylistAudios>(_onLoadPlaylistAudios);
  }

  void _onLoadPlaylistAudios(
      LoadPlaylistAudios event, Emitter<PlaylistPageState> emit) async {
    emit(PlaylistPageLoading());

    final result = await _getPlaylistAudios(
      GetPlaylistAudiosParams(
        albumId: event.albumId,
        accessKey: event.accessKey,
        ownerId: event.ownerId,
      ),
    );
    result.fold(
      (failure) =>
          emit(PlaylistPageError(message: failure.message ?? 'Error occured')),
      (success) => emit(PlaylistPageLoaded(audios: success)),
    );
  }
}
