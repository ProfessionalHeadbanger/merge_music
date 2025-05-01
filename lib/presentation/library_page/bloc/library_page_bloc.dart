import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'library_page_event.dart';
part 'library_page_state.dart';

class LibraryPageBloc extends Bloc<LibraryPageEvent, LibraryPageState> {
  LibraryPageBloc() : super(LibraryPageInitial()) {
    on<LibraryPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
