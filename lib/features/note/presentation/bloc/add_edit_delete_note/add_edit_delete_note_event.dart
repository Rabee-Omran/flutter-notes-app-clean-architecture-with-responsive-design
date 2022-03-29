part of 'add_edit_delete_note_bloc.dart';

abstract class AddEditDeleteNoteEvent extends Equatable {
  const AddEditDeleteNoteEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends AddEditDeleteNoteEvent {
  final Note note;

  AddNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNoteEvent extends AddEditDeleteNoteEvent {
  final Note note;

  UpdateNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends AddEditDeleteNoteEvent {
  final Note note;

  DeleteNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}
