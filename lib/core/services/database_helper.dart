import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DatabaseHelper {

  static const String _newDbName = 'bt_v3-test0.db';
  static const String _oldDbName = 'bt.db';

  static Future<void> _createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE spendinfo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        operationType TEXT,
        categoryId INTEGER,
        operationToolId INTEGER,
        isRegistered BOOLEAN,
        amount REAL,
        note TEXT,
        operationDate TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<void> _createCurrencyTable(sql.Database database) async {
    await database.execute("""CREATE TABLE currency(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      BASE TEXT,
      TRY TEXT,
      USD TEXT,
      EUR TEXT,
      GBP TEXT,
      KWD TEXT,
      JOD TEXT,
      IQD TEXT,
      SAR TEXT,
      lastApiUpdateDate TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<void> _createSettingTable(sql.Database database) async {
    await database.execute("""CREATE TABLE setting(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      darkMode INTEGER,
      )
      """);
  }

  static Future<void> _createCategoriesTable(sql.Database database) async {
    await database.execute("""CREATE TABLE categories(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT NOT NULL UNIQUE,
      type TEXT NOT NULL,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> _createOperationToolsTable(sql.Database database) async {
    await database.execute("""CREATE TABLE operation_tools(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT NOT NULL UNIQUE,
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    final databasePath = await sql.getDatabasesPath();
    final newDbPath = join(databasePath, _newDbName);
    final oldDbPath = join(databasePath, _oldDbName);


    final oldDbExists = await sql.databaseFactory.databaseExists(oldDbPath);

    if (false && oldDbExists) {
      debugPrint("Eski veritabanı bulundu. Veriler yeni veritabanına taşınıyor...");
      final oldDb = await sql.openDatabase(oldDbPath, version: 1);

      final newDb = await sql.openDatabase(
        newDbPath,
        version: 1,
        onCreate: (sql.Database database, int version) async {
          await _createTables(database);
          await _createCurrencyTable(database);
          await _createSettingTable(database);
          await _createCategoriesTable(database);
          await _createOperationToolsTable(database);
        },
      );
      await _migrateData(oldDb, newDb);

      await oldDb.close();
      await sql.databaseFactory.deleteDatabase(oldDbPath);
      debugPrint("Veritabanı başarıyla yeni yapıya taşındı ve eski dosya silindi.");
      return newDb;
    } else {
      debugPrint("Eski veritabanı bulunamadı veya daha önce taşınmış. Yeni veritabanı oluşturuluyor.");
      return sql.openDatabase(
        newDbPath,
        version: 1,
        onCreate: (sql.Database database, int version) async {
          await _createTables(database);
          await _createCurrencyTable(database);
          await _createSettingTable(database);
          await _createCategoriesTable(database);
          await _createOperationToolsTable(database);
        },
      );
    }
  }

  static Future<void> _migrateData(sql.Database oldDb, sql.Database newDb) async {
    final List<Map<String, dynamic>> oldSpendInfo = await oldDb.query('spendinfo');
    final List<Map<String, dynamic>> oldSettings = await oldDb.query('setting');
    final List<Map<String, dynamic>> oldCurrency = await oldDb.query('currency');

    // Eski Ayar ve Döviz verilerini taşı
    for (var item in oldSettings) {
      await newDb.insert('setting', item);
    }
    for (var item in oldCurrency) {
      await newDb.insert('currency', item);
    }

    for (var oldItem in oldSpendInfo) {
      int? categoryId;
      if (oldItem['category'] != null && oldItem['category'] != 'null' && oldItem['operationType'] != null) {
        final List<Map<String, dynamic>> existingCategory = await newDb.query(
          'categories',
          where: 'name = ? AND type = ?',
          whereArgs: [oldItem['category'], oldItem['operationType']],
        );
        if (existingCategory.isEmpty) {
          categoryId = await newDb.insert('categories', {
            'name': oldItem['category'],
            'type': oldItem['operationType'],
          });
        } else {
          categoryId = existingCategory.first['id'];
        }
      }

      int? toolId;
      if (oldItem['operationTool'] != null && oldItem['operationTool'] != 'null') {
        final List<Map<String, dynamic>> existingTool = await newDb.query(
          'operation_tools',
          where: 'name = ?',
          whereArgs: [oldItem['operationTool']],
        );
        if (existingTool.isEmpty) {
          toolId = await newDb.insert('operation_tools', {
            'name': oldItem['operationTool'],
          });
        } else {
          toolId = existingTool.first['id'];
        }
      }

      final newItem = {
        ...oldItem,
        'categoryId': categoryId,
        'operationToolId': toolId,
        'category': null,
        'operationTool': null,
      };
      await newDb.insert('spendinfo', newItem);
    }
  }
}