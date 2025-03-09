part of 'vk_login_bloc.dart';

abstract class VkLoginEvent extends Equatable {
  const VkLoginEvent();

  @override
  List<Object> get props => [];
}

class OpenMainPage extends VkLoginEvent {
  const OpenMainPage();
}

class VkLoginAuthError extends VkLoginEvent {
  const VkLoginAuthError();
}

class VkLoginAuthSuccess extends VkLoginEvent {
  const VkLoginAuthSuccess();
}
