import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';

part 'settings_page_event.dart';
part 'settings_page_state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  final AccessTokenCubit accessTokenCubit;

  SettingsPageBloc({required this.accessTokenCubit})
      : super(SettingsPageInitial()) {
    on<LogoutEvent>(_onLogoutEvent);
  }

  void _onLogoutEvent(
      LogoutEvent event, Emitter<SettingsPageState> emit) async {
    await accessTokenCubit.clearToken();
    router.go(Routes.welcomePage);
  }
}
