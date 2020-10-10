import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/models/task.dart';
import 'package:mytodoapp/providers/note_provider.dart';
import 'package:mytodoapp/providers/task_provider.dart';

class Repository {
  final noteProvider = NoteProvider();
  final taskProvider = TaskProvider();

  Future<List<Note>> fetchAllNote() => noteProvider.getAllNotes();

  Future<int> createNote(Note note) => noteProvider.newNote(note);

  Future<int> updateNote(Note note) => noteProvider.updateNote(note);

  Future<int> deleteNote(Note note) => noteProvider.deleteNote(note);

  Future<List<Task>> fetchAllTask() => taskProvider.getAllTasks();

  Future<int> createTask(Task task) => taskProvider.newTask(task);

  Future<int> updatetask(Task task) => taskProvider.updateTask(task);

  Future<int> deletetask(Task task) => taskProvider.deleteTask(task);
}
