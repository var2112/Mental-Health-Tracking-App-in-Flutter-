//Mood Tracker by Dhananjay Tore

import 'package:my_space/model/moods.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "moods1";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'moods1.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title STRING, feeling STRING, date STRING,"
          "time STRING, color STRING)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Mood? mood) async {
    print("insert function called");
    return await _db?.insert(_tableName, mood!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function called");
    return await _db!.query(_tableName);
  }

  static delete(Mood mood) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [mood.id]);
  }
}
