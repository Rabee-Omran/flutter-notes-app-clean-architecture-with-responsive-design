import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class DeleteNoteUsecase extends UseCase<void, Note> {
  final NoteRepository repository;

  DeleteNoteUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Note note) async {
    return await repository.deleteNote(note);
  }
}
