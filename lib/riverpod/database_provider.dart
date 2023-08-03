import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:flutter/material.dart';
import '../models/spend_info.dart';
import 'package:collection/collection.dart';

class DbProvider extends ChangeNotifier {
  bool isuseinsert = false ;
  bool deletst = false ;
  bool updatest = false ;
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString() ;
  Future<List<SpendInfo>> ?daylist ;
  List<SpendInfo> ?registeryListTile ;
  List<SpendInfo> ?searchListTile ;
  String ?status ;
  String ?day ;
  String ?date ;
  String ?operationType;

  void setDate(String date) {
    this.date = date ;
    notifyListeners();
  }

  void setStatus(String status){
    this.status = status ;
    notifyListeners();
  }

  void setDay(String day){
    this.day = day ;
    notifyListeners();
  }

  void setMonthandYear(month, year) {
    this.month = month;
    this.year = year;
    notifyListeners();
  }

  void refreshDB() async {
    await SQLHelper.getItems();
    myMethod2();
    notifyListeners();
  }

  void changeisuseinsert(){
    isuseinsert != isuseinsert;
    notifyListeners();
  }

  Future insertDataBase(
      String? operationType ,
      String? category,
      String? operationTool,
      int registration,
      double? amount,
      String? note,
      String operationDate,
      String moneyType,
      double ?realAmount,
      )async {
    String time = operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    String processOnce = '0';
    String userCategory = '';
    String systemMessage = '';

    final newinfo = SpendInfo(
        operationType,
        category,
        operationTool,
        registration,
        amount,
        note,
        parseDay.toString(),
        parseMonth.toString(),
        parseYear.toString(),
        DateTimeManager.getCurrentTime(),
        operationDate,
        moneyType,
        processOnce,
        realAmount,
        userCategory,
        systemMessage,
    );
    await SQLHelper.createItem(newinfo);
    isuseinsert = !isuseinsert ;
    notifyListeners();
  }

  Future delete(int id) async{
    await SQLHelper.deleteItem(id);
    deletst = !deletst ;
    refreshDB();
    notifyListeners();
  }

  void update(){
    updatest = !updatest ;
    refreshDB();
    notifyListeners();
  }

  Stream <Map<String, Object>> myMethod() async* {
    List<SpendInfo> items =
    await SQLHelper.getItemsByOperationMonthAndYear(month ,year);
    var groupedItems = groupBy(items, (item) => item.operationDay);
    var dailyTotals = <String, Map<String, double>>{};
    groupedItems.forEach((day, dayItems) {
      double totalAmount = dayItems
          .where((element) => element.operationType == 'Gelir')
          .fold(
          0, (previousValue, element) => previousValue + element.amount!);

      double totalAmount2 = dayItems
          .where((element) => element.operationType == 'Gider')
          .fold(
          0, (previousValue, element) => previousValue + element.amount!);
      dailyTotals[day!] = {
        'totalAmount': totalAmount,
        'totalAmount2': totalAmount2
      };
    });
    dailyTotals = Map.fromEntries(dailyTotals.entries.toList()
      ..sort((e1, e2) => int.parse(e2.key).compareTo(int.parse(e1.key))));
    notifyListeners();
    yield {"items" : items, "dailyTotals" : dailyTotals};
  }

  Future <List<SpendInfo>> myMethod2() async{
    List<SpendInfo> items =
    registeryListTile =  await SQLHelper.getItemsByOperationDayMonthAndYear(day!, month, year);
    notifyListeners();
    return items;
  }


  Future <List<SpendInfo>> registeryList() async {
    List<SpendInfo> items = await SQLHelper.getRegisteryQuery();
    registeryListTile = items ;
    notifyListeners();
    return items ;
  }
  String getTotalAmountByKart(List<SpendInfo> items) {//Bütün net Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationTool == 'Kart')
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationTool == 'Kart')
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmountByNakit(List<SpendInfo> items) {//Bütün net Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationTool == 'Nakit')
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationTool == 'Nakit')
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmountByDiger(List<SpendInfo> items) {//Bütün net Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationTool == 'Diger')
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationTool == 'Diger')
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmount(List<SpendInfo> items) {  //Bütün net Bütçe Gösteriliyor.
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmountPositive(List<SpendInfo> items) { //Gelir olan Kayıtları listeliyor.
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    return totalAmount.toStringAsFixed(1);
  }

  String getTotalAmountNegative(List<SpendInfo> items) { //Gider olan Kayıtları listeliyor.
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return totalAmount2.toStringAsFixed(1);
  }


  static String today = DateTimeManager.getCurrentDay();
  Future<List<SpendInfo>> myDailyMethod() async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationDay(today);
    return items;
  }

  void searchItem(searchText) async {
    searchListTile = await SQLHelper.searchItem(searchText);
    notifyListeners();
  }

}