part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class LoadMainPageData extends MainPageEvent {}

class CheckMainPageState extends MainPageEvent {}

class OpenShowAllTracksPage extends MainPageEvent {
  final String title;
  final List<AudioEntity> audios;

  const OpenShowAllTracksPage({
    required this.title,
    required this.audios,
  });

  @override
  List<Object> get props => [title, audios];
}

class OpenShowAllPlaylistsPage extends MainPageEvent {
  final String title;
  final List<PlaylistEntity> playlists;

  const OpenShowAllPlaylistsPage({
    required this.title,
    required this.playlists,
  });

  @override
  List<Object> get props => [title, playlists];
}

class OpenAlbumPage extends MainPageEvent {
  final PlaylistEntity album;

  const OpenAlbumPage({
    required this.album,
  });

  @override
  List<Object> get props => [album];
}
