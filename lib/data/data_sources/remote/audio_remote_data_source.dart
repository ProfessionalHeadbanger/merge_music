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
  Future<ArtistModel> getArtistById({required GetArtistParams params});
  Future<List<AudioModel>> getAudiosByArtist(
      {required GetAudiosByArtistParams params});
  Future<List<PlaylistModel>> getAlbumsByArtist(
      {required GetAudiosByArtistParams params});
  Future<List<AudioModel>> getRecommendations(
      {required GetRecommendationsParams params});
  Future<int> addAudio({required AddAndDeleteParams params});
  Future<int> deleteAudio({required AddAndDeleteParams params});
  Future<int> followPlaylist({required AddAndDeleteParams params});
  Future<int> deletePlaylist({required AddAndDeleteParams params});
  Future<void> restoreAudio({required AddAndDeleteParams params});
}

class AudioRemoteDataSourceImpl implements AudioRemoteDataSource {
  final dio = serviceLocator.get<Dio>();

  @override
  Future<List<AudioModel>> getAudio({required AudioListParams params}) async {
    try {
      final queryParameters = <String, dynamic>{
        if (params.albumId != null) 'album_id': params.albumId,
        if (params.ownerId != null) 'owner_id': params.ownerId,
        if (params.accessKey != null) 'access_key': params.accessKey,
        'count': params.count,
        'offset': params.offset,
        'access_token': params.accessToken,
        'v': params.v,
      };

      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.audioGet,
        queryParameters: queryParameters,
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

  @override
  Future<ArtistModel> getArtistById({required GetArtistParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getArtistById,
        queryParameters: {
          'artist_id': params.artistId,
          'extended': params.extended,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      final artistJson = response.data['response'];
      return ArtistModel.fromJson(artistJson);
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PlaylistModel>> getAlbumsByArtist(
      {required GetAudiosByArtistParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getAlbumsByArtist,
        queryParameters: {
          'artist_id': params.artistId,
          'access_token': params.accessToken,
          'count': params.count,
          'offset': params.offset,
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

  @override
  Future<List<AudioModel>> getAudiosByArtist(
      {required GetAudiosByArtistParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getAudiosByArtist,
        queryParameters: {
          'artist_id': params.artistId,
          'access_token': params.accessToken,
          'count': params.count,
          'offset': params.offset,
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
  Future<List<AudioModel>> getRecommendations(
      {required GetRecommendationsParams params}) async {
    try {
      final queryParameters = <String, dynamic>{
        if (params.userId != null) 'user_id': params.userId,
        if (params.targetAudio != null) 'target_audio': params.targetAudio,
        if (params.count != null) 'count': params.count,
        if (params.offset != null) 'offset': params.offset,
        'access_token': params.accessToken,
        'v': params.v,
      };

      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getRecommendations,
        queryParameters: queryParameters,
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
  Future<int> addAudio({required AddAndDeleteParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.add,
        queryParameters: {
          'owner_id': params.ownerId,
          'audio_id': params.id,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      return response.data['response'] as int;
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> deleteAudio({required AddAndDeleteParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.delete,
        queryParameters: {
          'owner_id': params.ownerId,
          'audio_id': params.id,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      return response.data['response'];
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> deletePlaylist({required AddAndDeleteParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.add,
        queryParameters: {
          'owner_id': params.ownerId,
          'playlist_id': params.id,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      return response.data['response'];
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> followPlaylist({required AddAndDeleteParams params}) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.add,
        queryParameters: {
          'owner_id': params.ownerId,
          'playlist_id': params.id,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );

      return response.data['response']['playlist_id'] as int;
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> restoreAudio({required AddAndDeleteParams params}) async {
    try {
      await dio.get(
        ApiConstants.baseUrl + ApiConstants.restore,
        queryParameters: {
          'owner_id': params.ownerId,
          'audio_id': params.id,
          'access_token': params.accessToken,
          'v': params.v,
        },
      );
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
