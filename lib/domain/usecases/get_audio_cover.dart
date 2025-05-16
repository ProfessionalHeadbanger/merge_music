import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/cover_entity.dart';
import 'package:merge_music/domain/repositories/deezer_repository.dart';

class GetAudioCover implements UseCase<CoverEntity, DeezerSearchParams> {
  final DeezerRepository deezerRepository;
  GetAudioCover(this.deezerRepository);

  @override
  Future<Either<Failure, CoverEntity>> call(DeezerSearchParams params) async {
    return deezerRepository.search(params: params);
  }
}
