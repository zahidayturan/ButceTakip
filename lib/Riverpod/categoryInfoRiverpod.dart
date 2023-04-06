import 'package:flutter/foundation.dart';

import '../modals/Spendinfo.dart';
import '../utils/dbHelper.dart';


class CategoryInfoRiverpod extends ChangeNotifier {

  late int day ;
  late int month ;
  late int year ;
  late int week ;
  late String category ;
  late int validDateMenu ;
  setDateAndCategory(int day,int month,int year,int week,String category,int validDateMenu){
    this.day = day;
    this.month = month;
    this.year = year;
    this.week = week;
    this.category = category;
    this.validDateMenu = validDateMenu;
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

  Future <List<spendinfo>> myMethod2() async{
    List<spendinfo> itemsBase = [];

    if(validDateMenu ==  1){
      List<spendinfo> items = await SQLHelper.getItemsByOperationYear(year.toString());
      List<spendinfo> itemsCategory = items.where((element) => element.category == category).toList();
      itemsBase =  itemsCategory;
    }
    if(validDateMenu ==  2){
      List<spendinfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());
      List<spendinfo> itemsCategory = items.where((element) => element.category == category).toList();
      itemsBase =  itemsCategory;
    }
    if(validDateMenu ==  4){
      List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());
      List<spendinfo> itemsCategory = items.where((element) => element.category == category).toList();
      itemsBase =  itemsCategory;
    }
    return itemsBase;
  }
  Future <double> getTotalAmount() async{
    double totalBaseAmount = 0.0;

    if(validDateMenu ==  1){
      List<spendinfo> items = await SQLHelper.getItemsByOperationYear(year.toString());
      double totalAmount = items
          .where((element) => element.category == category)
          .fold(0, (previousValue, element) => previousValue + element.amount!);
      totalBaseAmount =  totalAmount;
    }
    if(validDateMenu ==  2){
      List<spendinfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());
      double totalAmount = items
          .where((element) => element.category == category)
          .fold(0, (previousValue, element) => previousValue + element.amount!);
      totalBaseAmount =  totalAmount;
    }
    if(validDateMenu ==  4){
      List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),month.toString(), year.toString());
      double totalAmount = items
          .where((element) => element.category == category)
          .fold(0, (previousValue, element) => previousValue + element.amount!);
      totalBaseAmount =  totalAmount;
    }
    return totalBaseAmount;
  }

  List <String> getCategory()  {
    List <String> categoryName = ['${category} Kategorisi'];
    return categoryName;
  }
  List <String> getDate()  {
    List <String> dateNameBase = [];
    if(validDateMenu == 1 ){
      List <String> dateName = ['${year} Yılı'];
      dateNameBase = dateName;
    }
    else if(validDateMenu == 2 ){
      List <String> dateName = ['${year} Yılı  ${getMonthName(month)} Ayı'];
      dateNameBase = dateName;
    }
    else if(validDateMenu == 4 ){
      List <String> dateName = ['${year} Yılı  ${getMonthName(month)} Ayı  ${day}. Günü'];
      dateNameBase = dateName;
    }

    return dateNameBase;
  }
}
