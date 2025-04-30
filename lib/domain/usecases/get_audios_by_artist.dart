import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetAudiosByArtist
    implements UseCase<List<AudioEntity>, GetArtistByIdParams> {
  final AudioRepository _audioRepository;

  GetAudiosByArtist(this._audioRepository);

  @override
  Future<Either<Failure, List<AudioEntity>>> call(
      GetArtistByIdParams params) async {
    return await _audioRepository.getAudiosByArtist(params);
  }
}
