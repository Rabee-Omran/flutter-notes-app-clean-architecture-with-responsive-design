import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetAllNotesUsecase extends UseCase<List<Note>, NoParams> {
  final NoteRepository repository;

  GetAllNotesUsecase(this.repository);

  @override
  Future<Either<Failure, List<Note>>> call(NoParams noParams) async {
    return await repository.getAllNotes();
  }
}
