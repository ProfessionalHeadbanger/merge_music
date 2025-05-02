part of 'audio_player_bloc.dart';

class AudioPlayerState extends Equatable {
  final List<AudioEntity> queue;
  final int currentIndex;
  final bool isPlaying;

  const AudioPlayerState({
    required this.queue,
    required this.currentIndex,
    required this.isPlaying,
  });

  AudioPlayerState copyWith({
    List<AudioEntity>? queue,
    int? currentIndex,
    bool? isPlaying,
  }) {
    return AudioPlayerState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [queue, currentIndex, isPlaying];
}
