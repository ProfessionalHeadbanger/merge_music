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

class TapSignInButton extends VkLoginEvent {
  final String login;
  final String password;

  const TapSignInButton({required this.login, required this.password});
}

class Request2faEvent extends VkLoginEvent {
  const Request2faEvent();
}

class SendSmsCode extends VkLoginEvent {
  final String code;

  const SendSmsCode({required this.code});
}

class OpenMainPage extends VkLoginEvent {
  const OpenMainPage();
}
