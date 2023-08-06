import 'package:butcekontrol/models/currency_info.dart';
import 'package:butcekontrol/models/settings_info.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/spend_info.dart';

class SQLHelper {
  static Future <void> createCurrnecyTable(sql.Database database) async {
    database.execute("""CREATE TABLE currency(
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
      lastApiUpdateDate TEXT
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }
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
      securityQu TEXT,
      securityClaim INTEGER,
      adCounter INTEGER,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      prefixSymbol TEXT
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
        moneyType TEXT,
        processOnce TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        realAmount REAL,
        userCategory TEXT,
        systemMessage TEXT
      )
      """);
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'bt.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await createSettingTable(database);
        await createCurrnecyTable(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int  newVersion) {
        if (newVersion > oldVersion) {
          createCurrnecyTable(database);
          database.execute("ALTER TABLE spendinfo ADD COLUMN realAmount REAL DEFAULT 0");
          database.execute("ALTER TABLE spendinfo ADD COLUMN userCategory TEXT DEFAULT '' ");
          database.execute("ALTER TABLE spendinfo ADD COLUMN systemMessage TEXT DEFAULT '' ");
          database.execute("ALTER TABLE setting ADD COLUMN prefixSymbol TEXT DEFAULT '₺' ");
        }
      },
    );
  }
  static Future<List<currencyInfo>> currencyControl() async{ //currency ablosundaki kayıt saysı liste şeklinde dönüyor
    final db = await SQLHelper.db();
    var result = await db.query('currency', orderBy: "id");
    return  List.generate(result.length, (index){
      return currencyInfo.fromObject(result[index]);
    });
  }
  static Future <int> addItemCurrency(currencyInfo info) async{
    final db = await SQLHelper.db();
    final data = info.toMap();
    final id = await db.insert("currency", data, conflictAlgorithm:  sql.ConflictAlgorithm.replace);
    return id;
  }

  static updateCurrency(currencyInfo info) async{
    final db = await SQLHelper.db();
    final result =
    await db.update("currency", info.toMap(),where: "id= ?", whereArgs: [info.id]);
    return result;
  }

  static Future<List<SettingsInfo>> settingsControl() async{ //settings ablosundaki kayıt saysı liste şeklinde dönüyor
    final db = await SQLHelper.db();
    var result = await db.query('setting', orderBy: "id");
    return  List.generate(result.length, (index){
      return SettingsInfo.fromObject(result[index]);
    });
  }

  static Future <int> addItemSetting(SettingsInfo info) async{
    final db = await SQLHelper.db();
    final data = info.toMap();
    final id = await db.insert("setting", data, conflictAlgorithm:  sql.ConflictAlgorithm.replace);
    return id;
  }

  static updateSetting(SettingsInfo info) async{
    final db = await SQLHelper.db();
    final result =
    await db.update("setting", info.toMap(),where: "id= ?", whereArgs: [info.id]);
    return result;
  }

  static Future<int> createItem(SpendInfo info) async {
    final db = await SQLHelper.db();
    final data = info.toMap();
    final id = await db.insert('spendinfo', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  //if()

  static Future<List<SpendInfo>> getItems() async { //Bütün kayıtları çekiyor spendinfo
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', orderBy: "id");
    return  List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }

  static Future<int> updateItem(SpendInfo info) async {
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
  static Future<List<SpendInfo>> searchItem(String searchText) async {
    final db = await SQLHelper.db();
    var result = await db.rawQuery("SELECT * FROM spendinfo WHERE (note LIKE '%${searchText}%' OR category LIKE '%${searchText}%') AND note != '' AND category != ''");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }

  static Future<List<SpendInfo>> getItemsByOperationMonthAndYear(String operationMonth, String operationYear) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationMonth = ? AND operationYear = ?", whereArgs: [operationMonth, operationYear], orderBy: "id");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }
  static Future<List<SpendInfo>> getItemsByOperationYear(String operationYear) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationYear = ?", whereArgs: [operationYear], orderBy: "id");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }
  //sadece günlük sorgu tehlikeli
  static Future<List<SpendInfo>> getItemsByOperationDay(String operationDay) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDay = ?", whereArgs: [operationDay], orderBy: "id");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }
  static Future<List<SpendInfo>> getItemsByOperationDayRange(String startDate, String endDate) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDate >= ? AND operationDate <= ?", whereArgs: [startDate, endDate], orderBy: "id");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }
  static Future<List<SpendInfo>> getItemsByOperationType(String operationType) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationType = ?", whereArgs: [operationType], orderBy: "id");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }
  static Future<List<SpendInfo>> getItemsByOperationDayMonthAndYear(String operationDay, String operationMonth,String operationYear) async{
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationDay = ? AND operationMonth = ? AND operationYear = ?",
      whereArgs: [operationDay,operationMonth, operationYear],
      orderBy: "id",
    );
    return List.generate(result.length, (index) {
      return SpendInfo.fromObject(result[index]);
    });
  }
  static Future<List<SpendInfo>> getRegisteryQuery() async { //register kayıtlananları getirecek
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "registration = ?",whereArgs: [1], orderBy: "id");
    return List.generate(result.length,(index) {
      return SpendInfo.fromObject(result[index]);
    });
  }

  static Future<List<SpendInfo>> getItemByMonth(int operationMonth) async {
    final db = await SQLHelper.db();
    var result = await db.query('spendinfo', where: "operationMonth = ?", whereArgs: [operationMonth], orderBy: "id");
    return List.generate(result.length, (index){
      return SpendInfo.fromObject(result[index]);
    });
  }
 //çok tehlikeli bir fonksiyon tüm tabloyu siliyor geri döndürülemez.
  static Future <void> deleteTable(String tableName) async {
    final db = await SQLHelper.db();
    await db.delete(tableName);
  }
}

