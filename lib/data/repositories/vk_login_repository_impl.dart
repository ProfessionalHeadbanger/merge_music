import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/data_sources/remote/vk_login_data_source.dart';
import 'package:merge_music/data/models/vk_login_response_model.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';
import 'package:merge_music/service_locator.dart';

class VkLoginRepositoryImpl implements VkLoginRepository {
  VkLoginDataSource vkLoginDataSource;

  VkLoginRepositoryImpl(this.vkLoginDataSource);

  @override
  Future<Either<Failure, VkLoginResponseModel>> signInVk(
      VkLoginParams params) async {
    try {
      final response = await vkLoginDataSource.authorize(params: params);
      return right(response);
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> request2fa(Request2faParams params) async {
    try {
      await vkLoginDataSource.request2fa(redirectUri: params.redirectUri);
      return right(null);
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }
}
