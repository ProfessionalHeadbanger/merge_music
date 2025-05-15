import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';

abstract interface class ITunesRepository {
  Future<Either<Failure, String?>> search({required ITunesSearchParams params});
}
