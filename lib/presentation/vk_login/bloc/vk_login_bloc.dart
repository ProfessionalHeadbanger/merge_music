import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merge_music/common/navigation/router.dart';
import 'package:merge_music/common/navigation/routes.dart';
import 'package:merge_music/core/network/internet_connection_checker.dart';

part 'vk_login_event.dart';
part 'vk_login_state.dart';

class VkLoginBloc extends Bloc<VkLoginEvent, VkLoginState> {
  final InternetConnectionChecker internetConnectionChecker;

  VkLoginBloc(this.internetConnectionChecker) : super(VkLoginInitial()) {
    on<OpenInputLoginPage>(_onOpenInputLoginPage);
    on<GoBack>(_onGoBack);
    on<OpenMainPage>(_onOpenMainPage);
  }

  void _onOpenInputLoginPage(
      OpenInputLoginPage event, Emitter<VkLoginState> emit) async {
    emit(VkLoginLoading());
    if (await internetConnectionChecker.isConnected) {
      router.push('${Routes.welcomePage}/${Routes.inputLogin}');
    } else {
      emit(VkLoginFailure());
    }
  }

  void _onGoBack(GoBack event, Emitter<VkLoginState> emit) {
    emit(VkLoginInitial());
    router.pop();
  }

  void _onOpenMainPage(OpenMainPage event, Emitter<VkLoginState> emit) {
    router.go(Routes.mainPage);
  }
}
