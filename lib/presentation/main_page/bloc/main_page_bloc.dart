import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/audio_entity.dart';
import 'package:merge_music/domain/usecases/get_main_page_audio_list.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetMainPageAudioList _getMainPageAudioList;
  final AccessTokenCubit accessTokenCubit;
  late final StreamSubscription accessTokenSubscription;

  MainPageBloc({
    required GetMainPageAudioList getMainPageAudioList,
    required this.accessTokenCubit,
  })  : _getMainPageAudioList = getMainPageAudioList,
        super(MainPageInitial()) {
    on<LoadMainPageAudios>(_onLoadMainPageAudios);

    accessTokenSubscription = accessTokenCubit.stream.listen(
      (state) {
        if (state is AccessTokenLoaded) {
          add(LoadMainPageAudios());
        }
      },
    );
  }

  Future<void> _onLoadMainPageAudios(
      LoadMainPageAudios event, Emitter<MainPageState> emit) async {
    emit(MainPageLoading());

    final audios = await _getMainPageAudioList(NoParams());

    audios.fold(
      (l) => emit(
        MainPageError(message: l.message ?? 'Error occured'),
      ),
      (r) => emit(
        MainPageLoaded(audios: r),
      ),
    );
  }

  @override
  Future<void> close() {
    accessTokenSubscription.cancel();
    return super.close();
  }
}
