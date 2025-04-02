import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

abstract interface class AudioRepository {
  Future<Either<Failure, List<AudioEntity>>> getUserAudios();
  Future<Either<Failure, List<PlaylistEntity>>> getUserAlbums();
  Future<Either<Failure, List<PlaylistEntity>>> getUserPlaylists();
  Future<Either<Failure, List<PlaylistEntity>>> getFollowedPlaylists();
}
