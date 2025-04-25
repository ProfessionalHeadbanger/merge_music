part of 'show_all_playlists_page_bloc.dart';

sealed class ShowAllPlaylistsPageEvent extends Equatable {
  const ShowAllPlaylistsPageEvent();

  @override
  List<Object> get props => [];
}

class OpenAlbumPage extends ShowAllPlaylistsPageEvent {
  final PlaylistEntity album;

  const OpenAlbumPage({
    required this.album,
  });

  @override
  List<Object> get props => [album];
}
