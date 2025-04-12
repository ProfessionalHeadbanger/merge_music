import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/domain/entities/user_entity.dart';

abstract interface class VkLoginRepository {
  Future<Either<Failure, UserEntity>> getLoggedUser();
}
