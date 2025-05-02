import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioHandler _audioHandler;

  AudioPlayerBloc(this._audioHandler)
      : super(AudioPlayerState(queue: [], currentIndex: 0, isPlaying: false)) {
    on<Play>(_onPlay);
    on<Pause>((_, emit) => _audioHandler.pause());
    on<Resume>((_, emit) => _audioHandler.play());
    on<SkipToNext>((_, emit) => _audioHandler.skipToNext());
    on<SkipToPrevious>((_, emit) => _audioHandler.skipToPrevious());
    on<Seek>((event, emit) => _audioHandler.seek(event.position));
  }

  Future<void> _onPlay(Play event, Emitter<AudioPlayerState> emit) async {
    final items = event.queue.map((audio) {
      return MediaItem(id: audio.url, title: audio.title);
    }).toList();

    await _audioHandler.stop();
    await _audioHandler.updateQueue(items);
    await _audioHandler.skipToQueueItem(event.startIndex);
    await _audioHandler.play();

    emit(state.copyWith(
      queue: event.queue,
      currentIndex: event.startIndex,
      isPlaying: true,
    ));
  }
}
