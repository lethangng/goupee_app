import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'tables/search_history_table.dart';
import 'tables/token_table.dart';

class GoupeeDatabase {
  static const dbName = 'goupee.db';
  static const dbVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await init();

    debugPrint('Database path: ${await getDatabasesPath()}');
    return _database!;
  }

  GoupeeDatabase._internal();
  static final GoupeeDatabase instance = GoupeeDatabase._internal();

  static const initScripts = [
    TokensTable.createTableQuery,
    SearchHistoryTable.createTableQuery,
  ];
  static const migrationScripts = [
    TokensTable.dropTableQuery,
    SearchHistoryTable.dropTableQuery,
  ];

  Future<Database> init() async {
    final path = join(
      await getDatabasesPath(),
      dbName,
    );

    Database database = await openDatabase(
      path,
      onCreate: (db, version) {
        initScripts.forEach((scrip) async => await db.execute(scrip));
      },
      onUpgrade: (db, oldVersion, newVersion) {
        migrationScripts.forEach((scrip) async => await db.execute(scrip));
      },
      version: dbVersion,
      singleInstance: true,
    );

    return database;
  }
}
