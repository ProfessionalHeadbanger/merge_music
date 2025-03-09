import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/service_locator.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

part 'access_token_state.dart';

class AccessTokenCubit extends Cubit<AccessTokenState> {
  AccessTokenCubit() : super(AccessTokenInitial());

  Future<void> updateToken() async {
    try {
      final authData = await (await VKID.getInstance()).currentAuthData;
      final token = authData?.token;
      serviceLocator.get<Logger>().d('Saved token: $token');

      if (token != null) {
        emit(AccessTokenLoaded(token: token));
      } else {
        emit(AccessTokenNull());
      }
    } catch (e) {
      emit(AccessTokenNull());
    }
  }
}
