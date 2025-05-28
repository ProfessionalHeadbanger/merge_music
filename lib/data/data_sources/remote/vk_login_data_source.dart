import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/user_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class VkLoginDataSource {
  Future<UserModel> getUser({required UserParams params});
}

class VkLoginDataSourceImpl implements VkLoginDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<UserModel> getUser({required UserParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.usersGet,
        queryParameters: {
          //'user_ids': params.userIds,
          'fields': params.fields?.join(','),
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      final List<dynamic> usersJson = response.data['response'];
      return usersJson.map((json) => UserModel.fromJson(json)).toList().first;
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
