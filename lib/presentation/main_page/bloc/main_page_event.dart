part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class LoadMainPageAudios extends MainPageEvent {}

//class LoadAlgorithmsPlaylists extends MainPageEvent {}

//class LoadRedactorsPlaylists extends MainPageEvent {}
