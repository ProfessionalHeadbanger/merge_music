part of 'playlist_page_bloc.dart';

sealed class PlaylistPageEvent extends Equatable {
  const PlaylistPageEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaylistAudios extends PlaylistPageEvent {
  final int albumId;
  final int ownerId;
  final String? accessKey;

  const LoadPlaylistAudios({
    required this.albumId,
    required this.ownerId,
    this.accessKey,
  });

  @override
  List<Object> get props => [albumId, ownerId];
}

class FollowPlaylistEvent extends PlaylistPageEvent {
  final PlaylistEntity playlist;
  const FollowPlaylistEvent(this.playlist);
  @override
  List<Object> get props => [playlist];
}

class DeletePlaylistEvent extends PlaylistPageEvent {
  final PlaylistEntity playlist;
  const DeletePlaylistEvent(this.playlist);
  @override
  List<Object> get props => [playlist];
}
