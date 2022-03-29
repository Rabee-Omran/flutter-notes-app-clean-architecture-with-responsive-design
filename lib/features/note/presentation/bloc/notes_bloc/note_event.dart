part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotesEvent extends NoteEvent {
  @override
  List<Object> get props => [];
}

class GetFavoriteNotes extends NoteEvent {
  @override
  List<Object> get props => [];
}

class GetArchivedNotes extends NoteEvent {
  @override
  List<Object> get props => [];
}
