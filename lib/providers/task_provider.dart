import 'package:mytodoapp/models/task.dart';
import 'package:mytodoapp/persistance/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskProvider {
  final dbProvider = DBProvider.db;

  Future<int> newTask(Task task) async {
    final Database db = await dbProvider.database;
    var result = await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<int> deleteTask(Task task) async {
    final Database db = await dbProvider.database;
    var result = db.delete(
      'task',
      where: "id=?",
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> updateTask(Task task) async {
    final Database db = await dbProvider.database;
    var result = db.update(
      'task',
      task.toMap(),
      where: "id=?",
      whereArgs: [task.id],
    );
    return result;
  }

  Future<List<Task>> getAllTasks() async {
    final Database db = await dbProvider.database;

    final List<Map<String, dynamic>> maps = await db.query('task');

    return List.generate(maps.length, (i) {
      return Task(
          id: maps[i]['id'],
          date: maps[i]['date'],
          content: maps[i]['content'],
          isTicked: maps[i]['isTicked'],
          isAlarm: maps[i]['isTicked']);
    });
  }
}
