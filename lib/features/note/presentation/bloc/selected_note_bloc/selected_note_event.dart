part of 'selected_note_bloc.dart';

class SelectedNoteEvent extends Equatable {
  const SelectedNoteEvent();

  @override
  List<Object> get props => [];
}

class ChangeSelectedNote extends SelectedNoteEvent {
  final Note note;

  ChangeSelectedNote(this.note);

  @override
  List<Object> get props => [note];
}

class InitialSelectedEvent extends SelectedNoteEvent {
  @override
  List<Object> get props => [];
}
