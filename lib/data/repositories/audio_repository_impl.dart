import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/errors/exception.dart';
import 'package:merge_music/core/errors/failure.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/data_sources/remote/audio_remote_data_source.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/repositories/audio_repository.dart';
import 'package:merge_music/service_locator.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioRemoteDataSource audioRemoteDataSource;

  AudioRepositoryImpl(this.audioRemoteDataSource);

  @override
  Future<Either<Failure, List<AudioEntity>>> getUserAudios() async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        List<AudioEntity> audios = [];
        while (true) {
          int offset = 0;
          final currentBatch = await audioRemoteDataSource.getAudio(
            params: AudioListParams(
              count: ApiConstants.batchCount,
              offset: offset,
              accessToken: tokenState.token,
              v: ApiConstants.v,
            ),
          );
          audios.addAll(currentBatch);

          if (currentBatch.length < ApiConstants.batchCount) {
            break;
          }

          offset += ApiConstants.batchCount;
        }
        return right(audios);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlaylistEntity>>> getUserAlbums() async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      final userState = serviceLocator.get<UserCubit>().state;
      if (tokenState is AccessTokenLoaded && userState is UserLoggedIn) {
        final albums = await audioRemoteDataSource.getPlaylists(
          params: PlaylistListParams(
            ownerId: userState.user.id,
            filters: ApiConstants.albumsfilter,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(albums);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlaylistEntity>>> getFollowedPlaylists() async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      final userState = serviceLocator.get<UserCubit>().state;
      if (tokenState is AccessTokenLoaded && userState is UserLoggedIn) {
        final albums = await audioRemoteDataSource.getPlaylists(
          params: PlaylistListParams(
            ownerId: userState.user.id,
            filters: ApiConstants.followedfilter,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(albums);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlaylistEntity>>> getUserPlaylists() async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      final userState = serviceLocator.get<UserCubit>().state;
      if (tokenState is AccessTokenLoaded && userState is UserLoggedIn) {
        final albums = await audioRemoteDataSource.getPlaylists(
          params: PlaylistListParams(
            ownerId: userState.user.id,
            filters: ApiConstants.ownedfilter,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(albums);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AudioEntity>>> searchAudio(
      AudioSearchPartialParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final audios = await audioRemoteDataSource.searchAudio(
          params: AudioSearchParams(
            q: params.q,
            autoComplete: true,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(audios);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ArtistEntity>>> searchArtists(
      AudioSearchPartialParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final artists = await audioRemoteDataSource.searchArtists(
          params: AudioSearchArtistsParams(
            q: params.q,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(artists);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlaylistEntity>>> searchPlaylists(
      AudioSearchPartialParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final playlists = await audioRemoteDataSource.searchPlaylists(
          params: AudioSearchPlaylistsParams(
            q: params.q,
            accessToken: tokenState.token,
            filters: ApiConstants.allFilter,
            v: ApiConstants.v,
          ),
        );
        return right(playlists);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlaylistEntity>>> searchAlbums(
      AudioSearchPartialParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final playlists = await audioRemoteDataSource.searchAlbums(
          params: AudioSearchAlbumsParams(
            q: params.q,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(playlists);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AudioEntity>>> getPlaylistAudios(
      GetPlaylistAudiosParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final audios = await audioRemoteDataSource.getAudio(
          params: AudioListParams(
            albumId: params.albumId,
            ownerId: params.ownerId,
            count: ApiConstants.playlistAudiosBatchCount,
            accessToken: tokenState.token,
            accessKey: params.accessKey,
            v: ApiConstants.v,
          ),
        );
        return right(audios);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ArtistEntity>> getArtistById(
      GetArtistByIdParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final artist = await audioRemoteDataSource.getArtistById(
          params: GetArtistParams(
            artistId: params.artistId,
            extended: 1,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(artist);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PlaylistEntity>>> getAlbumsByArtist(
      GetArtistByIdParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final playlists = await audioRemoteDataSource.getAlbumsByArtist(
          params: GetAudiosByArtistParams(
            artistId: params.artistId,
            accessToken: tokenState.token,
            count: ApiConstants.playlistAudiosBatchCount,
            v: ApiConstants.v,
          ),
        );
        return right(playlists);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AudioEntity>>> getAudiosByArtist(
      GetArtistByIdParams params) async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      if (tokenState is AccessTokenLoaded) {
        final audios = await audioRemoteDataSource.getAudiosByArtist(
          params: GetAudiosByArtistParams(
            artistId: params.artistId,
            accessToken: tokenState.token,
            count: ApiConstants.playlistAudiosBatchCount,
            v: ApiConstants.v,
          ),
        );
        return right(audios);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AudioEntity>>> getRecommendationsForUser() async {
    try {
      final tokenState = serviceLocator.get<AccessTokenCubit>().state;
      final userState = serviceLocator.get<UserCubit>().state;
      if (tokenState is AccessTokenLoaded && userState is UserLoggedIn) {
        final audios = await audioRemoteDataSource.getRecommendations(
          params: GetRecommendationsParams(
            userId: userState.user.id,
            accessToken: tokenState.token,
            v: ApiConstants.v,
          ),
        );
        return right(audios);
      }
      return left(Failure('Access token is not loaded'));
    } on ServerException catch (e) {
      serviceLocator.get<Logger>().e('Error occured: $e');
      return left(Failure(e.message));
    }
  }
}
