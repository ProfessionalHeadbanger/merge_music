import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/navigation/navigation_args.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';

part 'show_all_playlists_page_event.dart';
part 'show_all_playlists_page_state.dart';

class ShowAllPlaylistsPageBloc
    extends Bloc<ShowAllPlaylistsPageEvent, ShowAllPlaylistsPageState> {
  ShowAllPlaylistsPageBloc() : super(ShowAllPlaylistsPageInitial()) {
    on<OpenPlaylistPage>(_onOpenAlbumPage);
  }

  void _onOpenAlbumPage(
      OpenPlaylistPage event, Emitter<ShowAllPlaylistsPageState> emit) {
    if (event.playlist.type == 0) {
      router.pushNamed(
        Routes.playlistPage,
        extra: PlaylistPageArgs(playlist: event.playlist),
      );
    } else {
      router.pushNamed(
        Routes.albumPage,
        extra: AlbumPageArgs(album: event.playlist),
      );
    }
  }
}
