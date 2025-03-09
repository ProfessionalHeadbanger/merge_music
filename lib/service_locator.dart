import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton<Logger>(
    Logger(),
  );

  serviceLocator.registerLazySingleton<AccessTokenCubit>(
    () => AccessTokenCubit(),
  );

  serviceLocator.registerLazySingleton<VkLoginBloc>(
    () => VkLoginBloc(),
  );
}
