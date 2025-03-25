import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merge_music/common/navigation/router.dart';
import 'package:merge_music/common/navigation/routes.dart';

part 'vk_login_event.dart';
part 'vk_login_state.dart';

class VkLoginBloc extends Bloc<VkLoginEvent, VkLoginState> {
  VkLoginBloc() : super(VkLoginInitial()) {
    on<OpenInputLoginPage>(_onOpenInputLoginPage);
    on<GoBack>(_onGoBack);
    on<OpenMainPage>(_onOpenMainPage);
  }

  void _onOpenInputLoginPage(
      OpenInputLoginPage event, Emitter<VkLoginState> emit) {
    router.push('${Routes.welcomePage}/${Routes.inputLogin}');
  }

  void _onGoBack(GoBack event, Emitter<VkLoginState> emit) {
    router.pop();
  }

  void _onOpenMainPage(OpenMainPage event, Emitter<VkLoginState> emit) {
    router.go(Routes.mainPage);
  }
}
