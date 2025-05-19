import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class DeleteAudio implements UseCase<int, AddAndDeletePartialParams> {
  final AudioRepository _audioRepository;
  DeleteAudio(this._audioRepository);

  @override
  Future<Either<Failure, int>> call(AddAndDeletePartialParams params) async {
    return _audioRepository.deleteAudio(params);
  }
}
