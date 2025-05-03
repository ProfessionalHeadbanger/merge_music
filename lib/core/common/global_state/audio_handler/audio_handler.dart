import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();

  AppAudioHandler() {
    _player.playbackEventStream.listen(_broadcastState);

    _player.currentIndexStream.listen((index) {
      if (index != null && index < queue.value.length) {
        mediaItem.add(queue.value[index]);
      }
    });

    _player.positionStream.listen((_) {
      _broadcastState(_player.playbackEvent);
    });

    _player.playerStateStream.listen((_) {
      _broadcastState(_player.playbackEvent);
    });
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    final processingState = {
      ProcessingState.idle: AudioProcessingState.idle,
      ProcessingState.loading: AudioProcessingState.loading,
      ProcessingState.buffering: AudioProcessingState.buffering,
      ProcessingState.ready: AudioProcessingState.ready,
      ProcessingState.completed: AudioProcessingState.completed,
    }[_player.processingState]!;

    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          MediaAction.pause,
          MediaAction.play,
          MediaAction.stop,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: processingState,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _player.currentIndex,
      ),
    );
  }

  @override
  Future<void> play() async => _player.play();

  @override
  Future<void> pause() async => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    _broadcastState(_player.playbackEvent);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    await _player.seek(Duration.zero, index: index);
    await play();
  }

  @override
  Future<void> skipToNext() async {
    await _player.seekToNext();
    await play();
  }

  @override
  Future<void> skipToPrevious() async {
    await _player.seekToPrevious();
    await play();
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final newQueue = [...queue.value, mediaItem];
    queue.add(newQueue);
    this.mediaItem.add(mediaItem);
    await _player.setUrl(mediaItem.id);
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    queue.add(newQueue);

    final audioSources = newQueue.map(
      (item) => AudioSource.uri(Uri.parse(item.id), tag: item),
    );

    await _player.setAudioSource(
      ConcatenatingAudioSource(children: audioSources.toList()),
      initialIndex: 0,
    );
  }

  Future<void> playMediaItemList(List<MediaItem> items, int indexToPlay) async {
    final currentQueue = queue.value;
    final currentMediaItem = mediaItem.value;

    final isSameQueue = currentQueue.length == items.length &&
        List.generate(items.length, (i) => items[i].id == currentQueue[i].id)
            .every((e) => e);

    final isSameItem = currentMediaItem?.id == items[indexToPlay].id;

    if (isSameQueue) {
      if (!isSameItem) {
        await skipToQueueItem(indexToPlay);
      }
      return;
    }

    await stop();
    await updateQueue(items);
    await skipToQueueItem(indexToPlay);
  }
}
