part of 'search_page_bloc.dart';

sealed class SearchPageState extends Equatable {
  const SearchPageState();

  @override
  List<Object> get props => [];
}

final class SearchPageInitial extends SearchPageState {}

final class SearchPageLoading extends SearchPageState {}

final class SearchPageError extends SearchPageState {
  final String message;

  const SearchPageError({required this.message});

  @override
  List<Object> get props => [message];
}

final class SearchPageHistoryLoaded extends SearchPageState {
  final List<String> history;

  const SearchPageHistoryLoaded({required this.history});

  @override
  List<Object> get props => [history];
}

final class SearchPageEmptyHistory extends SearchPageState {}

final class SearchPageTracksLoaded extends SearchPageState {
  final List<AudioEntity> tracks;

  const SearchPageTracksLoaded({required this.tracks});

  @override
  List<Object> get props => [tracks];
}

final class SearchPageArtistsLoaded extends SearchPageState {
  final List<ArtistEntity> artists;

  const SearchPageArtistsLoaded({required this.artists});

  @override
  List<Object> get props => [artists];
}

final class SearchPagePlaylistsLoaded extends SearchPageState {
  final List<PlaylistEntity> playlists;

  const SearchPagePlaylistsLoaded({required this.playlists});

  @override
  List<Object> get props => [playlists];
}
