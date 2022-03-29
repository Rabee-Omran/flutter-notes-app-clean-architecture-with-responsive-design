part of 'add_edit_delete_note_bloc.dart';

abstract class AddEditDeleteNoteState extends Equatable {
  const AddEditDeleteNoteState();

  @override
  List<Object> get props => [];
}

class AddEditDeleteNoteInitial extends AddEditDeleteNoteState {}

class AddEditDelLoadingState extends AddEditDeleteNoteState {}

class AddEditDelErrorState extends AddEditDeleteNoteState {
  final String message;

  const AddEditDelErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddEditDelMessageState extends AddEditDeleteNoteState {
  final String message;

  const AddEditDelMessageState({required this.message});

  @override
  List<Object> get props => [message];
}
