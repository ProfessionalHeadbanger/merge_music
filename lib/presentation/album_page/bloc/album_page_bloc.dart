import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/usecases/get_playlist_audios.dart';

part 'album_page_event.dart';
part 'album_page_state.dart';

class AlbumPageBloc extends Bloc<AlbumPageEvent, AlbumPageState> {
  final GetPlaylistAudios _getPlaylistAudios;

  AlbumPageBloc({required GetPlaylistAudios getPlaylistAudios})
      : _getPlaylistAudios = getPlaylistAudios,
        super(AlbumPageInitial()) {
    on<LoadPlaylistAudios>(_onLoadPlaylistAudios);
  }

  void _onLoadPlaylistAudios(
      LoadPlaylistAudios event, Emitter<AlbumPageState> emit) async {
    emit(AlbumPageLoading());

    final result = await _getPlaylistAudios(
      GetPlaylistAudiosParams(
        albumId: event.albumId,
        accessKey: event.accessKey,
        ownerId: event.ownerId,
      ),
    );
    result.fold(
      (failure) =>
          emit(AlbumPageError(message: failure.message ?? 'Error occured')),
      (success) => emit(AlbumPageLoaded(audios: success)),
    );
  }
}
