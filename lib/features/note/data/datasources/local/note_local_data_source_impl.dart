import '../../models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dump_data.dart';
import 'note_local_data_source.dart';

const CACHED_NOTES = 'CACHED_NOTES';

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  NoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<NoteModel>> getAllNotes() {
    List<NoteModel> notesModel =
        dumpNotes.map((note) => NoteModel.fromJson(note)).toList();

    return Future.value(notesModel);
  }

  @override
  Future<List<NoteModel>> getArchivedNotes() {
    List<NoteModel> notesModel = dumpNotes
        .map((note) => NoteModel.fromJson(note))
        .where((note) => note.isArchived == true)
        .toList();

    return Future.value(notesModel);
  }

  @override
  Future<List<NoteModel>> getFavoriteNotes() {
    List<NoteModel> notesModel = dumpNotes
        .map((note) => NoteModel.fromJson(note))
        .where((note) => note.isFavorite == true)
        .toList();

    return Future.value(notesModel);
  }

  @override
  Future<void> toggleNoteArchived(NoteModel note) {
    return Future.value();
  }

  @override
  Future<void> toggleNoteFavorite(NoteModel note) {
    return Future.value();
  }

  @override
  Future<void> addNote(NoteModel note) {
    return Future.value();
  }

  @override
  Future<void> deleteNote(NoteModel note) {
    return Future.value();
  }

  @override
  Future<void> updateNote(NoteModel note) {
    return Future.value();
  }
}
