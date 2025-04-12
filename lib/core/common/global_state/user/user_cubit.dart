import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:merge_music/core/params/params.dart';
import 'package:merge_music/domain/entities/user_entity.dart';
import 'package:merge_music/domain/usecases/get_user_info.dart';
import 'package:merge_music/service_locator.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserInfo _getUserInfo;

  UserCubit(GetUserInfo getUserInfo)
      : _getUserInfo = getUserInfo,
        super(UserInitial());

  void updateUser(UserEntity user) {
    serviceLocator.get<Logger>().d('Saved user: ${user.id}');
    emit(UserLoggedIn(user: user));
  }

  void loadUser() async {
    final result = await _getUserInfo(NoParams());
    result.fold(
      (l) => emit(
        UserInitial(),
      ),
      (r) {
        updateUser(r);
      },
    );
  }
}
