import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class SearchAudio
    implements UseCase<List<AudioEntity>, AudioSearchPartialParams> {
  final AudioRepository audioRepository;
  SearchAudio(this.audioRepository);

  @override
  Future<Either<Failure, List<AudioEntity>>> call(
      AudioSearchPartialParams params) async {
    return await audioRepository.searchAudio(params);
  }
}
