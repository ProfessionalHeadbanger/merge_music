import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';

part 'settings_page_bloc_event.dart';
part 'settings_page_bloc_state.dart';

class SettingsPageBlocBloc
    extends Bloc<SettingsPageBlocEvent, SettingsPageBlocState> {
  final AccessTokenCubit accessTokenCubit;

  SettingsPageBlocBloc({required this.accessTokenCubit})
      : super(SettingsPageBlocInitial()) {
    on<LogoutEvent>(_onLogoutEvent);
  }

  void _onLogoutEvent(
      LogoutEvent event, Emitter<SettingsPageBlocState> emit) async {
    await accessTokenCubit.clearToken();
    router.go(Routes.welcomePage);
  }
}
