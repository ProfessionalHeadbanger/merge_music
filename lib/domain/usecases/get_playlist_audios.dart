import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetPlaylistAudios
    implements UseCase<List<AudioEntity>, GetPlaylistAudiosParams> {
  final AudioRepository audioRepository;
  GetPlaylistAudios(this.audioRepository);

  @override
  Future<Either<Failure, List<AudioEntity>>> call(
      GetPlaylistAudiosParams params) async {
    return await audioRepository.getPlaylistAudios(params);
  }
}
