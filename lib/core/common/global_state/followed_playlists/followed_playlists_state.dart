part of 'followed_playlists_cubit.dart';

sealed class FollowedPlaylistsState extends Equatable {
  const FollowedPlaylistsState();

  @override
  List<Object> get props => [];
}

final class FollowedPlaylistsInitial extends FollowedPlaylistsState {}

final class FollowedPlaylistsLoading extends FollowedPlaylistsState {}

final class FollowedPlaylistsLoaded extends FollowedPlaylistsState {
  final List<PlaylistEntity> playlists;

  const FollowedPlaylistsLoaded({
    required this.playlists,
  });

  @override
  List<Object> get props => [playlists];
}

final class FollowedPlaylistsError extends FollowedPlaylistsState {
  final String message;

  const FollowedPlaylistsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
