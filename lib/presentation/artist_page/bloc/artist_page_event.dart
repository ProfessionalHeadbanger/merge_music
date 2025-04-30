part of 'artist_page_bloc.dart';

sealed class ArtistPageEvent extends Equatable {
  const ArtistPageEvent();

  @override
  List<Object> get props => [];
}

class LoadArtistPage extends ArtistPageEvent {
  final String artistId;

  const LoadArtistPage({required this.artistId});

  @override
  List<Object> get props => [artistId];
}
