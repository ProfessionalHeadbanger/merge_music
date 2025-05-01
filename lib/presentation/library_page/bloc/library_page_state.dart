part of 'library_page_bloc.dart';

sealed class LibraryPageState extends Equatable {
  const LibraryPageState();
  
  @override
  List<Object> get props => [];
}

final class LibraryPageInitial extends LibraryPageState {}
