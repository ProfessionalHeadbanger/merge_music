import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/data/data_sources/remote/audio_remote_data_source.dart';
import 'package:merge_music/data/repositories/audio_repository_impl.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';
import 'package:merge_music/domain/usecases/get_main_page_audio_list.dart';
import 'package:merge_music/presentation/main_page/bloc/main_page_bloc.dart';
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
          // "User-Agent":
          //     "KateMobileAndroid/109.1 lite-550 (Android 13; SDK 33; x86_64; Google Pixel 5; ru)",
          "User-Agent":
              "VKAndroidApp/4.13.1-1206 (Android 4.4.3; SDK 19; armeabi; ; ru)",
        },
      ),
    ),
  );

  // Global State
  serviceLocator.registerLazySingleton<AccessTokenCubit>(
    () => AccessTokenCubit(),
  );

  // VK Login Page
  serviceLocator.registerLazySingleton<VkLoginBloc>(
    () => VkLoginBloc(),
  );

  // Main Page
  serviceLocator.registerFactory<AudioRemoteDataSource>(
    () => AudioRemoteDataSourceImpl(),
  );
  serviceLocator.registerFactory<AudioRepository>(
    () => AudioRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetMainPageAudioList(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<MainPageBloc>(
    () => MainPageBloc(
      getMainPageAudioList: serviceLocator(),
      accessTokenCubit: serviceLocator<AccessTokenCubit>(),
    ),
  );
}
