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

class OpenPlaylistPage extends MainPageEvent {
  final PlaylistEntity playlist;

  const OpenPlaylistPage({
    required this.playlist,
  });

  @override
  List<Object> get props => [playlist];
}

class PlayRecommendations extends MainPageEvent {}
