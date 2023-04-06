import 'package:flutter/foundation.dart';

import '../modals/Spendinfo.dart';
import '../utils/dbHelper.dart';


class DailyInfoRiverpod extends ChangeNotifier {

  late int day ;
  late int month ;
  late int year ;
  setDate(int day,int month,int year){
    this.day = day;
    this.month = month;
    this.year = year;
  }
  String getMonthName(int monthIndex) {
    final months = [
      '',
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'
    ];
    return months[monthIndex];
  }
  getDate(){
    List<String> dateList = [day.toString(),getMonthName(month),year.toString()];
    return dateList;
  }

  Future <List<spendinfo>> myMethod2() async{


    List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(), month.toString(), year.toString());
    notifyListeners();
    return items;
  }

  Future<List> getMonthDaily(int day,int month, int year) async {
    List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());

    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    double result = totalAmount - totalAmount2;
    String formattedResult = result.toStringAsFixed(1);
    List amountList = [totalAmount,totalAmount2,formattedResult,result];
    return Future.value(amountList);
  }

  Future <double> getResult() async {
    List amountList = await getMonthDaily(day, month, year);
    double result = amountList[3];
    return result;
  }

  Future<List> getDayAmountCount(int day, int month, int year) async {
    List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());

    var totalCount = items.where((element) => element.operationType == 'Gelir');
    int count = totalCount.length;

    var totalCount2 = items.where((element) => element.operationType == 'Gider');
    int count2 = totalCount2.length;

    List amountList = [count,count2];
    return Future.value(amountList);
  }
}
