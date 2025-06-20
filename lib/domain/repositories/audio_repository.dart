import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

abstract interface class AudioRepository {
  Future<Either<Failure, List<AudioEntity>>> getUserAudios();
  Future<Either<Failure, List<PlaylistEntity>>> getUserAlbums();
  Future<Either<Failure, List<PlaylistEntity>>> getUserPlaylists();
  Future<Either<Failure, List<PlaylistEntity>>> getFollowedPlaylists();
  Future<Either<Failure, List<AudioEntity>>> searchAudio(
      AudioSearchPartialParams params);
  Future<Either<Failure, List<PlaylistEntity>>> searchPlaylists(
      AudioSearchPartialParams params);
  Future<Either<Failure, List<ArtistEntity>>> searchArtists(
      AudioSearchPartialParams params);
  Future<Either<Failure, List<PlaylistEntity>>> searchAlbums(
      AudioSearchPartialParams params);
  Future<Either<Failure, List<AudioEntity>>> getPlaylistAudios(
      GetPlaylistAudiosParams params);
  Future<Either<Failure, ArtistEntity>> getArtistById(
      GetArtistByIdParams params);
  Future<Either<Failure, List<AudioEntity>>> getAudiosByArtist(
      GetArtistByIdParams params);
  Future<Either<Failure, List<PlaylistEntity>>> getAlbumsByArtist(
      GetArtistByIdParams params);
  Future<Either<Failure, List<AudioEntity>>> getRecommendationsForUser();
  Future<Either<Failure, int>> addAudio(AddAndDeletePartialParams params);
  Future<Either<Failure, int>> deleteAudio(AddAndDeletePartialParams params);
  Future<Either<Failure, int>> followPlaylist(AddAndDeletePartialParams params);
  Future<Either<Failure, int>> deletePlaylist(AddAndDeletePartialParams params);
  Future<Either<Failure, void>> restoreAudio(AddAndDeletePartialParams params);
}
