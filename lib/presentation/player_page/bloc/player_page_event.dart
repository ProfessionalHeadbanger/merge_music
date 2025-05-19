part of 'player_page_bloc.dart';

sealed class PlayerPageEvent extends Equatable {
  const PlayerPageEvent();

  @override
  List<Object> get props => [];
}

class AddAudioEvent extends PlayerPageEvent {
  final AudioEntity audio;
  const AddAudioEvent(this.audio);
  @override
  List<Object> get props => [audio];
}

class DeleteAudioEvent extends PlayerPageEvent {
  final AudioEntity audio;
  const DeleteAudioEvent(this.audio);
  @override
  List<Object> get props => [audio];
}

class RestoreAudioEvent extends PlayerPageEvent {
  final AudioEntity audio;
  const RestoreAudioEvent(this.audio);
  @override
  List<Object> get props => [audio];
}
