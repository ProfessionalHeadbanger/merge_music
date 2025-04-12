import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetUserPlaylists implements UseCase<List<PlaylistEntity>, NoParams> {
  final AudioRepository audioRepository;
  GetUserPlaylists(this.audioRepository);

  @override
  Future<Either<Failure, List<PlaylistEntity>>> call(NoParams params) async {
    return await audioRepository.getUserPlaylists();
  }
}
