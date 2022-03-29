import '../../models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<List<NoteModel>> getFavoriteNotes();
  Future<List<NoteModel>> getArchivedNotes();
  Future<void> toggleNoteFavorite(NoteModel note);
  Future<void> toggleNoteArchived(NoteModel note);
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(NoteModel note);
}
