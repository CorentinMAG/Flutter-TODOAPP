import 'package:mytodoapp/models/note.dart';
import 'package:mytodoapp/persistance/database.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {
  final dbProvider = DBProvider.db;

  Future<int> newNote(Note newNote) async {
    final db = await dbProvider.database;
    var result = await db.insert(
      'note',
      newNote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<int> deleteNote(Note note) async {
    final db = await dbProvider.database;
    var result = db.delete(
      'note',
      where: "id=?",
      whereArgs: [note.id],
    );
    return result;
  }

  Future<int> updateNote(Note note) async {
    final db = await dbProvider.database;
    var result = db.update(
      'note',
      note.toMap(),
      where: "id=?",
      whereArgs: [note.id],
    );
    return result;
  }

  Future<List<Note>> getAllNotes() async {
    final Database db = await dbProvider.database;

    final List<Map<String, dynamic>> maps = await db.query('note');

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          date: maps[i]['date'],
          title: maps[i]['title'],
          content: maps[i]['content'],
          isArchived: maps[i]['isArchived'],
          isImportant: maps[i]['isImportant'],
          isSelected: maps[i]['isSelected'],
          color: maps[i]['color']);
    });
  }
}
