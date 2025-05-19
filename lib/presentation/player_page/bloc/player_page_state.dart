part of 'player_page_bloc.dart';

sealed class PlayerPageState extends Equatable {
  const PlayerPageState();
  
  @override
  List<Object> get props => [];
}

final class PlayerPageInitial extends PlayerPageState {}
