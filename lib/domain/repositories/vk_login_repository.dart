import 'package:fpdart/fpdart.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/vk_login_response_model.dart';

abstract interface class VkLoginRepository {
  Future<Either<Failure, VkLoginResponseModel>> signInVk(VkLoginParams params);
  Future<Either<Failure, void>> request2fa(Request2faParams params);
}
