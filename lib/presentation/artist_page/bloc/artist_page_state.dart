part of 'artist_page_bloc.dart';

sealed class ArtistPageState extends Equatable {
  const ArtistPageState();

  @override
  List<Object> get props => [];
}

final class ArtistPageInitial extends ArtistPageState {}

final class ArtistPageLoading extends ArtistPageState {}

final class ArtistPageLoaded extends ArtistPageState {
  final List<PlaylistEntity> albums;
  final List<AudioEntity> audios;

  const ArtistPageLoaded({
    required this.albums,
    required this.audios,
  });

  @override
  List<Object> get props => [albums, audios];
}

final class ArtistPageError extends ArtistPageState {
  final String message;

  const ArtistPageError({required this.message});
}
