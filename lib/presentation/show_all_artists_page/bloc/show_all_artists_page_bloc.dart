import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/navigation/navigation_args.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/domain/entities/artist_entity.dart';

part 'show_all_artists_page_event.dart';
part 'show_all_artists_page_state.dart';

class ShowAllArtistsPageBloc
    extends Bloc<ShowAllArtistsPageEvent, ShowAllArtistsPageState> {
  ShowAllArtistsPageBloc() : super(ShowAllArtistsPageInitial()) {
    on<OpenArtistPage>(_onOpenArtistPage);
  }

  void _onOpenArtistPage(
      OpenArtistPage event, Emitter<ShowAllArtistsPageState> emit) {
    router.pushNamed(
      Routes.artistPage,
      extra: ArtistPageArgs(artist: event.artist),
    );
  }
}
