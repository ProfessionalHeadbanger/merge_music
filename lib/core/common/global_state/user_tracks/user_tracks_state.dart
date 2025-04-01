part of 'user_tracks_cubit.dart';

sealed class UserTracksState extends Equatable {
  const UserTracksState();

  @override
  List<Object> get props => [];
}

final class UserTracksInitial extends UserTracksState {}

final class UserTracksLoading extends UserTracksState {}

final class UserTracksLoaded extends UserTracksState {
  final List<AudioEntity> audios;

  const UserTracksLoaded({
    required this.audios,
  });

  @override
  List<Object> get props => [audios];
}

final class UserTracksError extends UserTracksState {
  final String message;

  const UserTracksError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
