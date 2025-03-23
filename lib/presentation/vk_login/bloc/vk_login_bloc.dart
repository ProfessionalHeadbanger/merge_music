import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merge_music/common/navigation/router.dart';
import 'package:merge_music/common/navigation/routes.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/data/models/vk_login_response_model.dart';
import 'package:merge_music/domain/usecases/vk_login_usecases/request_2fa.dart';
import 'package:merge_music/domain/usecases/vk_login_usecases/sing_in_vk.dart';

part 'vk_login_event.dart';
part 'vk_login_state.dart';

class VkLoginBloc extends Bloc<VkLoginEvent, VkLoginState> {
  final SingInVk _singInVk;
  final Request2fa _request2fa;

  VkLoginBloc({required SingInVk singInVk, required Request2fa request2fa})
      : _singInVk = singInVk,
        _request2fa = request2fa,
        super(VkLoginInitial()) {
    on<OpenInputLoginPage>(_onOpenInputLoginPage);
    on<GoBack>(_onGoBack);
    on<TapSignInButton>(_onTapSignInButton);
    on<Request2faEvent>(_onRequest2fa);
    on<SendSmsCode>(_onSendSmsCode);
    on<OpenMainPage>(_onOpenMainPage);
  }

  void _onOpenInputLoginPage(
      OpenInputLoginPage event, Emitter<VkLoginState> emit) {
    router.push('${Routes.vkLogin}/${Routes.inputLogin}');
  }

  void _onGoBack(GoBack event, Emitter<VkLoginState> emit) {
    router.pop();
  }

  void _onTapSignInButton(
      TapSignInButton event, Emitter<VkLoginState> emit) async {
    emit(VkLoginLoading());

    try {
      final response = await _singInVk(
        VkLoginParams(
          login: event.login,
          password: event.password,
        ),
      );

      response.fold(
        (l) {
          emit(VkLoginFailure());
        },
        (r) {
          if (r is VkLoginResponseModelSuccess) {
            emit(VkLoginSuccess());
          } else if (r is VkLoginResponseModelNeedValidation) {
            emit(
              VkLoginNeed2fa(
                response: r,
              ),
            );
            router.push(
                '${Routes.vkLogin}/${Routes.inputLogin}/${Routes.confirmSms}');
          }
        },
      );
    } catch (e) {
      emit(VkLoginFailure());
    }
  }

  void _onRequest2fa(Request2faEvent event, Emitter<VkLoginState> emit) async {
    emit(VkLoginLoading());

    try {
      if (state is VkLoginNeed2fa) {
        final s = state as VkLoginNeed2fa;
        final response = await _request2fa(
            Request2faParams(redirectUri: s.response.redirectUri));
        response.fold((l) {
          emit(VkLoginFailure());
        }, (r) {
          emit(VkLoginWaitConfirmation());
        });
      }
    } catch (e) {
      emit(VkLoginFailure());
    }
  }

  void _onSendSmsCode(SendSmsCode event, Emitter<VkLoginState> emit) async {
    emit(VkLoginLoading());

    // try {
    //   final response = await vkLoginDataSource.confirmSms(
    //     validationSid: event.validationSid,
    //     code: event.code,
    //   );

    //   if (response is VkLoginSuccess) {
    //     emit(VkLoginSuccess());
    //   } else {
    //     emit(VkLoginFailure());
    //   }
    // } catch (e) {
    //   emit(VkLoginFailure());
    // }
  }

  void _onOpenMainPage(OpenMainPage event, Emitter<VkLoginState> emit) {
    router.go(Routes.mainPage);
  }
}
