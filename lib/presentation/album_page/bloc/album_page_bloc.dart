import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/global_state/user_albums/user_albums_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/delete_playlist.dart';
import 'package:merge_music/domain/usecases/follow_playlist.dart';
import 'package:merge_music/domain/usecases/get_playlist_audios.dart';
import 'package:merge_music/service_locator.dart';

part 'album_page_event.dart';
part 'album_page_state.dart';

class AlbumPageBloc extends Bloc<AlbumPageEvent, AlbumPageState> {
  final GetPlaylistAudios _getPlaylistAudios;
  final FollowPlaylist _followPlaylist;
  final DeletePlaylist _deletePlaylist;

  AlbumPageBloc({
    required GetPlaylistAudios getPlaylistAudios,
    required FollowPlaylist followPlaylist,
    required DeletePlaylist deletePlaylist,
  })  : _getPlaylistAudios = getPlaylistAudios,
        _followPlaylist = followPlaylist,
        _deletePlaylist = deletePlaylist,
        super(AlbumPageInitial()) {
    on<LoadPlaylistAudios>(_onLoadPlaylistAudios);
    on<FollowAlbumEvent>(_onFollowAlbumEvent);
    on<DeleteAlbumEvent>(_onDeleteAlbumEvent);
  }

  void _onLoadPlaylistAudios(
      LoadPlaylistAudios event, Emitter<AlbumPageState> emit) async {
    emit(AlbumPageLoading());

    final result = await _getPlaylistAudios(
      GetPlaylistAudiosParams(
        albumId: event.albumId,
        accessKey: event.accessKey,
        ownerId: event.ownerId,
      ),
    );
    result.fold(
      (failure) =>
          emit(AlbumPageError(message: failure.message ?? 'Error occured')),
      (success) => emit(AlbumPageLoaded(audios: success)),
    );
  }

  void _onFollowAlbumEvent(
      FollowAlbumEvent event, Emitter<AlbumPageState> emit) async {
    final result = await _followPlaylist(
      AddAndDeletePartialParams(
        id: event.album.id,
        ownerId: event.album.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        final userState = serviceLocator.get<UserCubit>().state as UserLoggedIn;
        final newAlbum = event.album.copyWith(
          id: success,
          ownerId: userState.user.id,
          isFollowing: true,
        );

        final userAlbumsCubit = serviceLocator.get<UserAlbumsCubit>();
        final userAlbumsState = userAlbumsCubit.state as UserAlbumsLoaded;
        userAlbumsCubit.emit(
          UserAlbumsLoaded(
            albums: [newAlbum, ...userAlbumsState.albums],
          ),
        );
      },
    );
  }

  void _onDeleteAlbumEvent(
      DeleteAlbumEvent event, Emitter<AlbumPageState> emit) async {
    final result = await _deletePlaylist(
      AddAndDeletePartialParams(
        id: event.album.id,
        ownerId: event.album.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        final userAlbumsCubit = serviceLocator.get<UserAlbumsCubit>();
        final userAlbumsState = userAlbumsCubit.state as UserAlbumsLoaded;
        userAlbumsCubit.emit(
          UserAlbumsLoaded(
            albums: userAlbumsState.albums
                .where((album) => album.id != event.album.id)
                .toList(),
          ),
        );
      },
    );
  }
}
