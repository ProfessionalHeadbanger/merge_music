part of 'show_all_artists_page_bloc.dart';

sealed class ShowAllArtistsPageEvent extends Equatable {
  const ShowAllArtistsPageEvent();

  @override
  List<Object> get props => [];
}

class OpenArtistPage extends ShowAllArtistsPageEvent {
  final ArtistEntity artist;

  const OpenArtistPage({
    required this.artist,
  });

  @override
  List<Object> get props => [artist];
}
