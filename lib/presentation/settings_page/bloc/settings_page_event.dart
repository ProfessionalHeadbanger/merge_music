part of 'settings_page_bloc.dart';

sealed class SettingsPageEvent extends Equatable {
  const SettingsPageEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends SettingsPageEvent {}
