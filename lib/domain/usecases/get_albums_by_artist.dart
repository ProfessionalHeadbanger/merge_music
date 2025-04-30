import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetAlbumsByArtist
    implements UseCase<List<PlaylistEntity>, GetArtistByIdParams> {
  final AudioRepository _audioRepository;

  GetAlbumsByArtist(this._audioRepository);

  @override
  Future<Either<Failure, List<PlaylistEntity>>> call(
      GetArtistByIdParams params) async {
    return await _audioRepository.getAlbumsByArtist(params);
  }
}
