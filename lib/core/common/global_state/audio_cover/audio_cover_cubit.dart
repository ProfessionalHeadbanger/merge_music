import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/usecases/get_audio_cover.dart';

class AudioCoverCubit extends Cubit<Map<int, AudioEntity>> {
  final GetAudioCover _getAudioCover;

  AudioCoverCubit(GetAudioCover getAudioCover)
      : _getAudioCover = getAudioCover,
        super({});

  Future<void> fetchAudioCover(AudioEntity audio) async {
    final params = ITunesSearchParams(
      artistName: audio.artist,
      trackName: audio.title,
      limit: 1,
    );

    final result = await _getAudioCover(params);
    result.fold(
      (failure) => null,
      (success) {
        if (success != null) {
          final artworkUrl1000 = success.replaceAll('100x100bb', '1000x1000bb');
          final updatedAudio = audio.copyWith(
            coverUrl100: success,
            coverUrl1000: artworkUrl1000,
          );
          emit({...state, audio.id: updatedAudio});
        }
      },
    );
  }
}
