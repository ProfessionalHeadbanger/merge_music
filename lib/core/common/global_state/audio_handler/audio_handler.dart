import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();

  AppAudioHandler() {
    _player.playbackEventStream.listen(_broadcastState);
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          _player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.pause,
          MediaAction.play,
          MediaAction.stop,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: _player.playing,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        updatePosition: _player.position,
      ),
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final newQueue = [...queue.value, mediaItem];
    queue.add(newQueue);
    this.mediaItem.add(mediaItem);
    await _player.setUrl(mediaItem.id);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;

    final item = queue.value[index];
    mediaItem.add(item);
    await _player.setUrl(item.id);
  }
}
