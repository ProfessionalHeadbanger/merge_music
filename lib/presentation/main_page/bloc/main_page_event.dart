part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class LoadMainPageData extends MainPageEvent {}

class CheckMainPageState extends MainPageEvent {}
