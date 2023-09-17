import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/spend_info.dart';
import '../utils/db_helper.dart';
import 'package:butcekontrol/classes/language.dart';


class DailyInfoRiverpod extends ChangeNotifier {

  late int? reg;
  regChange(int? reg){
    this.reg = reg;
    notifyListeners();
  }
  int? setReg(){
    return reg;
  }


  late int day ;
  late int month ;
  late int year ;
  setDate(int day,int month,int year){
    this.day = day;
    this.month = month;
    this.year = year;
  }
  String getMonthName(int monthIndex, BuildContext context) {
    final months = [
      '',
      translation(context).january,
      translation(context).february,
      translation(context).march,
      translation(context).april,
      translation(context).may,
      translation(context).june,
      translation(context).july,
      translation(context).august,
      translation(context).september,
      translation(context).october,
      translation(context).november,
      translation(context).december,
    ];
    return months[monthIndex];
  }
  getDate(BuildContext context){
    List<String> dateList = [day.toString(),getMonthName(month, context),year.toString()];
    return dateList;
  }

  Future <List<SpendInfo>> myMethod2() async{


    List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(), month.toString(), year.toString());
    notifyListeners();
    return items;
  }

  Future<List> getMonthDaily(int day,int month, int year) async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());

    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double result = totalAmount - totalAmount2;
    String formattedResult = result.toStringAsFixed(1);
    List amountList = [totalAmount,totalAmount2.toStringAsFixed(1),formattedResult,result];
    return Future.value(amountList);
  }

  Future <double> getResult() async {
    List amountList = await getMonthDaily(day, month, year);
    double result = amountList[3];
    return result;
  }

  Future<List> getDayAmountCount(int day, int month, int year) async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());

    var totalCount = items.where((element) => element.operationType == 'Gelir');
    int count = totalCount.length;

    var totalCount2 = items.where((element) => element.operationType == 'Gider');
    int count2 = totalCount2.length;

    List amountList = [count,count2];
    return Future.value(amountList);
  }

  void updateRegistration(int? id) async {
    int newRegistrationValue = (reg == 0) ? 1 : 0;
    //int newRegistrationValue = (currentRegistrationValue == 0) ? 0 : 1;
    await SQLHelper.updateRegistration(id, newRegistrationValue);
  }

  bool refrestst = false ;

  late List<SpendInfo> item;
  late  int index;
  setSpendDetail(List<SpendInfo> item, int index){
    this.item = item;
    this.index = index;
  }
  getSpendDetailItem(){
    return item;
  }
  setSpendDetailItemWithId(int id) async{
    List<SpendInfo> item = await SQLHelper.getItemsWithId(id);
    this.item = item;
    index =0;
    refrestst = !refrestst;
    notifyListeners();
  }
  getSpendDetailIndex(){
    return index;
  }
}
