import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton<Logger>(
    Logger(),
  );

  serviceLocator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        headers: {
          "User-Agent":
              "KateMobileAndroid/109.1 lite-550 (Android 13; SDK 33; x86_64; Google Pixel 5; ru)",
        },
      ),
    ),
  );

  serviceLocator.registerLazySingleton<AccessTokenCubit>(
    () => AccessTokenCubit(),
  );

  serviceLocator.registerLazySingleton<VkLoginBloc>(
    () => VkLoginBloc(),
  );
}
