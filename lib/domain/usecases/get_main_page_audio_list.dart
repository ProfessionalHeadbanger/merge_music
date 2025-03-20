import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetMainPageAudioList implements UseCase<List<AudioEntity>, NoParams> {
  final AudioRepository _audioRepository;
  GetMainPageAudioList(this._audioRepository);

  @override
  Future<Either<Failure, List<AudioEntity>>> call(NoParams params) async {
    return await _audioRepository.getMainPageAudioList();
  }
}
