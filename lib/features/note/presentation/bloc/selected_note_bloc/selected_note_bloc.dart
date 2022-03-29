import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/note.dart';

part 'selected_note_event.dart';
part 'selected_note_state.dart';

class SelectedNoteBloc extends Bloc<SelectedNoteEvent, SelectedNoteState> {
  SelectedNoteBloc() : super(InitialNoteState()) {
    on<SelectedNoteEvent>((event, emit) {
      if (event is ChangeSelectedNote) {
        emit(LoadedNoteState(note: event.note));
      } else if (event is InitialSelectedEvent) {
        emit(InitialNoteState());
      }
    });
  }
}
