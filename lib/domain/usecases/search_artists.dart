import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class SearchArtists
    implements UseCase<List<ArtistEntity>, AudioSearchPartialParams> {
  final AudioRepository audioRepository;
  SearchArtists(this.audioRepository);

  @override
  Future<Either<Failure, List<ArtistEntity>>> call(
      AudioSearchPartialParams params) async {
    return await audioRepository.searchArtists(params);
  }
}
