import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class GetArtistById implements UseCase<ArtistEntity, GetArtistByIdParams> {
  final AudioRepository audioRepository;
  GetArtistById(this.audioRepository);

  @override
  Future<Either<Failure, ArtistEntity>> call(GetArtistByIdParams params) async {
    return await audioRepository.getArtistById(params);
  }
}
