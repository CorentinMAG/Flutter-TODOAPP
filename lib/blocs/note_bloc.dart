import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/repositories/note_repository.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final _repository = Repository();
  PublishSubject<List<Note>> _notesFetcher = PublishSubject<List<Note>>();

  Stream<List<Note>> get noteStream => _notesFetcher.stream;

  NotesBloc() {
    fetchAllNotes();
  }

  void fetchAllNotes() async {
    List<Note> notes = await _repository.fetchAllNote();
    if (notes.isEmpty) {
      _notesFetcher.sink.add(null);
    } else {
      _notesFetcher.sink.add(notes);
    }
  }

  void addNote(Note note) async {
    int value = await _repository.createNote(note);
    fetchAllNotes();
  }

  void deleteNote(Note note) async {
    int value = await _repository.deleteNote(note);
    fetchAllNotes();
  }

  void dispose() {
    _notesFetcher.close();
  }
}
