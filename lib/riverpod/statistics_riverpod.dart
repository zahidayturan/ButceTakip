import 'dart:async';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:flutter/material.dart';

class StatisticsRiverpod extends ChangeNotifier {

  List<String> giderKategorileri = [
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
  List<String> gelirKategorileri = [
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
  List<String> hepsiKategorileri = [
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
  List<String> giderKategorileri2 = [
    "Yemek",
    "Giyim",
    "Eğlence",
    "Eğitim",
    "Aidat/\nKira",
    "Alışveriş",
    "Özel-",
    "Ulaşım",
    "Sağlık",
    "Günlük \nYaşam",
    "Hobi",
    "Diğer-"
  ];
  List<String> gelirKategorileri2 = [
    "Harçlık",
    "Burs",
    "Maaş",
    "Kredi",
    "Özel+",
    "Kira/\nÖdenek",
    "Fazla \nMesai",
    "İş Getirisi",
    "Döviz \nGetirisi",
    "Yatırım \nGetirisi",
    "Diğer+"
  ];
  List<String> hepsiKategorileri2 = [
    "Yemek",
    "Giyim",
    "Eğlence",
    "Eğitim",
    "Aidat/\nKira",
    "Alışveriş",
    "Özel-",
    "Ulaşım",
    "Sağlık",
    "Günlük\nYaşam",
    "Hobi",
    "Diğer-",
    "Harçlık",
    "Burs",
    "Maaş",
    "Kredi",
    "Özel+",
    "Kira/\nÖdenek",
    "Fazla \nMesai",
    "İş Getirisi",
    "Döviz \nGetirisi",
    "Yatırım \nGetirisi",
    "Diğer+",
  ];
  List<double> giderKategoriTutarlari = [
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
  List<double> hepsiKategoriTutarlari = [
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
  List<double> gelirKategoriTutarlari = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  ///metin için liste
  Future <List<Map<String, dynamic>>> getCategoryByMonth(int dataType, String type, int year, int month, int week, int day) async {
    List<double> categoryBaseAmounts = [];
    List <String> categoryBaseType = [];
    if(dataType ==  1){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationYear(
          year.toString());

      List<double> categoryAmounts;

      if (type == 'Gider') {

        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){

        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {

        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 2 ){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(
          month.toString(), year.toString());

      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){

        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {

        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 3 ){
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



      //List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear('24','04','2023');
      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 4 ){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),
          month.toString(), year.toString());

      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }

    if(type == 'Gider'){
      categoryBaseType = giderKategorileri;
    }
    else if(type == 'Hepsi'){
      categoryBaseType = hepsiKategorileri;
    }
    else{
      categoryBaseType = gelirKategorileri;
    }

    double total = categoryBaseAmounts.fold(0, (a, b) => a + b);
    List<double> percentages = categoryBaseAmounts.map((amount) => double.parse((amount / total * 100).toStringAsFixed(2))).toList();
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
      List<SpendInfo> items = await SQLHelper.getItemsByOperationYear(
          year.toString());
      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }

      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType == 2 ){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(
          month.toString(), year.toString());
      List<double> categoryAmounts;
      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 3 ){
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



      //List<spendinfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear('24','04','2023');
      List<double> categoryAmounts;

      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){
        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {
        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      categoryBaseAmounts = categoryAmounts;
    }
    else if(dataType  == 4 ){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(), month.toString(), year.toString());
      List<double> categoryAmounts;
      if (type == 'Gider') {
        for (var i = 0; i < giderKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gider')
              .where((element) => element.category == giderKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          giderKategoriTutarlari[i] = amount;
        }
        categoryAmounts = giderKategoriTutarlari;
      }
      else if (type == 'Hepsi'){

        for (var i = 0; i < hepsiKategorileri.length; i++) {
          double amount = items
              .where((element) => element.category == hepsiKategorileri[i])
              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);

          hepsiKategoriTutarlari[i] = amount;
        }
        categoryAmounts = hepsiKategoriTutarlari;
      }
      else {

        for (var i = 0; i < gelirKategorileri.length; i++) {
          double amount = items
              .where((element) => element.operationType == 'Gelir')
              .where((element) => element.category == gelirKategorileri[i])

              .fold(
              0, (previousValue, element) => previousValue + element.realAmount!);
          gelirKategoriTutarlari[i] = amount;
        }
        categoryAmounts = gelirKategoriTutarlari;
      }
      type == 'Gider' ? categoryBaseType = giderKategorileri : categoryBaseType = gelirKategorileri;
      categoryBaseAmounts = categoryAmounts;
    }

    if(type == 'Gider'){
      categoryBaseType = giderKategorileri2;
    }
    else if(type == 'Hepsi'){
      categoryBaseType = hepsiKategorileri2;
    }
    else{
      categoryBaseType = gelirKategorileri2;
    }
    double total = categoryBaseAmounts.fold(0, (a, b) => a + b);
    List<double> percentages = categoryBaseAmounts.map((amount) => double.parse((amount / total * 100).toStringAsFixed(2))).toList();
    List<Map<String, dynamic>> listMap = [];
    for (int i = 0; i < categoryBaseAmounts.length; i++) {
      if(type != 'Hepsi') {
        if (percentages[i] >= 4) {
          Map<String, dynamic> map = {
            'domain': categoryBaseType[i],
            'measure': percentages[i]
          };
          listMap.add(map);
        }
      }
      else{
        if (percentages[i] >= 5) {
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
    List<String> monthList = [
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
    return monthList;
  }
  List<String> getWeeks(int month, int year) {
    DateTime firstDay = DateTime(year, month, 1);
    int firstWeekday = firstDay.weekday;

    int numDays = DateTime(year, month + 1, 0).day;
    int numWeeks = ((numDays - (7 - firstWeekday)) / 7).ceil() + 1;

    List<String> monthList = [];
    for (int i = 1; i <= numWeeks; i++) {
      monthList.add(i.toString());
    }
    return monthList;
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
    List<String> yearList = [
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
    return yearList;
  }
}
