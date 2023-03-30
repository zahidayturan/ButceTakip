import 'package:butcekontrol/utils/DateTimeManager.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import '../modals/Spendinfo.dart';
import 'package:collection/collection.dart';

class DbProvider extends ChangeNotifier {

  int geliramount = 0 ;
  int gideramount = 0 ;
  bool isuseinsert = false ;
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString() ;
  Future<List<spendinfo>> ?daylist ;
  String ?status ;
  String ?day ;
  String ?Date ;
  void setDate() {  ///aylık info da onclicked de kullanılıyor appbar tip 2 için
    if(day!.length == 1){
      if (month.length == 1) {
        this.Date = "0" + day! + "." + "0" + month + "." + year;
      } else
        this.Date = "0" + day! + "." + month + "." + year;
    } else {
      if (month.length == 1) {
        this.Date = day! + "." + "0" + month + "." + year;
      } else
        this.Date = day! + "." + month + "." + year;
    }
  }

  void setStatus(String status){
    this.status = status ;
    notifyListeners();
  }

  void setDay(String day){ /// aylık info da guncelliyoruz gunlukpage de filitre icin.
    this.day = day ;
    notifyListeners();
  }

  void setMonthandYear(month, year) {  /// generalinfo da guncelleniyor
    this.month = month;
    this.year = year;
    notifyListeners();
  }

  void refreshDB() async {
    var data = await SQLHelper.getItems();
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

    Future Delete(int id) async{   /// gunlukpage de kullanıyoruz
      await SQLHelper.deleteItem(id);
      print("silindi");
      refreshDB();
      notifyListeners();
    }
    Future Update(spendinfo info) async{
      await SQLHelper.updateItem(info);
      refreshDB();
      notifyListeners();
    }
    Future <List<spendinfo>> myMethod2() async{  /// gunlukpage filitreleme
      geliramount = 0;
      gideramount = 0;
      List<spendinfo> items =
      await SQLHelper.getItemsByOperationDayMonthAndYear(day!, month, year);  /// month ve year general info da guncelleniyor day ise aylık info onclick:
      for (int index = 0; index < items.length ; index++ ){
        if (items[index].operationType == "Gelir"){
          geliramount++ ;
        }else{
          gideramount++ ;
        }
      }
      notifyListeners();
      return items;
    }

    Stream <Map<String, Object>> myMethod() async* {  /// aylık info filitre için
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