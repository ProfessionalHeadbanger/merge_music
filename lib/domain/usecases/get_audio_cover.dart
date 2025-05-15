import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/repositories/itunes_repository.dart';

class GetAudioCover implements UseCase<String?, ITunesSearchParams> {
  final ITunesRepository iTunesRepository;
  GetAudioCover(this.iTunesRepository);

  @override
  Future<Either<Failure, String?>> call(ITunesSearchParams params) async {
    return iTunesRepository.search(params: params);
  }
}
