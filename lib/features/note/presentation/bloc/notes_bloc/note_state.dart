part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NoteState {}

class NotesLoadingState extends NoteState {}

class NotesErrorState extends NoteState {
  final String message;

  const NotesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class NotesMessageState extends NoteState {
  final String message;

  const NotesMessageState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedNotesState extends NoteState {
  final List<Note> notes;
  final NotesType type;

  LoadedNotesState({
    required this.notes,
    required this.type,
  });

  @override
  List<Object> get props => [notes, type];
}
