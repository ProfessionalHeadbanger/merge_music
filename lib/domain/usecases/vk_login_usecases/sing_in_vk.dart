import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/data/models/vk_login_response_model.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';

class SingInVk implements UseCase<VkLoginResponseModel, VkLoginParams> {
  final VkLoginRepository _vkLoginRepository;

  SingInVk(this._vkLoginRepository);

  @override
  Future<Either<Failure, VkLoginResponseModel>> call(
      VkLoginParams params) async {
    return await _vkLoginRepository.signInVk(params);
  }
}
