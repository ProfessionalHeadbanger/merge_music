import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/constants/common_constants.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/entities/playlist_entity.dart';
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

  SearchPageBloc({
    required this.prefs,
    required SearchAudio searchAudio,
    required SearchArtists searchArtists,
    required SearchPlaylists searchPlaylists,
  })  : _searchAudio = searchAudio,
        _searchArtists = searchArtists,
        _searchPlaylists = searchPlaylists,
        super(SearchPageInitial()) {
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<AddQueryToHistory>(_onAddQueryToHistory);
    on<SearchTracksEvent>(_onSearchTracksEvent);
    on<SearchArtistsEvent>(_onSearchArtistsEvent);
    on<SearchPlaylistsEvent>(_onSearchPlaylistsEvent);
    on<ClearSearchTextField>(_onClearSearchTextField);

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
    if (!(state is SearchPageTracksLoaded ||
        state is SearchPageArtistsLoaded ||
        state is SearchPagePlaylistsLoaded)) {
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

  void _onSearchTracksEvent(
      SearchTracksEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoading());
    final result = await _searchAudio(AudioSearchPartialParams(q: event.query));
    result.fold(
      (failure) =>
          emit(SearchPageError(message: failure.message ?? 'Error occured')),
      (success) => emit(SearchPageTracksLoaded(tracks: success)),
    );
  }

  void _onSearchArtistsEvent(
      SearchArtistsEvent event, Emitter<SearchPageState> emit) {}
  void _onSearchPlaylistsEvent(
      SearchPlaylistsEvent event, Emitter<SearchPageState> emit) {}
}
