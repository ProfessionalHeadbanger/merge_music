import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetUserAlbums implements UseCase<List<PlaylistEntity>, NoParams> {
  final AudioRepository _audioRepository;
  GetUserAlbums(this._audioRepository);

  @override
  Future<Either<Failure, List<PlaylistEntity>>> call(NoParams params) async {
    return await _audioRepository.getUserAlbums();
  }
}
