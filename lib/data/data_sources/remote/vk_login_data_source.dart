import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/vk_login_response_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class VkLoginDataSource {
  Future<VkLoginResponseModel> authorize({required VkLoginParams params});
  Future<void> request2fa({required String redirectUri});
}

class VkLoginDataSourceImpl implements VkLoginDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<VkLoginResponseModel> authorize(
      {required VkLoginParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.oauthUrl,
        queryParameters: {
          'grant_type': ApiConstants.grantType,
          'scope': ApiConstants.scope,
          'client_id': ApiConstants.clientId,
          'client_secret': ApiConstants.clientSecret,
          'validate_token': ApiConstants.validateToken,
          'username': params.login,
          'password': params.password,
          '2fa_supported': ApiConstants.faSupport,
        },
      );

      final data = response.data as Map<String, dynamic>;

      if (data.containsKey("access_token")) {
        return VkLoginResponseModel.success(
          accessToken: data["access_token"],
          secret: data["secret"],
        );
      }

      throw ServerException(response.toString());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final data = e.response?.data as Map<String, dynamic>;
        if (data["error"] == "need_validation") {
          return VkLoginResponseModel.needValidation(
            validationSid: data["validation_sid"],
            phoneMask: data["phone_mask"],
            redirectUri: data["redirect_uri"],
          );
        }
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> request2fa({required String redirectUri}) async {
    try {
      final response = await dio.get(redirectUri);
      print(response.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
