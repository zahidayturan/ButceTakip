import 'package:butcekontrol/classes/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/spend_info.dart';
import '../utils/db_helper.dart';


class CategoryInfoRiverpod extends ChangeNotifier {

  late int day ;
  late int month ;
  late int year ;
  late int week ;
  late String category ;
  late int validDateMenu ;
  late int registration;
  late List<String> operationTool;
  late DateTime? range1;
  late DateTime? range2;
  setDateAndCategory(int day,int month,int year,int week,String category,int registration,List<String> operationTool,int validDateMenu, DateTime? range1, DateTime? range2){
    this.day = day;
    this.month = month;
    this.year = year;
    this.week = week;
    this.category = category;
    this.registration = registration;
    this.operationTool = operationTool;
    this.validDateMenu = validDateMenu;
    this.range1 = range1;
    this.range2 = range2;
  }
  String getMonthName(int monthIndex,BuildContext context) {
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

  Future <List<SpendInfo>> myMethod2() async{
    String operationTool1 = operationTool.length == 1 ? operationTool[0] : operationTool[0] ;
    String operationTool2 = operationTool.length == 2 ? operationTool[1] : operationTool[0] ;

    DateTime initialStartDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
    DateTime initialEndDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month+1 : DateTime.now().month}.${DateTime.now().year}');
    DateTime firstDate = range1 ?? initialStartDate ;
    DateTime secondDate = range2 ?? initialEndDate ;

    List<SpendInfo> itemsBase = [];

    if(validDateMenu ==  0){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationYear(year.toString());
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category)
          .toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      itemsBase =  itemsCategory;
    }
    else if(validDateMenu ==  1){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());
      List<SpendInfo> itemsCategory = items.where((element) => element.category == category).toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      itemsBase =  itemsCategory;
    }
    else if(validDateMenu ==  2){
      var date = DateTime.utc(year, month, 1);
      var daysToAdd = ((week - 1) * 7) - date.weekday + 1;
      var startDate = date.add(Duration(days: daysToAdd));
      var endDate = startDate.add(const Duration(days: 6));
      List<List<SpendInfo>> allSpendInfo = [];
      for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
        var date = startDate.add(Duration(days: i));
        List<SpendInfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<SpendInfo> items = allSpendInfo.expand((x) => x).toList();
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category)
          .toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      itemsBase =  itemsCategory;
    }
    else if(validDateMenu ==  3){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category)
          .toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      itemsBase =  itemsCategory;
    }
    else if(validDateMenu ==  4){
      List<List<SpendInfo>> allSpendInfo = [];
      for (var i = 0; i <= secondDate.difference(firstDate).inDays; i++) {
        var date = firstDate.add(Duration(days: i));
        List<SpendInfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<SpendInfo> items = allSpendInfo.expand((x) => x).toList();
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category)
          .toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      itemsBase =  itemsCategory;
    }
    return itemsBase;
  }
  Future <double> getTotalAmount() async{
    String operationTool1 = operationTool.length == 1 ? operationTool[0] : operationTool[0] ;
    String operationTool2 = operationTool.length == 2 ? operationTool[1] : operationTool[0] ;
    DateTime initialStartDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
    DateTime initialEndDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month+1 : DateTime.now().month}.${DateTime.now().year}');
    DateTime firstDate = range1 ?? initialStartDate ;
    DateTime secondDate = range2 ?? initialEndDate ;
    double totalBaseAmount = 0.0;
    if(validDateMenu ==  0){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationYear(year.toString());
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category).toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      double totalAmount = itemsCategory
          .fold(0, (previousValue, element) => previousValue + element.realAmount!);
      totalBaseAmount =  totalAmount;
    }
    else if(validDateMenu ==  1){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category).toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      double totalAmount = itemsCategory
          .fold(0, (previousValue, element) => previousValue + element.realAmount!);
      totalBaseAmount =  totalAmount;
    }
    else if(validDateMenu ==  2){
      var date = DateTime.utc(year, month, 1);
      var daysToAdd = ((week - 1) * 7) - date.weekday + 1;
      var startDate = date.add(Duration(days: daysToAdd));
      var endDate = startDate.add(const Duration(days: 6));
      List<List<SpendInfo>> allSpendInfo = [];
      for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
        var date = startDate.add(Duration(days: i));
        List<SpendInfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<SpendInfo> items = allSpendInfo.expand((x) => x).toList();
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category).toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      double totalAmount = itemsCategory
          .fold(0, (previousValue, element) => previousValue + element.realAmount!);
      totalBaseAmount =  totalAmount;
    }
    else if(validDateMenu ==  3){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category).toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      double totalAmount = itemsCategory
          .fold(0, (previousValue, element) => previousValue + element.realAmount!);
      totalBaseAmount =  totalAmount;
    }
    else if(validDateMenu ==  4){
      List<List<SpendInfo>> allSpendInfo = [];
      for (var i = 0; i <= secondDate.difference(firstDate).inDays; i++) {
        var date = firstDate.add(Duration(days: i));
        List<SpendInfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<SpendInfo> items = allSpendInfo.expand((x) => x).toList();
      List<SpendInfo> itemsCategory = items
          .where((element) => element.category == category).toList();

      itemsCategory = registration == 1 ? itemsCategory.where((element) => element.registration == registration).toList() : itemsCategory;

      itemsCategory = operationTool1 != 'Hepsi' ? itemsCategory.where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2).toList() : itemsCategory;
      double totalAmount = itemsCategory
          .fold(0, (previousValue, element) => previousValue + element.realAmount!);
      totalBaseAmount =  totalAmount;
    }
    return totalBaseAmount;
  }

  List <String> getCategory(BuildContext context)  {
    List <String> categoryName = [];
    categoryName.add(category);
    categoryName.add(translation(context).categoryAppBar);
    return categoryName;
  }
  List<String> getDate(BuildContext context)  {
    DateTime initialStartDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
    DateTime initialEndDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month+1 : DateTime.now().month}.${DateTime.now().year}');
    DateTime firstDate = range1 ?? initialStartDate ;
    DateTime secondDate = range2 ?? initialEndDate ;
    List <String> dateNameBase = [];
    if(validDateMenu == 0 ){
      List <String> dateName = ['$year'];
      dateNameBase = dateName;
    }
    else if(validDateMenu == 1 ){
      List <String> dateName = [];
      dateName.add(getMonthName(month,context));
      dateName.add('$year');
      dateNameBase = dateName;
    }
    else if(validDateMenu == 2 ){
      List <String> dateName = [];
      dateName.add(getMonthName(month,context));
      dateName.add('$year');
      if(week == 1){
        dateName.add(translation(context).firstWeek);
      }
      else if(week == 2){
        dateName.add(translation(context).secondWeek);
      }
      else if(week == 3){
        dateName.add(translation(context).thirdWeek);
      }
      else if(week == 4){
        dateName.add(translation(context).fourthWeek);
      }
      else if(week == 5){
        dateName.add(translation(context).fifthWeek);
      }
      dateNameBase = dateName;
    }
    else if(validDateMenu == 3 ){
      List <String> dateName = [];
      dateName.add('$day');
      dateName.add(getMonthName(month,context));
      dateName.add('$year');
      dateNameBase = dateName;
    }
    else if(validDateMenu == 4 ){
      List <String> dateName = ['${firstDate.day}.${firstDate.month}.${firstDate.year} / ${secondDate.day}.${secondDate.month}.${secondDate.year}'];
      dateNameBase = dateName;
    }

    return dateNameBase;
  }
}
