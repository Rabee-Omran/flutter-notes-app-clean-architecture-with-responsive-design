import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class ToggleNoteFavoriteUsecase extends UseCase<void, Note> {
  final NoteRepository repository;

  ToggleNoteFavoriteUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Note note) async {
    return await repository.toggleNoteFavorite(note);
  }
}
