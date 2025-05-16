import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/cover_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class DeezerRemoteDataSource {
  Future<CoverModel> search({required DeezerSearchParams params});
}

class DeezerRemoteDataSourceImpl implements DeezerRemoteDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<CoverModel> search({required DeezerSearchParams params}) async {
    try {
      final artistEncoded = Uri.encodeQueryComponent(params.artist);
      final trackEncoded = Uri.encodeQueryComponent(params.track);
      final query = 'artist:"$artistEncoded" track:"$trackEncoded"';

      final response = await dio.get(
        DeezerApiConstants.baseUrl + DeezerApiConstants.search,
        queryParameters: {
          'q': query,
          'limit': params.limit,
          'order': params.order,
          'strict': params.strict,
        },
      );

      final result = response.data['data'][0];
      return CoverModel.fromJson(result['album']);
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
