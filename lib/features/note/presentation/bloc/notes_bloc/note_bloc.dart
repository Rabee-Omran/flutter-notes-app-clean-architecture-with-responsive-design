import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/usecases/get_all_notes.dart';
import '../../../domain/usecases/get_archived_note.dart';
import '../../../domain/usecases/get_favorite_note.dart';

part 'note_event.dart';
part 'note_state.dart';

enum NotesType { All, Favorite, Archived }

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotesUsecase getAllNotes;
  final GetArchivedNotesUsecase getArchivedNote;
  final GetFavoriteNotesUsecase getFavoriteNotes;

  NoteBloc({
    required this.getAllNotes,
    required this.getArchivedNote,
    required this.getFavoriteNotes,
  }) : super(NotesInitial()) {
    on<NoteEvent>((event, emit) async {
      if (event is GetAllNotesEvent) {
        emit(NotesLoadingState());
        final failureOrNotes = await getAllNotes(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrNotes, NotesType.All));
      } else if (event is GetArchivedNotes) {
        emit(NotesLoadingState());
        final failureOrNotes = await getArchivedNote(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrNotes, NotesType.Archived));
      } else if (event is GetFavoriteNotes) {
        emit(NotesLoadingState());
        final failureOrNotes = await getFavoriteNotes(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrNotes, NotesType.Favorite));
      }
    });
  }

  NoteState _eitherLoadedOrErrorState(
    Either<Failure, List<Note>> either,
    NotesType type,
  ) {
    return either.fold(
      (failure) => NotesErrorState(message: _mapFailureToMessage(failure)),
      (notes) => LoadedNotesState(notes: notes, type: type),
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
