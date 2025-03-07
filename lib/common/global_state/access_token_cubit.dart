import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

class AccessTokenCubit extends Cubit<String?> {
  AccessTokenCubit() : super(null);

  Future<void> loadToken() async {
    final authData = await (await VKID.getInstance()).currentAuthData;
    emit(authData?.token);
  }
}
