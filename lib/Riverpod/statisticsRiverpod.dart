import 'dart:async';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticsRiverpod extends ChangeNotifier {

  List<String> GiderKategorileri = [
    "Yemek",
    "Giyim",
    "Eğlence",
    "Eğitim",
    "Aidat/Kira",
    "Alışveriş",
    "Özel-",
    "Ulaşım",
    "Sağlık",
    "Günlük Yaşam",
    "Hobi",
    "Diğer-"
  ];
  List<String> GelirKategorileri = [
    "Harçlık",
    "Burs",
    "Maaş",
    "Kredi",
    "Özel+",
    "Kira/Ödenek",
    "Fazla Mesai",
    "İş Getirisi",
    "Döviz Getirisi",
    "Yatırım Getirisi",
    "Diğer+"
  ];
  List<String> HepsiKategorileri = [
    "Yemek",
    "Giyim",
    "Eğlence",
    "Eğitim",
    "Aidat/Kira",
    "Alışveriş",
    "Özel-",
    "Ulaşım",
    "Sağlık",
    "Günlük Yaşam",
    "Hobi",
    "Diğer-",
    "Harçlık",
    "Burs",
    "Maaş",
    "Kredi",
    "Özel+",
    "Kira/Ödenek",
    "Fazla Mesai",
    "İş Getirisi",
    "Döviz Getirisi",
    "Yatırım Getirisi",
    "Diğer+",
  ];
  List<double> GiderKategoriTutarlari = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<double> HepsiKategoriTutarlari = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<double> GelirKategoriTutarlari = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  ///metin için liste
  Future <List<Map<String, dynamic>>> getCategoryByMonth(int dataType, String type, int year, int month, int week, int day) async {
    List<double> categoryBaseAmounts = [];
    List <String> categoryBaseType = [];
    if(dataType ==  1){
      List<spendinfo> items = await SQLHelper.getItemsByOperationYear(
          year.toString());

      List<double> categoryAmounts;

      if (type == 'Gider') {

        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){

        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {

        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 2 ){
      List<spendinfo> items = await SQLHelper.getItemsByOperationMonthAndYear(
          month.toString(), year.toString());

      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){

        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {

        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 3 ){
      var date = DateTime.utc(year, month, 1);
      var daysToAdd = ((week - 1) * 7) - date.weekday + 1;
      var startDate = date.add(Duration(days: daysToAdd));
      var endDate = startDate.add(Duration(days: 6));
      List<List<spendinfo>> allSpendInfo = [];
      for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
        var date = startDate.add(Duration(days: i));
        List<spendinfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<spendinfo> items = allSpendInfo.expand((x) => x).toList();



      //List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear('24','04','2023');
      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 4 ){
      List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),
          month.toString(), year.toString());

      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }

    if(type == 'Gider'){
      categoryBaseType = GiderKategorileri;
    }
    else if(type == 'Hepsi'){
      categoryBaseType = HepsiKategorileri;
    }
    else{
      categoryBaseType = GelirKategorileri;
    }

    double total = categoryBaseAmounts.fold(0, (a, b) => a + b);
    List<double> percentages = categoryBaseAmounts.map((amount) => double.parse((amount / total * 100).toStringAsFixed(1))).toList();
    List<Map<String, dynamic>> listMap = [];
    for (int i = 0; i < categoryBaseAmounts.length; i++) {
        if (categoryBaseAmounts[i] != 0) {
          Map<String, dynamic> map = {
            'category': categoryBaseType[i],
            'percentages': percentages[i],
            'amount': categoryBaseAmounts[i],
          };
          listMap.add(map);
        }
    }
    listMap.sort((a, b) => b['amount'].compareTo(a['amount']));
    return Future.value(listMap);
  }
    ///pasta için liste
  Future <List<Map<String, dynamic>>> getCategoryAndAmount(int dataType,String type, int year, int month, int week, int day) async {
    List<double> categoryBaseAmounts = [];
    List <String> categoryBaseType = [];
    if(dataType == 1){
      List<spendinfo> items = await SQLHelper.getItemsByOperationYear(
          year.toString());
      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }

      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType == 2 ){
      List<spendinfo> items = await SQLHelper.getItemsByOperationMonthAndYear(
          month.toString(), year.toString());
      List<double> categoryAmounts;
      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 3 ){
      var date = DateTime.utc(year, month, 1);
      var daysToAdd = ((week - 1) * 7) - date.weekday + 1;
      var startDate = date.add(Duration(days: daysToAdd));
      var endDate = startDate.add(Duration(days: 6));
      List<List<spendinfo>> allSpendInfo = [];
      for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
        var date = startDate.add(Duration(days: i));
        List<spendinfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<spendinfo> items = allSpendInfo.expand((x) => x).toList();



      //List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear('24','04','2023');
      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 4 ){
      List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(), month.toString(), year.toString());
      List<double> categoryAmounts;
      if (type == 'Gider') {
        for (var i = 0; i < GiderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == GiderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          GiderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GiderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){

        for (var i = 0; i < HepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == HepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.amount!);

          HepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = HepsiKategoriTutarlari;
      }
      else {

        for (var i = 0; i < GelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == GelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.amount!);
          GelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = GelirKategoriTutarlari;
      }
      type == 'Gider' ? categoryBaseType = GiderKategorileri : categoryBaseType = GelirKategorileri;
      categoryBaseAmounts = categoryAmounts;
    }

    if(type == 'Gider'){
      categoryBaseType = GiderKategorileri;
    }
    else if(type == 'Hepsi'){
      categoryBaseType = HepsiKategorileri;
    }
    else{
      categoryBaseType = GelirKategorileri;
    }
    double total = categoryBaseAmounts.fold(0, (a, b) => a + b);
    List<double> percentages = categoryBaseAmounts.map((amount) => double.parse((amount / total * 100).toStringAsFixed(1))).toList();
    List<Map<String, dynamic>> listMap = [];
    for (int i = 0; i < categoryBaseAmounts.length; i++) {
      if(type != 'Hepsi') {
        if (percentages[i] >= 2) {
          Map<String, dynamic> map = {
            'domain': categoryBaseType[i],
            'measure': percentages[i]
          };
          listMap.add(map);
        }
      }
      else{
        if (percentages[i] >= 4) {
          Map<String, dynamic> map = {
            'domain': categoryBaseType[i],
            'measure': percentages[i]
          };
          listMap.add(map);
        }
      }
    }
    listMap.sort((a, b) => b['measure'].compareTo(a['measure']));
    return Future.value(listMap);
  }


  List getMonths() {
    List<String> MonthList = [
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
    return MonthList;
  }
  List<String> getWeeks(int month, int year) {
    DateTime firstDay = DateTime(year, month, 1);
    int firstWeekday = firstDay.weekday;

    int numDays = DateTime(year, month + 1, 0).day;
    int numWeeks = ((numDays - (7 - firstWeekday)) / 7).ceil() + 1;

    List<String> MonthList = [];
    for (int i = 1; i <= numWeeks; i++) {
      MonthList.add(i.toString());
    }

    return MonthList;
  }
  List<String> getDays(int month, int year) {
    DateTime firstDay = DateTime(year, month, 1);
    DateTime lastDay = DateTime.utc(firstDay.year, firstDay.month + 1, 0);
    int numDays = lastDay.day;

    List<String> days = [];
    for (int i = 1; i <= numDays; i++) {
      days.add(i.toString());
    }
    return days;
  }
  List getYears() {
    List<String> MonthList = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
      '2029',
      '2030',
    ];
    return MonthList;
  }
}
