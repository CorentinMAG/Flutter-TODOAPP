import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/providers/note_provider.dart';

class Repository {
  final noteProvider = NoteProvider();

  Future<List<Note>> fetchAllNote() => noteProvider.getAllNotes();

  Future<int> createNote(Note note) => noteProvider.newNote(note);

  Future<int> updateNote(Note note) => noteProvider.updateNote(note);

  Future<int> deleteNote(Note note) => noteProvider.deleteNote(note);
}
