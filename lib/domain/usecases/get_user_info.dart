import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/entities/user_entity.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';

class GetUserInfo implements UseCase<UserEntity, NoParams> {
  final VkLoginRepository _vkLoginRepository;
  GetUserInfo(this._vkLoginRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return _vkLoginRepository.getLoggedUser();
  }
}
