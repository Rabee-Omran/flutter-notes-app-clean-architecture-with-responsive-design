import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/local/note_local_data_source.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final notes = await localDataSource.getAllNotes();
      return Right(notes);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getArchivedNotes() async {
    try {
      final notes = await localDataSource.getArchivedNotes();
      return Right(notes);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getFavoriteNotes() async {
    try {
      final notes = await localDataSource.getFavoriteNotes();
      return Right(notes);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleNoteArchived(Note note) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(Unit);
  }

  @override
  Future<Either<Failure, void>> toggleNoteFavorite(Note note) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(Unit);
  }

  @override
  Future<Either<Failure, void>> addNote(Note note) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(Unit);
  }

  @override
  Future<Either<Failure, void>> deleteNote(Note note) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(Unit);
  }

  @override
  Future<Either<Failure, void>> updateNote(Note note) async {
    await Future.delayed(Duration(seconds: 1));

    return Right(Unit);
  }
}
