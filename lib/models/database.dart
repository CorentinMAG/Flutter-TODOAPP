import 'dart:io';

import 'package:mytodoapp/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'noteandtask.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,title TEXT,content TEXT,isArchived int,isImportant int,color int)');
    }, version: 1);
  }

  newNote(Note newNote) async {
    final db = await database;
    var res = db.insert('note', newNote.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Note>> getAllNotes() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('note');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          date: maps[i]['date'],
          title: maps[i]['title'],
          content: maps[i]['content'],
          isArchived: maps[i]['isArchived'],
          isImportant: maps[i]['isImportant'],
          color: maps[i]['color']);
    });
  }
}
