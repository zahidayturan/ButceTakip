import 'package:butcekontrol/modals/settingsinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../modals/Spendinfo.dart';

class SQLHelper {

  static Future <void> createSettingTable(sql.Database database) async{
    await database.execute("""CREATE TABLE setting(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      Prefix TEXT ,
      DarkMode INTEGER,
      isPassword INTEGER,
      Language TEXT,
      isBackUp INTEGER,
      Backuptimes TEXT,
      lastBackup TEXT,
      Password TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

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
      'bka_db2.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await createSettingTable(database);
      },
    );
  }

  static Future<List<settingsinfo>> settingsControl() async{ //settings ablosundaki kayıt saysı liste şeklinde dönüyor
    final db = await SQLHelper.db();
    var result = await db.query('setting', orderBy: "id");
    return  List.generate(result.length, (index){
      return settingsinfo.fromObject(result[index]);
    });
  }
  static Future <int> addItemSetting(settingsinfo info) async{
    final db = await SQLHelper.db();
    final data = info.toMap();
    final id = await db.insert("setting", data, conflictAlgorithm:  sql.ConflictAlgorithm.replace);
    return id;
  }

  static updateSetting(settingsinfo info) async{
    final db = await SQLHelper.db();
    final result =
    await db.update("setting", info.toMap(),where: "id= ?", whereArgs: [info.id]);
    return result;
  }

  static Future<int> createItem(spendinfo info) async {
    final db = await SQLHelper.db();
    final data = info.toMap();
    final id = await db.insert('spendinfo', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  //if()

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
  static Future<int> updateRegistration(int? id, int registration) async {
    final db = await SQLHelper.db();
    final currentRegistration = await db.query("spendinfo", columns: ["registration"], where: "id = ?", whereArgs: [id]);
    final newRegistration = (currentRegistration.first["registration"] == 0) ? 1 : 0;
    final result = await db.update("spendinfo", {"registration": newRegistration}, where: "id = ?", whereArgs: [id]);
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
  static Future<List<spendinfo>> getItemsByOperationYear(String operationYear) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationYear = ?", whereArgs: [operationYear], orderBy: "id");
    return List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }
  //sadece günlük sorgu tehlikeli
  static Future<List<spendinfo>> getItemsByOperationDay(String operationDay) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDay = ?", whereArgs: [operationDay], orderBy: "id");
    return List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }
  static Future<List<spendinfo>> getItemsByOperationDayRange(String startDate, String endDate) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDate >= ? AND operationDate <= ?", whereArgs: [startDate, endDate], orderBy: "id");
    return List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }

  static Future<List<spendinfo>> getItemsByOperationDayMonthAndYear(String operationDay, String operationMonth,String operationYear) async{
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDay = ? AND operationMonth = ? AND operationYear = ?",
      whereArgs: [operationDay,operationMonth, operationYear],
      orderBy: "id",
    );
    return List.generate(result.length, (index) {
      return spendinfo.fromObject(result[index]);
    });
  }
  static Future<List<spendinfo>> getRegisteryQuery() async { //register kayıtlananları getirecek
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "registration = ?",whereArgs: [1], orderBy: "id");
    return List.generate(result.length,(index) {
      return spendinfo.fromObject(result[index]);
    });
  }

  static Future<List<spendinfo>> getItemByMonth(int operationMonth) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationMonth = ?", whereArgs: [operationMonth], orderBy: "id");
    return List.generate(result.length, (index){
      return spendinfo.fromObject(result[index]);
    });
  }

}

