import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/audio_model.dart';
import 'package:merge_music/data/models/playlist_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class AudioRemoteDataSource {
  Future<List<AudioModel>> getAudio({required AudioListParams params});
  Future<List<PlaylistModel>> getPlaylists(
      {required PlaylistListParams params});
}

class AudioRemoteDataSourceImpl implements AudioRemoteDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<List<AudioModel>> getAudio({required AudioListParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.audioGet,
        queryParameters: {
          'album_id': params.albumId,
          'count': params.count,
          'offset': params.offset,
          'access_token': params.accessToken,
          'v': params.v,
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

  @override
  Future<List<PlaylistModel>> getPlaylists(
      {required PlaylistListParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.playlistsGet,
        queryParameters: {
          'owner_id': params.ownerId,
          'count': params.count,
          'offset': params.offset,
          'extended': params.extended,
          'filters': params.filters,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      final List<dynamic> playlistsJson = response.data['response']['items'];
      return playlistsJson.map((json) => PlaylistModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
