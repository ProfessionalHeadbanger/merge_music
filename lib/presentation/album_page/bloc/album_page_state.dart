part of 'album_page_bloc.dart';

sealed class AlbumPageState extends Equatable {
  const AlbumPageState();

  @override
  List<Object> get props => [];
}

final class AlbumPageInitial extends AlbumPageState {}

final class AlbumPageLoading extends AlbumPageState {}

final class AlbumPageLoaded extends AlbumPageState {
  final List<AudioEntity> audios;

  const AlbumPageLoaded({required this.audios});

  @override
  List<Object> get props => [audios];
}

final class AlbumPageError extends AlbumPageState {
  final String message;

  const AlbumPageError({required this.message});

  @override
  List<Object> get props => [message];
}
