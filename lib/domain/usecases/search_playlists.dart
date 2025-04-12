import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';

class SearchPlaylists
    implements UseCase<List<PlaylistEntity>, AudioSearchPartialParams> {
  final AudioRepository audioRepository;
  SearchPlaylists(this.audioRepository);

  @override
  Future<Either<Failure, List<PlaylistEntity>>> call(
      AudioSearchPartialParams params) async {
    return await audioRepository.searchPlaylists(params);
  }
}
