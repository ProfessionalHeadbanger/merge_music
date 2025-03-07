import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'vk_login_event.dart';
part 'vk_login_state.dart';

class VkLoginBloc extends Bloc<VkLoginEvent, VkLoginState> {
  VkLoginBloc() : super(VkLoginInitial()) {
    on<VkLoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
