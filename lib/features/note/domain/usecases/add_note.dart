import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class AddNoteUsecase extends UseCase<void, Note> {
  final NoteRepository repository;

  AddNoteUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Note note) async {
    return await repository.addNote(note);
  }
}
