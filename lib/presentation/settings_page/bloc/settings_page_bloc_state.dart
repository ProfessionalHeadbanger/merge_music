part of 'settings_page_bloc_bloc.dart';

sealed class SettingsPageBlocState extends Equatable {
  const SettingsPageBlocState();
  
  @override
  List<Object> get props => [];
}

final class SettingsPageBlocInitial extends SettingsPageBlocState {}
