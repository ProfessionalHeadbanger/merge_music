import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merge_music/common/navigation/router.dart';
import 'package:merge_music/common/navigation/routes.dart';

part 'vk_login_event.dart';
part 'vk_login_state.dart';

class VkLoginBloc extends Bloc<VkLoginEvent, VkLoginState> {
  VkLoginBloc() : super(VkLoginInitial()) {
    on<OpenMainPage>(_onOpenMainPage);
    on<VkLoginAuthError>(_onAuthError);
    on<VkLoginAuthSuccess>(_onAuthSuccess);
  }

  void _onAuthError(VkLoginAuthError event, Emitter<VkLoginState> emit) {
    emit(VkLoginFailure());
  }

  void _onAuthSuccess(VkLoginAuthSuccess event, Emitter<VkLoginState> emit) {
    emit(VkLoginSuccess());
    router.go(Routes.mainPage);
  }

  void _onOpenMainPage(OpenMainPage event, Emitter<VkLoginState> emit) {
    router.go(Routes.mainPage);
  }
}
