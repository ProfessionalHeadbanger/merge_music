import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/cover_entity.dart';

abstract interface class DeezerRepository {
  Future<Either<Failure, CoverEntity>> search(
      {required DeezerSearchParams params});
}
