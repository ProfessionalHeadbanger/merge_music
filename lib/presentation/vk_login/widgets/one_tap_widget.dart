import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:merge_music/service_locator.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

class OneTapWidget extends StatelessWidget {
  final void Function(String? refreshToken) onAuth;

  const OneTapWidget({super.key, required this.onAuth});

  @override
  Widget build(BuildContext context) {
    return OneTap(
      key: GlobalKey(),
      fastAuthEnabled: false,
      onAuth: (onAuth, authData) {
        serviceLocator.get<Logger>().d('Retrieved token: ${authData.token}');
        context.read<AccessTokenCubit>().updateToken();
        context.read<VkLoginBloc>().add(const VkLoginAuthSuccess());
      },
      onError: (oAuth, error) {
        serviceLocator.get<Logger>().e('Error: $error');
        context.read<VkLoginBloc>().add(const VkLoginAuthError());
      },
      style: OneTapStyle(
        cornersStyle: OneTapCornersRounded(),
      ),
      signInToAnotherAccountButtonEnabled: false,
    );
  }
}
