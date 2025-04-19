import 'package:dio/dio.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/artist_model.dart';
import 'package:merge_music/data/models/audio_model.dart';
import 'package:merge_music/data/models/playlist_model.dart';
import 'package:merge_music/service_locator.dart';

abstract interface class AudioRemoteDataSource {
  Future<List<AudioModel>> getAudio({required AudioListParams params});
  Future<List<PlaylistModel>> getPlaylists(
      {required PlaylistListParams params});
  Future<List<AudioModel>> searchAudio({required AudioSearchParams params});
  Future<List<PlaylistModel>> searchPlaylists(
      {required AudioSearchPlaylistsParams params});
  Future<List<ArtistModel>> searchArtists(
      {required AudioSearchArtistsParams params});
  Future<List<PlaylistModel>> searchAlbums(
      {required AudioSearchAlbumsParams params});
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

  @override
  Future<List<AudioModel>> searchAudio(
      {required AudioSearchParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.search,
        queryParameters: {
          'q': params.q,
          'auto_complete': params.autoComplete,
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
  Future<List<ArtistModel>> searchArtists(
      {required AudioSearchArtistsParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.searchArtists,
        queryParameters: {
          'q': params.q,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      final List<dynamic> artistsJson = response.data['response']['items'];
      return artistsJson.map((json) => ArtistModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PlaylistModel>> searchPlaylists(
      {required AudioSearchPlaylistsParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.searchPlaylists,
        queryParameters: {
          'q': params.q,
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

  @override
  Future<List<PlaylistModel>> searchAlbums(
      {required AudioSearchAlbumsParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.searchAlbums,
        queryParameters: {
          'q': params.q,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      final List<dynamic> albumsJson = response.data['response']['items'];
      return albumsJson.map((json) => PlaylistModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
