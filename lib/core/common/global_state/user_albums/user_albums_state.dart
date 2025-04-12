part of 'user_albums_cubit.dart';

sealed class UserAlbumsState extends Equatable {
  const UserAlbumsState();

  @override
  List<Object> get props => [];
}

final class UserAlbumsInitial extends UserAlbumsState {}

final class UserAlbumsLoading extends UserAlbumsState {}

final class UserAlbumsLoaded extends UserAlbumsState {
  final List<PlaylistEntity> albums;

  const UserAlbumsLoaded({
    required this.albums,
  });

  @override
  List<Object> get props => [albums];
}

final class UserAlbumsError extends UserAlbumsState {
  final String message;

  const UserAlbumsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
