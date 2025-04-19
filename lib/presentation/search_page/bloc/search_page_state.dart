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

final class SearchPageLoaded extends SearchPageState {
  final List<AudioEntity> tracks;
  final List<ArtistEntity> artists;
  final List<PlaylistEntity> playlists;
  final List<PlaylistEntity> albums;

  const SearchPageLoaded({
    required this.tracks,
    required this.artists,
    required this.playlists,
    required this.albums,
  });

  @override
  List<Object> get props => [tracks, artists, playlists, albums];
}
