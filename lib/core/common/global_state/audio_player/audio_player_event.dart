part of 'audio_player_bloc.dart';

sealed class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class Play extends AudioPlayerEvent {
  final List<AudioEntity> queue;
  final int startIndex;

  const Play({
    required this.queue,
    required this.startIndex,
  });

  @override
  List<Object> get props => [queue, startIndex];
}

class Pause extends AudioPlayerEvent {}

class Resume extends AudioPlayerEvent {}

class SkipToNext extends AudioPlayerEvent {}

class SkipToPrevious extends AudioPlayerEvent {}

class Seek extends AudioPlayerEvent {
  final Duration position;

  const Seek({
    required this.position,
  });

  @override
  List<Object> get props => [position];
}

class _UpdateIndex extends AudioPlayerEvent {
  final int index;
  const _UpdateIndex(this.index);
}

class _UpdateIsPlaying extends AudioPlayerEvent {
  final bool isPlaying;
  const _UpdateIsPlaying(this.isPlaying);
}
