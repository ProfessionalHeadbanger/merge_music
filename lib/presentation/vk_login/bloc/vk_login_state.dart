part of 'vk_login_bloc.dart';

abstract class VkLoginState extends Equatable {
  const VkLoginState();

  @override
  List<Object> get props => [];
}

class VkLoginInitial extends VkLoginState {}

class VkLoginLoading extends VkLoginState {}

class VkLoginNeed2fa extends VkLoginState {
  final VkLoginResponseModelNeedValidation response;

  const VkLoginNeed2fa({required this.response});
}

class VkLoginWaitConfirmation extends VkLoginState {}

class VkLoginSuccess extends VkLoginState {}

class VkLoginFailure extends VkLoginState {}
