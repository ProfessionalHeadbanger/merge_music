part of 'vk_login_bloc.dart';

abstract class VkLoginEvent extends Equatable {
  const VkLoginEvent();

  @override
  List<Object> get props => [];
}

class OpenInputLoginPage extends VkLoginEvent {
  const OpenInputLoginPage();
}

class GoBack extends VkLoginEvent {
  const GoBack();
}

class OpenMainPage extends VkLoginEvent {
  const OpenMainPage();
}
