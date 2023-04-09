import 'package:butcekontrol/utils/DateTimeManager.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import '../modals/Spendinfo.dart';
import 'package:collection/collection.dart';

class DbProvider extends ChangeNotifier {

  bool isuseinsert = false ;
  bool deletst = false ;
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString() ;
  Future<List<spendinfo>> ?daylist ;
  List<spendinfo> ?registeryListTile ;
  String ?status ;
  String ?day ;
  String ?Date ;
  void setDate(String date) {
    this.Date = date ;
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

  Future insertDataBase(
      String? _operationType ,
      String? _category,
      String? _operationTool,
      int _registration,
      double? _amount,
      String? _note,
      String _operationDate,
      )async {
    String time = _operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    final newinfo = spendinfo(
        _operationType,
        _category,
        _operationTool,
        _registration,
        _amount,
        _note,
        parseDay.toString(),
        parseMonth.toString(),
        parseYear.toString(),
        DateTimeManager.getCurrentTime(),
        _operationDate
    );
    await SQLHelper.createItem(newinfo);
    isuseinsert = !isuseinsert ;
    notifyListeners();
  }

  Future Delete(int id) async{
    await SQLHelper.deleteItem(id);
    print("silindi");
    deletst = !deletst ;
    refreshDB();
    notifyListeners();
  }
  Future Update(spendinfo info) async{
    await SQLHelper.updateItem(info);
    refreshDB();
    notifyListeners();
  }

  Stream <Map<String, Object>> myMethod() async* {
    List<spendinfo> items =
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

  Future <List<spendinfo>> myMethod2() async{
    List<spendinfo> items =
    registeryListTile =  await SQLHelper.getItemsByOperationDayMonthAndYear(day!, month, year);
    notifyListeners();
    return items;
  }

  Future <List<spendinfo>> registeryList() async {
    List<spendinfo> items = await SQLHelper.getRegisteryQuery();
    registeryListTile = items ;
    notifyListeners();
    return items ;
  }

  String getTotalAmount(List<spendinfo> items) {
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(1);
  }

  String getTotalAmountPositive(List<spendinfo> items) {
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    return totalAmount.toStringAsFixed(1);
  }

  String getTotalAmountNegative(List<spendinfo> items) {
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return totalAmount2.toStringAsFixed(1);
  }
}