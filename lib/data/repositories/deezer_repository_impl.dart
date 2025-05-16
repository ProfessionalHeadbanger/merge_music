import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/data_sources/remote/deezer_remote_data_source.dart';
import 'package:merge_music/domain/entities/cover_entity.dart';
import 'package:merge_music/domain/repositories/deezer_repository.dart';
import 'package:merge_music/service_locator.dart';

class DeezerRepositoryImpl implements DeezerRepository {
  final DeezerRemoteDataSource deezerRemoteDataSource;

  DeezerRepositoryImpl(this.deezerRemoteDataSource);

  @override
  Future<Either<Failure, CoverEntity>> search(
      {required DeezerSearchParams params}) async {
    try {
      final result = await deezerRemoteDataSource.search(params: params);
      return right(result);
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }
}
