import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/data_sources/remote/vk_login_data_source.dart';
import 'package:merge_music/domain/entities/user_entity.dart';
import 'package:merge_music/domain/repositories/vk_login_repository.dart';
import 'package:merge_music/service_locator.dart';

class VkLoginRepositoryImpl implements VkLoginRepository {
  final VkLoginDataSource vkLoginDataSource;

  VkLoginRepositoryImpl(this.vkLoginDataSource);

  @override
  Future<Either<Failure, UserEntity>> getLoggedUser() async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final token = tokenState.token;
        final user = await vkLoginDataSource.getUser(
          params: UserParams(
            fields: ['photo_50', 'photo_100', 'photo_max'],
            accessToken: token,
            v: ApiConstants.v,
          ),
        );
        return right(user);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }
}
