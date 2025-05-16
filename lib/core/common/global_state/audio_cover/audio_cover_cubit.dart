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
    final params = DeezerSearchParams(
      artist: audio.artist,
      track: audio.title,
      limit: 1,
      order: 'RANKING',
      strict: 'on',
    );

    final result = await _getAudioCover(params);
    result.fold(
      (failure) => null,
      (success) {
        final updatedAudio = audio.copyWith(
          coverSmall: success.coverSmall,
          coverXL: success.coverXL,
        );
        emit({...state, audio.id: updatedAudio});
      },
    );
  }
}
