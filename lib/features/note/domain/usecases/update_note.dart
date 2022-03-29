import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UpdateNoteUsecase extends UseCase<void, Note> {
  final NoteRepository repository;

  UpdateNoteUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Note note) async {
    return await repository.updateNote(note);
  }
}
