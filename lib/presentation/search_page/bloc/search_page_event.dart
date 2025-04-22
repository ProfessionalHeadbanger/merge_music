part of 'search_page_bloc.dart';

sealed class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchHistory extends SearchPageEvent {}

class ClearSearchHistory extends SearchPageEvent {}

class AddQueryToHistory extends SearchPageEvent {
  final String query;

  const AddQueryToHistory({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchByQuery extends SearchPageEvent {
  final String query;

  const SearchByQuery({required this.query});

  @override
  List<Object> get props => [query];
}

class ClearSearchTextField extends SearchPageEvent {}

class OpenShowAllTracksPage extends SearchPageEvent {
  final String title;
  final List<AudioEntity> audios;

  const OpenShowAllTracksPage({
    required this.title,
    required this.audios,
  });

  @override
  List<Object> get props => [title, audios];
}

class OpenShowAllPlaylistsPage extends SearchPageEvent {
  final String title;
  final List<PlaylistEntity> playlists;

  const OpenShowAllPlaylistsPage({
    required this.title,
    required this.playlists,
  });

  @override
  List<Object> get props => [title, playlists];
}

class OpenShowAllArtistsPage extends SearchPageEvent {
  final String title;
  final List<ArtistEntity> artists;

  const OpenShowAllArtistsPage({
    required this.title,
    required this.artists,
  });

  @override
  List<Object> get props => [title, artists];
}
