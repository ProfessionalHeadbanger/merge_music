import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/followed_playlists/followed_playlists_cubit.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/delete_playlist.dart';
import 'package:merge_music/domain/usecases/follow_playlist.dart';
import 'package:merge_music/domain/usecases/get_playlist_audios.dart';
import 'package:merge_music/service_locator.dart';

part 'playlist_page_event.dart';
part 'playlist_page_state.dart';

class PlaylistPageBloc extends Bloc<PlaylistPageEvent, PlaylistPageState> {
  final GetPlaylistAudios _getPlaylistAudios;
  final FollowPlaylist _followPlaylist;
  final DeletePlaylist _deletePlaylist;

  PlaylistPageBloc({
    required GetPlaylistAudios getPlaylistAudios,
    required FollowPlaylist followPlaylist,
    required DeletePlaylist deletePlaylist,
  })  : _getPlaylistAudios = getPlaylistAudios,
        _followPlaylist = followPlaylist,
        _deletePlaylist = deletePlaylist,
        super(PlaylistPageInitial()) {
    on<LoadPlaylistAudios>(_onLoadPlaylistAudios);
    on<FollowPlaylistEvent>(_onFollowPlaylistEvent);
    on<DeletePlaylistEvent>(_onDeletePlaylistEvent);
  }

  void _onLoadPlaylistAudios(
      LoadPlaylistAudios event, Emitter<PlaylistPageState> emit) async {
    emit(PlaylistPageLoading());

    final result = await _getPlaylistAudios(
      GetPlaylistAudiosParams(
        albumId: event.albumId,
        accessKey: event.accessKey,
        ownerId: event.ownerId,
      ),
    );
    result.fold(
      (failure) =>
          emit(PlaylistPageError(message: failure.message ?? 'Error occured')),
      (success) => emit(PlaylistPageLoaded(audios: success)),
    );
  }

  void _onFollowPlaylistEvent(
      FollowPlaylistEvent event, Emitter<PlaylistPageState> emit) async {
    final result = await _followPlaylist(
      AddAndDeletePartialParams(
        id: event.playlist.id,
        ownerId: event.playlist.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        final userState = serviceLocator.get<UserCubit>().state as UserLoggedIn;
        final newPlaylist = event.playlist.copyWith(
          id: success,
          ownerId: userState.user.id,
          isFollowing: true,
        );

        final followedPlaylistsCubit =
            serviceLocator.get<FollowedPlaylistsCubit>();
        final followedPlaylistsState =
            followedPlaylistsCubit.state as FollowedPlaylistsLoaded;
        followedPlaylistsCubit.emit(
          FollowedPlaylistsLoaded(
            playlists: [newPlaylist, ...followedPlaylistsState.playlists],
          ),
        );
      },
    );
  }

  void _onDeletePlaylistEvent(
      DeletePlaylistEvent event, Emitter<PlaylistPageState> emit) async {
    final result = await _deletePlaylist(
      AddAndDeletePartialParams(
        id: event.playlist.id,
        ownerId: event.playlist.ownerId,
      ),
    );
    result.fold(
      (failure) {},
      (success) {
        final followedPlaylistsCubit =
            serviceLocator.get<FollowedPlaylistsCubit>();
        final followedPlaylistsState =
            followedPlaylistsCubit.state as FollowedPlaylistsLoaded;
        followedPlaylistsCubit.emit(
          FollowedPlaylistsLoaded(
            playlists: followedPlaylistsState.playlists
                .where((playlist) => playlist.id != event.playlist.id)
                .toList(),
          ),
        );
      },
    );
  }
}
