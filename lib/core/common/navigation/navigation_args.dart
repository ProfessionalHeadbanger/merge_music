import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

class ShowAllTracksPageArgs {
  final String title;
  final List<AudioEntity> audios;

  ShowAllTracksPageArgs({
    required this.title,
    required this.audios,
  });
}

class ShowAllPlaylistsPageArgs {
  final String title;
  final List<PlaylistEntity> playlists;

  ShowAllPlaylistsPageArgs({
    required this.title,
    required this.playlists,
  });
}

class ShowAllArtistsPageArgs {
  final String title;
  final List<ArtistEntity> artists;

  ShowAllArtistsPageArgs({
    required this.title,
    required this.artists,
  });
}

class AlbumPageArgs {
  final PlaylistEntity album;

  AlbumPageArgs({
    required this.album,
  });
}

class PlaylistPageArgs {
  final PlaylistEntity playlist;

  PlaylistPageArgs({
    required this.playlist,
  });
}

class ArtistPageArgs {
  final ArtistEntity artist;

  ArtistPageArgs({
    required this.artist,
  });
}
