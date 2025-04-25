import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/navigation/navigation_args.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
import 'package:merge_music/domain/usecases/search_albums.dart';
import 'package:merge_music/domain/usecases/search_artists.dart';
import 'package:merge_music/domain/usecases/search_audio.dart';
import 'package:merge_music/domain/usecases/search_playlists.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final SharedPreferences prefs;

  final SearchAudio _searchAudio;
  final SearchArtists _searchArtists;
  final SearchPlaylists _searchPlaylists;
  final SearchAlbums _searchAlbums;

  SearchPageBloc({
    required this.prefs,
    required SearchAudio searchAudio,
    required SearchArtists searchArtists,
    required SearchPlaylists searchPlaylists,
    required SearchAlbums searchAlbums,
  })  : _searchAudio = searchAudio,
        _searchArtists = searchArtists,
        _searchPlaylists = searchPlaylists,
        _searchAlbums = searchAlbums,
        super(SearchPageInitial()) {
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<AddQueryToHistory>(_onAddQueryToHistory);
    on<SearchByQuery>(_onSearchByQuery);
    on<ClearSearchTextField>(_onClearSearchTextField);
    on<OpenShowAllTracksPage>(_onShowAllTracksPage);
    on<OpenShowAllPlaylistsPage>(_onShowAllPlaylistsPage);
    on<OpenShowAllArtistsPage>(_onShowAllArtistsPage);
    on<OpenAlbumPage>(_onOpenAlbumPage);

    add(LoadSearchHistory());
  }

  void _onLoadSearchHistory(
      LoadSearchHistory event, Emitter<SearchPageState> emit) {
    emit(SearchPageLoading());
    final history = prefs.getStringList(CommonConstants.searchHistoryKey) ?? [];
    if (history.isEmpty) {
      emit(SearchPageEmptyHistory());
    } else {
      emit(SearchPageHistoryLoaded(history: history));
    }
  }

  void _onClearSearchHistory(
      ClearSearchHistory event, Emitter<SearchPageState> emit) {
    emit(SearchPageLoading());
    prefs.remove(CommonConstants.searchHistoryKey);
    emit(SearchPageEmptyHistory());
  }

  void _onAddQueryToHistory(
      AddQueryToHistory event, Emitter<SearchPageState> emit) {
    emit(SearchPageLoading());
    final history = prefs.getStringList(CommonConstants.searchHistoryKey) ?? [];
    if (history.contains(event.query)) {
      history.remove(event.query);
    }
    if (history.length > CommonConstants.maxSearchHistoryLength) {
      history.removeLast();
    }
    history.insert(0, event.query);
    prefs.setStringList(CommonConstants.searchHistoryKey, history);
    if (state is! SearchPageLoaded) {
      emit(SearchPageHistoryLoaded(history: history));
    }
  }

  void _onClearSearchTextField(
      ClearSearchTextField event, Emitter<SearchPageState> emit) {
    final history = prefs.getStringList(CommonConstants.searchHistoryKey) ?? [];
    if (history.isEmpty) {
      emit(SearchPageEmptyHistory());
    } else {
      emit(SearchPageHistoryLoaded(history: history));
    }
  }

  void _onSearchByQuery(
      SearchByQuery event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoading());

    List<AudioEntity>? tracks;
    List<ArtistEntity>? artists;
    List<PlaylistEntity>? playlists;
    List<PlaylistEntity>? albums;

    final tracksResult =
        await _searchAudio(AudioSearchPartialParams(q: event.query));
    tracksResult.fold(
      (failure) =>
          emit(SearchPageError(message: failure.message ?? 'Error occured')),
      (success) => tracks = success,
    );

    final artistsResult =
        await _searchArtists(AudioSearchPartialParams(q: event.query));
    artistsResult.fold(
      (failure) =>
          emit(SearchPageError(message: failure.message ?? 'Error occured')),
      (success) => artists = success,
    );

    final playlistsResult =
        await _searchPlaylists(AudioSearchPartialParams(q: event.query));
    playlistsResult.fold(
      (failure) =>
          emit(SearchPageError(message: failure.message ?? 'Error occured')),
      (success) => playlists = success,
    );

    final albumsResult =
        await _searchAlbums(AudioSearchPartialParams(q: event.query));
    albumsResult.fold(
      (failure) =>
          emit(SearchPageError(message: failure.message ?? 'Error occured')),
      (success) => albums = success,
    );

    if (tracks != null &&
        artists != null &&
        playlists != null &&
        albums != null) {
      emit(
        SearchPageLoaded(
            tracks: tracks!,
            artists: artists!,
            playlists: playlists!,
            albums: albums!),
      );
    }
  }

  void _onShowAllTracksPage(
      OpenShowAllTracksPage event, Emitter<SearchPageState> emit) {
    router.push(
      '${Routes.searchPage}/${Routes.showAllTracksPage}',
      extra: ShowAllTracksPageArgs(title: event.title, audios: event.audios),
    );
  }

  void _onShowAllPlaylistsPage(
      OpenShowAllPlaylistsPage event, Emitter<SearchPageState> emit) {
    router.push(
      '${Routes.searchPage}/${Routes.showAllPlaylistsPage}',
      extra: ShowAllPlaylistsPageArgs(
          title: event.title, playlists: event.playlists),
    );
  }

  void _onShowAllArtistsPage(
      OpenShowAllArtistsPage event, Emitter<SearchPageState> emit) {
    router.push(
      '${Routes.searchPage}/${Routes.showAllArtistsPage}',
      extra: ShowAllArtistsPageArgs(title: event.title, artists: event.artists),
    );
  }

  void _onOpenAlbumPage(OpenAlbumPage event, Emitter<SearchPageState> emit) {
    router.push(
      '${Routes.searchPage}/${Routes.albumPage}',
      extra: AlbumPageArgs(album: event.album),
    );
  }
}
