import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:merge_music/core/common/global_state/current_audio/current_audio_cubit.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/service_locator.dart';

class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer();

  List<AudioEntity> _currentEntities = [];

  AppAudioHandler() {
    _player.playbackEventStream.listen(_broadcastState);

    _player.currentIndexStream.listen((index) {
      if (index != null && index < queue.value.length) {
        mediaItem.add(queue.value[index]);
        serviceLocator.get<CurrentAudioCubit>().set(_currentEntities[index]);
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

    final repeatMode = () {
      switch (_player.loopMode) {
        case LoopMode.off:
          return AudioServiceRepeatMode.none;
        case LoopMode.one:
          return AudioServiceRepeatMode.one;
        case LoopMode.all:
          return AudioServiceRepeatMode.all;
      }
    }();

    final shuffleMode = () {
      switch (_player.shuffleModeEnabled) {
        case false:
          return AudioServiceShuffleMode.none;
        case true:
          return AudioServiceShuffleMode.all;
      }
    }();

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
        repeatMode: repeatMode,
        shuffleMode: shuffleMode,
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
    mediaItem.add(null);
    queue.add([]);
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

  Future<void> playAudioEntityList(
      List<AudioEntity> items, int indexToPlay) async {
    _currentEntities = items;
    final mediaItems = items.map((e) => e.toMediaItem()).toList();
    await _playMediaItemList(mediaItems, indexToPlay);
    serviceLocator.get<CurrentAudioCubit>().set(items[indexToPlay]);
  }

  Future<void> _playMediaItemList(
      List<MediaItem> items, int indexToPlay) async {
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

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        await _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.all:
        await _player.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.one:
        await _player.setLoopMode(LoopMode.one);
        break;
      default:
        throw Exception('Unknown repeat mode: $repeatMode');
    }
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    switch (shuffleMode) {
      case AudioServiceShuffleMode.none:
        await _player.setShuffleModeEnabled(false);
        break;
      case AudioServiceShuffleMode.all:
        await _player.setShuffleModeEnabled(true);
        break;
      default:
        throw Exception('Unknown shuffle mode: $shuffleMode');
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
  }
}
