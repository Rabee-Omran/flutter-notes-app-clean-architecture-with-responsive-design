import 'features/note/presentation/bloc/favorite_archived_toggle/favorite_archived_toggle_bloc.dart';

import 'features/note/domain/usecases/add_note.dart';
import 'features/note/domain/usecases/delete_note.dart';
import 'features/note/domain/usecases/get_archived_note.dart';
import 'features/note/domain/usecases/toggle_note_archived.dart';
import 'features/note/domain/usecases/toggle_note_favorite.dart';
import 'features/note/domain/usecases/update_note.dart';
import 'features/note/presentation/bloc/add_edit_delete_note/add_edit_delete_note_bloc.dart';
import 'features/note/presentation/bloc/selected_note_bloc/selected_note_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/note/data/datasources/local/note_local_data_source.dart';
import 'features/note/data/datasources/local/note_local_data_source_impl.dart';
import 'features/note/data/repositories/note_repository_impl.dart';
import 'features/note/domain/repositories/note_repository.dart';
import 'features/note/domain/usecases/get_all_notes.dart';
import 'features/note/domain/usecases/get_favorite_note.dart';
import 'features/note/presentation/bloc/notes_bloc/note_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Notes
  // Bloc
  sl.registerFactory(
    () => NoteBloc(
      getAllNotes: sl(),
      getArchivedNote: sl(),
      getFavoriteNotes: sl(),
    ),
  );
  sl.registerFactory(
    () => SelectedNoteBloc(),
  );
  sl.registerFactory(
    () => AddEditDeleteNoteBloc(
      addNote: sl(),
      updateNote: sl(),
      deleteNote: sl(),
    ),
  );
  sl.registerFactory(
    () => FavoriteArchivedToggleBloc(
      toggleFavorite: sl(),
      toggleArchived: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetAllNotesUsecase(sl()));
  sl.registerLazySingleton(() => GetFavoriteNotesUsecase(sl()));
  sl.registerLazySingleton(() => GetArchivedNotesUsecase(sl()));
  sl.registerLazySingleton(() => AddNoteUsecase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUsecase(sl()));
  sl.registerLazySingleton(() => ToggleNoteArchivedUsecase(sl()));
  sl.registerLazySingleton(() => ToggleNoteFavoriteUsecase(sl()));

  // Repository
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources

  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
