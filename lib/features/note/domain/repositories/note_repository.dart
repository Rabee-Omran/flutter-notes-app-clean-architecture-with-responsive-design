import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, List<Note>>> getFavoriteNotes();
  Future<Either<Failure, List<Note>>> getArchivedNotes();
  Future<Either<Failure, void>> toggleNoteFavorite(Note note);
  Future<Either<Failure, void>> toggleNoteArchived(Note note);
  Future<Either<Failure, void>> addNote(Note note);
  Future<Either<Failure, void>> updateNote(Note note);
  Future<Either<Failure, void>> deleteNote(Note note);
}
