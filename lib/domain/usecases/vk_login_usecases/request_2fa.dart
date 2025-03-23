import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/core/usecases/usecase.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';

class Request2fa implements UseCase<void, Request2faParams> {
  final VkLoginRepository _vkLoginRepository;

  Request2fa(this._vkLoginRepository);

  @override
  Future<Either<Failure, void>> call(Request2faParams params) async {
    return await _vkLoginRepository.request2fa(params);
  }
}
