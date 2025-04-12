part of 'vk_login_bloc.dart';

abstract class VkLoginEvent extends Equatable {
  const VkLoginEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends VkLoginEvent {
  final String userId;

  const GetUserInfoEvent(this.userId);

  @override
  List<Object> get props => [userId];
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
