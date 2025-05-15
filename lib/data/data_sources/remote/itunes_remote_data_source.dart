import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class ITunesRemoteDataSource {
  Future<String?> search({required ITunesSearchParams params});
}

class ITunesRemoteDataSourceImpl implements ITunesRemoteDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<String?> search({required ITunesSearchParams params}) async {
    try {
      final encodedArtist = Uri.encodeComponent(params.artistName);
      final encodedTitle = Uri.encodeComponent(params.trackName);
      final term = '$encodedArtist+$encodedTitle';

      final uri = Uri.parse(
        '${ITunesApiConstants.baseUrl}${ITunesApiConstants.search}?term=$term&limit=${params.limit}',
      );

      final response = await dio.getUri(
        uri,
        options: Options(responseType: ResponseType.plain),
      );
      final decoded = jsonDecode(response.data);
      if (decoded['resultCount'] > 0) {
        return decoded['results'][0]['artworkUrl100'];
      }
      return null;
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
