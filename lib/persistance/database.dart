import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await createDB();
    return _database;
  }

  createDB() async {
    var database = await openDatabase(
        join(await getDatabasesPath(), 'noteandtask.db'),
        version: 2,
        onCreate: initDB,
        onUpgrade: onUpgrade);
    return database;
  }

  Future initDB(Database database, int version) async {
    return await database.execute('CREATE TABLE note('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'date TEXT,'
        'title TEXT,'
        'content TEXT,'
        'isArchived int,'
        'isImportant int,'
        'isSelected int,'
        'color int)');
  }

  Future onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute('DROP TABLE note');
    await initDB(database, newVersion);
  }
}
