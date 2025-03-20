import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/audio_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class AudioRemoteDataSource {
  Future<List<AudioModel>> getAudio({required AudioListParams params});
}

class AudioRemoteDataSourceImpl implements AudioRemoteDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<List<AudioModel>> getAudio({required AudioListParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.audioGet,
        queryParameters: {
          'access_token': params.accessToken,
          'v': params.v,
          'count': params.count,
          'offset': params.offset
        },
      );

      final List<dynamic> audiosJson = response.data['response']['items'];
      return audiosJson.map((json) => AudioModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
