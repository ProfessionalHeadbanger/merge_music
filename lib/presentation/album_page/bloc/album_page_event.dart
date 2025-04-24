part of 'album_page_bloc.dart';

sealed class AlbumPageEvent extends Equatable {
  const AlbumPageEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaylistAudios extends AlbumPageEvent {
  final int albumId;

  const LoadPlaylistAudios({required this.albumId});

  @override
  List<Object> get props => [albumId];
}
