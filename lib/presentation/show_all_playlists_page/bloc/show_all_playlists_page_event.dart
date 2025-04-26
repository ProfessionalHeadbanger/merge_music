part of 'show_all_playlists_page_bloc.dart';

sealed class ShowAllPlaylistsPageEvent extends Equatable {
  const ShowAllPlaylistsPageEvent();

  @override
  List<Object> get props => [];
}

class OpenPlaylistPage extends ShowAllPlaylistsPageEvent {
  final PlaylistEntity playlist;

  const OpenPlaylistPage({
    required this.playlist,
  });

  @override
  List<Object> get props => [playlist];
}
