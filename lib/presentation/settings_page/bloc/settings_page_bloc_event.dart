part of 'settings_page_bloc_bloc.dart';

sealed class SettingsPageBlocEvent extends Equatable {
  const SettingsPageBlocEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends SettingsPageBlocEvent {}
