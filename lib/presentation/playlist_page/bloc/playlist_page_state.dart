part of 'playlist_page_bloc.dart';

sealed class PlaylistPageState extends Equatable {
  const PlaylistPageState();

  @override
  List<Object> get props => [];
}

final class PlaylistPageInitial extends PlaylistPageState {}

final class PlaylistPageLoading extends PlaylistPageState {}

final class PlaylistPageLoaded extends PlaylistPageState {
  final List<AudioEntity> audios;

  const PlaylistPageLoaded({
    required this.audios,
  });

  @override
  List<Object> get props => [audios];
}

final class PlaylistPageError extends PlaylistPageState {
  final String message;

  const PlaylistPageError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
