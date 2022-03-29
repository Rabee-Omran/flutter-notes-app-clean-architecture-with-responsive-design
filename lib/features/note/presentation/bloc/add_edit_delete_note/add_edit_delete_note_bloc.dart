import 'package:bloc/bloc.dart';
import '../../../domain/usecases/add_note.dart';
import '../../../domain/usecases/delete_note.dart';
import '../../../domain/usecases/update_note.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/note.dart';

part 'add_edit_delete_note_event.dart';
part 'add_edit_delete_note_state.dart';

class AddEditDeleteNoteBloc
    extends Bloc<AddEditDeleteNoteEvent, AddEditDeleteNoteState> {
  final AddNoteUsecase addNote;
  final UpdateNoteUsecase updateNote;
  final DeleteNoteUsecase deleteNote;
  AddEditDeleteNoteBloc({
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(AddEditDeleteNoteInitial()) {
    on<AddEditDeleteNoteEvent>((event, emit) async {
      if (event is AddNoteEvent) {
        emit(AddEditDelLoadingState());
        final failureOrDone = await addNote(event.note);
        emit(_eitherFailureOrDone(
            either: failureOrDone, successMessage: ADD_SUSCESS_MESSAGE));
      } else if (event is UpdateNoteEvent) {
        emit(AddEditDelLoadingState());
        final failureOrDone = await updateNote(event.note);
        emit(_eitherFailureOrDone(
            either: failureOrDone, successMessage: UPDATE_SUSCESS_MESSAGE));
      } else if (event is DeleteNoteEvent) {
        emit(AddEditDelLoadingState());
        final failureOrDone = await deleteNote(event.note);
        emit(_eitherFailureOrDone(
            either: failureOrDone, successMessage: DELETE_SUSCESS_MESSAGE));
      }
    });
  }

  AddEditDeleteNoteState _eitherFailureOrDone(
      {required Either<Failure, void> either, required String successMessage}) {
    return either.fold(
      (failure) => AddEditDelErrorState(message: _mapFailureToMessage(failure)),
      (_) => AddEditDelMessageState(message: successMessage),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidDataFailure:
        return INVALID_DATA_FAILURE_MESSAGE;

      default:
        return 'Unexpected Error, Please try again later .';
    }
  }
}
