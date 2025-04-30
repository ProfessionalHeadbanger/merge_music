import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/get_albums_by_artist.dart';
import 'package:merge_music/domain/usecases/get_audios_by_artist.dart';

part 'artist_page_event.dart';
part 'artist_page_state.dart';

class ArtistPageBloc extends Bloc<ArtistPageEvent, ArtistPageState> {
  final GetAlbumsByArtist _getAlbumsByArtist;
  final GetAudiosByArtist _getAudiosByArtist;

  ArtistPageBloc(
      {required GetAlbumsByArtist getAlbumsByArtist,
      required GetAudiosByArtist getAudiosByArtist})
      : _getAlbumsByArtist = getAlbumsByArtist,
        _getAudiosByArtist = getAudiosByArtist,
        super(ArtistPageInitial()) {
    on<LoadArtistPage>(_onLoadArtistPage);
  }

  void _onLoadArtistPage(
      LoadArtistPage event, Emitter<ArtistPageState> emit) async {
    emit(ArtistPageLoading());

    List<AudioEntity>? audios;
    List<PlaylistEntity>? albums;

    final audiosResult = await _getAudiosByArtist(
      GetArtistByIdParams(
        artistId: event.artistId,
      ),
    );
    audiosResult.fold(
      (failure) =>
          emit(ArtistPageError(message: failure.message ?? 'Error occured')),
      (success) => audios = success,
    );

    final albumsResult = await _getAlbumsByArtist(
      GetArtistByIdParams(
        artistId: event.artistId,
      ),
    );
    albumsResult.fold(
      (failure) =>
          emit(ArtistPageError(message: failure.message ?? 'Error occured')),
      (success) => albums = success,
    );

    if (audios != null && albums != null) {
      emit(ArtistPageLoaded(audios: audios!, albums: albums!));
    }
  }
}
