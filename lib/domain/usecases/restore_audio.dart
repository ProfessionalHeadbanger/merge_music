import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class RestoreAudio implements UseCase<void, AddAndDeletePartialParams> {
  final AudioRepository _audioRepository;
  RestoreAudio(this._audioRepository);

  @override
  Future<Either<Failure, void>> call(AddAndDeletePartialParams params) async {
    return _audioRepository.restoreAudio(params);
  }
}
