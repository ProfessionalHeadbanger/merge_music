import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/data_sources/remote/itunes_remote_data_source.dart';
import 'package:merge_music/domain/repositories/itunes_repository.dart';
import 'package:merge_music/service_locator.dart';

class ITunesRepositoryImpl implements ITunesRepository {
  final ITunesRemoteDataSource iTunesDataSource;

  ITunesRepositoryImpl(this.iTunesDataSource);

  @override
  Future<Either<Failure, String?>> search(
      {required ITunesSearchParams params}) async {
    try {
      final result = await iTunesDataSource.search(params: params);
      return right(result);
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }
}
