import 'package:sqflite/sqflite.dart';

import '../../models/table/token.dart';
import '../goupee_database.dart';

class TokensTable {
  static const tableName = 'tokens';
  static const createTableQuery = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      app_id TEXT PRIMARY KEY,
      login_token TEXT DEFAULT NULL,
      user_id INTEGER DEFAULT 0,
      is_login INTEGER DEFAULT NULL
    );
  ''';
  static const dropTableQuery = '''
    DROP TABLE IF EXISTS $tableName
  ''';

  static Future<int> insert(Token token) async {
    final Database db = await GoupeeDatabase.instance.database;
    return db.insert(
      tableName,
      token.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> update({required Token token}) async {
    final Database db = await GoupeeDatabase.instance.database;

    return db.update(
      tableName,
      {
        'login_token': token.login_token,
        'user_id': token.user_id,
        'is_login': token.is_login,
      },
      where: 'app_id = ?',
      whereArgs: [token.app_id],
    );
  }

  Future<void> delete() async {
    final Database db = await GoupeeDatabase.instance.database;
    await db.delete(tableName);
  }

  static Future<Token?> getToken() async {
    final Database db = await GoupeeDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      limit: 1,
    );
    return maps.isEmpty ? null : Token.fromMap(maps.first);
  }
}
