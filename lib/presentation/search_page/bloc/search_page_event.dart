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

class SearchTracksEvent extends SearchPageEvent {
  final String query;

  const SearchTracksEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchArtistsEvent extends SearchPageEvent {
  final String query;

  const SearchArtistsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchPlaylistsEvent extends SearchPageEvent {
  final String query;

  const SearchPlaylistsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class ClearSearchTextField extends SearchPageEvent {}
