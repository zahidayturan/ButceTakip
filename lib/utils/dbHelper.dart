import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../modals/Spendinfo.dart';

class SQLHelper {

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE spendinfo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        operationType TEXT,
        category TEXT,
        operationTool TEXT,
        registration INTEGER,
        amount REAL,
        note TEXT,
        operationDay TEXT,
        operationMonth TEXT,
        operationYear TEXT,
        operationTime TEXT,
        operationDate TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'bka_db3.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(spendinfo info) async {
    final db = await SQLHelper.db();
    final data = info.toMap();
    final id = await db.insert('spendinfo', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<spendinfo>> getItems() async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', orderBy: "id");
    return  List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }

  static Future<int> updateItem(spendinfo info) async {
    final db = await SQLHelper.db();
    final result =
    await db.update("spendinfo", info.toMap(),where: "id= ?", whereArgs: [info.id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("spendinfo", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<spendinfo>> getItemsByOperationMonthAndYear(String operationMonth, String operationYear) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationMonth = ? AND operationYear = ?", whereArgs: [operationMonth, operationYear], orderBy: "id");
    return List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }

  static Future<List<spendinfo>> getItemsByOperationDay(String operationDay) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDay = ?", whereArgs: [operationDay], orderBy: "id");
    return List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }

}

