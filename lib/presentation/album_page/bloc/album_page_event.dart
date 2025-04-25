part of 'album_page_bloc.dart';

sealed class AlbumPageEvent extends Equatable {
  const AlbumPageEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaylistAudios extends AlbumPageEvent {
  final int albumId;
  final int ownerId;
  final String? accessKey;

  const LoadPlaylistAudios({
    required this.albumId,
    required this.ownerId,
    this.accessKey,
  });

  @override
  List<Object> get props => [albumId];
}
