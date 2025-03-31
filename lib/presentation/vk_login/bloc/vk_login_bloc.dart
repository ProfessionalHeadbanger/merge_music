import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merge_music/core/common/global_state/user/user_cubit.dart';
import 'package:merge_music/core/common/navigation/router.dart';
import 'package:merge_music/core/common/navigation/routes.dart';
import 'package:merge_music/core/network/internet_connection_checker.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/usecases/get_user_info.dart';
import 'package:merge_music/service_locator.dart';

part 'vk_login_event.dart';
part 'vk_login_state.dart';

class VkLoginBloc extends Bloc<VkLoginEvent, VkLoginState> {
  final InternetConnectionChecker internetConnectionChecker;
  final GetUserInfo _getUserInfo;

  VkLoginBloc(
      {required this.internetConnectionChecker,
      required GetUserInfo getUserInfo})
      : _getUserInfo = getUserInfo,
        super(VkLoginInitial()) {
    on<GetUserInfoEvent>(_onGetUserInfo);
    on<OpenInputLoginPage>(_onOpenInputLoginPage);
    on<GoBack>(_onGoBack);
    on<OpenMainPage>(_onOpenMainPage);
  }

  void _onGetUserInfo(
      GetUserInfoEvent event, Emitter<VkLoginState> emit) async {
    emit(VkLoginLoading());
    final result = await _getUserInfo(NoParams());
    result.fold(
      (l) => emit(
        VkLoginFailure(),
      ),
      (r) {
        serviceLocator.get<UserCubit>().updateUser(r);
        emit(VkLoginSuccess());
      },
    );
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
