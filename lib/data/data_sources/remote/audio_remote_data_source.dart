import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/data/models/audio_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class AudioRemoteDataSource {
  Future<List<AudioModel>> getUserAudios();
}

class AudioRemoteDataSourceImpl implements AudioRemoteDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<List<AudioModel>> getUserAudios() async {
    try {
      List<AudioModel> audios = [];
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final token = tokenState.token;
        while (true) {
          int offset = 0;
          final response = await dio.get(
            ApiConstants.baseUrl + ApiConstants.audioGet,
            queryParameters: {
              'access_token': token,
              'v': '5.199',
              'count': ApiConstants.batchCount,
              'offset': offset,
            },
          );

          if (response.statusCode == 200) {
            final data = response.data;
            final List<dynamic> audiosJson = data['response']['items'];
            List<AudioModel> currentBatch =
                audiosJson.map((json) => AudioModel.fromJson(json)).toList();
            audios.addAll(currentBatch);

            if (currentBatch.length < ApiConstants.batchCount) {
              break;
            }

            offset += ApiConstants.batchCount;
          } else {
            serviceLocator
                .get<Logger>()
                .e('Failed to load audios: ${response.statusMessage}');
            break;
          }
        }
      }
      return audios;
    } on DioException catch (e) {
      serviceLocator.get<Logger>().e('Failed to load audios: $e');
    }
    return [];
  }
}
