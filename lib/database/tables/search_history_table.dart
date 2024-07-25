import 'package:sqflite/sqflite.dart';

import '../../models/Exam/search_history.dart';
import '../goupee_database.dart';

class SearchHistoryTable {
  static const tableName = 'search_historys';
  static const createTableQuery = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT DEFAULT NULL
    );
  ''';

  static const dropTableQuery = '''
    DROP TABLE IF EXISTS $tableName
  ''';

  static Future<int> insert(SearchHistory searchHistory) async {
    final Database db = await GoupeeDatabase.instance.database;
    return db.insert(
      tableName,
      {'content': searchHistory.content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(int id) async {
    final Database db = await GoupeeDatabase.instance.database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<SearchHistory>?> getList() async {
    final Database db = await GoupeeDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      limit: 15,
    );

    return maps.isEmpty
        ? null
        : maps.map((item) => SearchHistory.fromMap(item)).toList();
  }
}
