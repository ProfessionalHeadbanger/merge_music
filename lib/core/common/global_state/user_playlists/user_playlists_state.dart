part of 'user_playlists_cubit.dart';

sealed class UserPlaylistsState extends Equatable {
  const UserPlaylistsState();

  @override
  List<Object> get props => [];
}

final class UserPlaylistsInitial extends UserPlaylistsState {}

final class UserPlaylistsLoading extends UserPlaylistsState {}

final class UserPlaylistsLoaded extends UserPlaylistsState {
  final List<PlaylistEntity> playlists;

  const UserPlaylistsLoaded({
    required this.playlists,
  });

  @override
  List<Object> get props => [playlists];
}

final class UserPlaylistsError extends UserPlaylistsState {
  final String message;

  const UserPlaylistsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
