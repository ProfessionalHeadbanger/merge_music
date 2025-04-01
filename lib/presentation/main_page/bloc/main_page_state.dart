part of 'main_page_bloc.dart';

abstract class MainPageState extends Equatable {
  const MainPageState();

  @override
  List<Object> get props => [];
}

class MainPageInitial extends MainPageState {}

class MainPageLoading extends MainPageState {}

class MainPageLoaded extends MainPageState {}

class MainPageError extends MainPageState {
  final String message;

  const MainPageError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
