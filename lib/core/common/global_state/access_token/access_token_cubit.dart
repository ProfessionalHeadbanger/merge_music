import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/service_locator.dart';

part 'access_token_state.dart';

class AccessTokenCubit extends Cubit<AccessTokenState> {
  AccessTokenCubit() : super(AccessTokenNull());

  void checkToken() async {
    final token =
        await serviceLocator<FlutterSecureStorage>().read(key: 'token');
    serviceLocator.get<Logger>().d('Saved token: $token');
    updateToken(token);
  }

  Future<void> updateToken(String? token) async {
    if (token != null) {
      serviceLocator.get<Logger>().d('Saved token: $token');
      await serviceLocator<FlutterSecureStorage>()
          .write(key: 'token', value: token);
      emit(AccessTokenLoaded(token: token));
    } else {
      emit(AccessTokenNull());
    }
  }
}
