import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

abstract interface class AudioRepository {
  Future<Either<Failure, List<AudioEntity>>> getUserAudios();
  Future<Either<Failure, List<PlaylistEntity>>> getUserOwnedPlaylists();
  Future<Either<Failure, List<PlaylistEntity>>> getUserFollowedPlaylists();
  Future<Either<Failure, List<PlaylistEntity>>> getUserAlbums();
}
