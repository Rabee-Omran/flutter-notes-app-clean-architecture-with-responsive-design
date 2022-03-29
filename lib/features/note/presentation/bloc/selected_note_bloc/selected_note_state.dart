part of 'selected_note_bloc.dart';

abstract class SelectedNoteState extends Equatable {
  const SelectedNoteState();

  @override
  List<Object> get props => [];
}

class InitialNoteState extends SelectedNoteState {}

class LoadedNoteState extends SelectedNoteState {
  final Note note;

  LoadedNoteState({
    required this.note,
  });

  @override
  List<Object> get props => [note];
}
