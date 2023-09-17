import 'dart:async';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/date_time_manager.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class StatisticsRiverpod extends ChangeNotifier {
    /*String operationType = 'Gider';
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    int week = 1;
    int range1 = 1;
    int range2 = 1;
    int dateType = 1 ;
    int registration = 0;
    List<String> operationTool = ['Hepsi'];

   getOperationTools(String operationType, int regOperation, List<String> operationTool, int dateType, int year, int month, int week, int day, int range1, int range2){
     this.operationType = operationType;
     this.registration = regOperation;
     this.operationTool = operationTool;
     this.dateType = dateType;
     this.day = day;
     this.month = month;
     this.year = year;
     this.week = week;
     this.range1 = range1;
     this.range2 = range2;
  }*/

    Future <List<Map<String, dynamic>>> getCategoryList(String operationType, int registration, List<String> operationTool, int dateType, int year, int month, int week, int day, DateTime? range1, DateTime? range2) async {

      List <SpendInfo> filteredList = [];
      List<Map<String, dynamic>> groupedItems = [];

      String operationTool1 = operationTool[0];
      String operationTool2 = operationTool.length == 2 ?  operationTool[1] : '';
      DateTime initialStartDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
      DateTime initialEndDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month+1 : DateTime.now().month}.${DateTime.now().year}');
      DateTime firstDate = range1 ?? initialStartDate ;
      DateTime secondDate = range2 ?? initialEndDate ;

      if(dateType ==  0){
        List<SpendInfo> items = await SQLHelper.getItemsByOperationYear(year.toString());
        if(operationType == 'Hepsi'){
          filteredList = items;
        }else{
          List<SpendInfo> filteredList1 = items
              .where((element) => element.operationType == operationType)
              .toList();
          filteredList = filteredList1;
        }

        filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

        if(operationTool1 == 'Hepsi'){
        }
        else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
          filteredList = filteredList.where((element) => element.operationTool == operationTool1)
            .toList();
        }
        else{
          List<SpendInfo> filteredList1 = filteredList
              .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
              .toList();
          filteredList = filteredList1;
        }

        filteredList.forEach((element) {
          var existingCategoryIndex = groupedItems.indexWhere((item) => item['category'] == element.category);
          if (existingCategoryIndex != -1) {
            groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
          } else {
            groupedItems.add({'category': element.category, 'realAmount': element.realAmount});
          }
        });

        groupedItems.forEach((item) {
          double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
          double percentages = (item['realAmount'] as double) / totalAmount * 100;
          item['percentages'] = percentages.toStringAsFixed(1);
        });

        groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));


      }
      else if(dateType  == 1 ){
        List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(
            month.toString(), year.toString());
        if(operationType == 'Hepsi'){
          filteredList = items;
        }else{
          List<SpendInfo> filteredList1 = items
              .where((element) => element.operationType == operationType)
              .toList();
          filteredList = filteredList1;
        }

        filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

        if(operationTool1 == 'Hepsi'){
        }
        else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
          filteredList = filteredList.where((element) => element.operationTool == operationTool1)
              .toList();
        }
        else{
          List<SpendInfo> filteredList1 = filteredList
              .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
              .toList();
          filteredList = filteredList1;
        }

        filteredList.forEach((element) {
          var existingCategoryIndex = groupedItems.indexWhere((item) => item['category'] == element.category);
          if (existingCategoryIndex != -1) {
            groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
          } else {
            groupedItems.add({'category': element.category, 'realAmount': element.realAmount});
          }
        });

        groupedItems.forEach((item) {
          double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
          double percentages = (item['realAmount'] as double) / totalAmount * 100;
          item['percentages'] = percentages.toStringAsFixed(1);
        });

        groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      }
      else if(dateType  == 2 ){
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
        if(operationType == 'Hepsi'){
          filteredList = items;
        }else{
          List<SpendInfo> filteredList1 = items
              .where((element) => element.operationType == operationType)
              .toList();
          filteredList = filteredList1;
        }

        filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

        if(operationTool1 == 'Hepsi'){
        }
        else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
          filteredList = filteredList.where((element) => element.operationTool == operationTool1)
              .toList();
        }
        else{
          List<SpendInfo> filteredList1 = filteredList
              .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
              .toList();
          filteredList = filteredList1;
        }

        filteredList.forEach((element) {
          var existingCategoryIndex = groupedItems.indexWhere((item) => item['category'] == element.category);
          if (existingCategoryIndex != -1) {
            groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
          } else {
            groupedItems.add({'category': element.category, 'realAmount': element.realAmount});
          }
        });

        groupedItems.forEach((item) {
          double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
          double percentages = (item['realAmount'] as double) / totalAmount * 100;
          item['percentages'] = percentages.toStringAsFixed(1);
        });

        groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));


      }
      else if(dateType  == 3 ){
        List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(),
            month.toString(), year.toString());
        if(operationType == 'Hepsi'){
          filteredList = items;
        }else{
          List<SpendInfo> filteredList1 = items
              .where((element) => element.operationType == operationType)
              .toList();
          filteredList = filteredList1;
        }

        filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

        if(operationTool1 == 'Hepsi'){
        }
        else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
          filteredList = filteredList.where((element) => element.operationTool == operationTool1)
              .toList();
        }
        else{
          List<SpendInfo> filteredList1 = filteredList
              .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
              .toList();
          filteredList = filteredList1;
        }

        filteredList.forEach((element) {
          var existingCategoryIndex = groupedItems.indexWhere((item) => item['category'] == element.category);
          if (existingCategoryIndex != -1) {
            groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
          } else {
            groupedItems.add({'category': element.category, 'realAmount': element.realAmount});
          }
        });

        groupedItems.forEach((item) {
          double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
          double percentages = (item['realAmount'] as double) / totalAmount * 100;
          item['percentages'] = percentages.toStringAsFixed(1);
        });

        groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      }
      else if(dateType  == 4 ){
        List<List<SpendInfo>> allSpendInfo = [];
        for (var i = 0; i <= secondDate.difference(firstDate).inDays; i++) {
          var date = firstDate.add(Duration(days: i));
          List<SpendInfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
              date.day.toString(), date.month.toString(), date.year.toString());
          allSpendInfo.add(spendInfo);
        }
        List<SpendInfo> items = allSpendInfo.expand((x) => x).toList();
        if(operationType == 'Hepsi'){
          filteredList = items;
        }else{
          List<SpendInfo> filteredList1 = items
              .where((element) => element.operationType == operationType)
              .toList();
          filteredList = filteredList1;
        }

        filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

        if(operationTool1 == 'Hepsi'){
        }
        else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
          filteredList = filteredList.where((element) => element.operationTool == operationTool1)
              .toList();
        }
        else{
          List<SpendInfo> filteredList1 = filteredList
              .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
              .toList();
          filteredList = filteredList1;
        }

        filteredList.forEach((element) {
          var existingCategoryIndex = groupedItems.indexWhere((item) => item['category'] == element.category);
          if (existingCategoryIndex != -1) {
            groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
          } else {
            groupedItems.add({'category': element.category, 'realAmount': element.realAmount});
          }
        });

        groupedItems.forEach((item) {
          double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
          double percentages = (item['realAmount'] as double) / totalAmount * 100;
          item['percentages'] = percentages.toStringAsFixed(1);
        });

        groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));
      }
      return Future.value(groupedItems.length > 24 ? groupedItems.sublist(0,23): groupedItems);
    }

  ///pasta için liste
  Future <List<Map<String, dynamic>>> getCategoryAndAmount(String operationType, int registration, List<String> operationTool, int dateType, int year, int month, int week, int day, DateTime? range1, DateTime? range2) async {
    List <SpendInfo> filteredList = [];
    List<Map<String, dynamic>> groupedItems = [];

    String operationTool1 = operationTool[0];
    String operationTool2 = operationTool.length == 2 ?  operationTool[1] : '';

    DateTime initialStartDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month : DateTime.now().month - 1}.${DateTime.now().year}');
    DateTime initialEndDate = DateFormat("dd.MM.yyyy").parse('15.${DateTime.now().day > 15 ? DateTime.now().month+1 : DateTime.now().month}.${DateTime.now().year}');
    DateTime firstDate = range1 ?? initialStartDate ;
    DateTime secondDate = range2 ?? initialEndDate ;

    if(dateType == 0){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationYear(year.toString());

      if(operationType == 'Hepsi'){
        filteredList = items;
      }else{
        List<SpendInfo> filteredList1 = items
            .where((element) => element.operationType == operationType)
            .toList();
        filteredList = filteredList1;
      }

      filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

      if(operationTool1 == 'Hepsi'){
      }
      else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
        filteredList = filteredList.where((element) => element.operationTool == operationTool1)
            .toList();
      }
      else{
        List<SpendInfo> filteredList1 = filteredList
            .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
            .toList();
        filteredList = filteredList1;
      }

      filteredList.forEach((element) {
        var existingCategoryIndex = groupedItems.indexWhere((item) => item['domain'] == element.category);
        if (existingCategoryIndex != -1) {
          groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
        } else {
          groupedItems.add({'domain': element.category, 'realAmount': element.realAmount});
        }
      });

      groupedItems.forEach((item) {
        double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
        double percentages = (item['realAmount'] as double) / totalAmount * 100;
        item['measure'] = percentages.toInt();
      });

      groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      groupedItems.forEach((item) {
        Map<String, dynamic> newMap = {
          'domain': item['domain'],
          'measure': item['measure'],
        };
        item.clear();
        item.addAll(newMap);
      });

    }
    else if(dateType == 1 ){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(
          month.toString(), year.toString());
      if(operationType == 'Hepsi'){
        filteredList = items;
      }else{
        List<SpendInfo> filteredList1 = items
            .where((element) => element.operationType == operationType)
            .toList();
        filteredList = filteredList1;
      }

      filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

      if(operationTool1 == 'Hepsi'){
      }
      else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
        filteredList = filteredList.where((element) => element.operationTool == operationTool1)
            .toList();
      }
      else{
        List<SpendInfo> filteredList1 = filteredList
            .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
            .toList();
        filteredList = filteredList1;
      }

      filteredList.forEach((element) {
        var existingCategoryIndex = groupedItems.indexWhere((item) => item['domain'] == element.category);
        if (existingCategoryIndex != -1) {
          groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
        } else {
          groupedItems.add({'domain': element.category, 'realAmount': element.realAmount});
        }
      });

      groupedItems.forEach((item) {
        double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
        double percentages = (item['realAmount'] as double) / totalAmount * 100;
        item['measure'] = percentages.toInt();
      });

      groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      groupedItems.forEach((item) {
        Map<String, dynamic> newMap = {
          'domain': item['domain'],
          'measure': item['measure'],
        };
        item.clear();
        item.addAll(newMap);
      });

    }
    else if(dateType  == 2 ){
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
      if(operationType == 'Hepsi'){
        filteredList = items;
      }else{
        List<SpendInfo> filteredList1 = items
            .where((element) => element.operationType == operationType)
            .toList();
        filteredList = filteredList1;
      }

      filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

      if(operationTool1 == 'Hepsi'){
      }
      else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
        filteredList = filteredList.where((element) => element.operationTool == operationTool1)
            .toList();
      }
      else{
        List<SpendInfo> filteredList1 = filteredList
            .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
            .toList();
        filteredList = filteredList1;
      }

      filteredList.forEach((element) {
        var existingCategoryIndex = groupedItems.indexWhere((item) => item['domain'] == element.category);
        if (existingCategoryIndex != -1) {
          groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
        } else {
          groupedItems.add({'domain': element.category, 'realAmount': element.realAmount});
        }
      });

      groupedItems.forEach((item) {
        double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
        double percentages = (item['realAmount'] as double) / totalAmount * 100;
        item['measure'] = percentages.toInt();
      });

      groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      groupedItems.forEach((item) {
        Map<String, dynamic> newMap = {
          'domain': item['domain'],
          'measure': item['measure'],
        };
        item.clear();
        item.addAll(newMap);
      });

    }
    else if(dateType  == 3 ){
      List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(), month.toString(), year.toString());
      if(operationType == 'Hepsi'){
        filteredList = items;
      }else{
        List<SpendInfo> filteredList1 = items
            .where((element) => element.operationType == operationType)
            .toList();
        filteredList = filteredList1;
      }

      filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

      if(operationTool1 == 'Hepsi'){
      }
      else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
        filteredList = filteredList.where((element) => element.operationTool == operationTool1)
            .toList();
      }
      else{
        List<SpendInfo> filteredList1 = filteredList
            .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
            .toList();
        filteredList = filteredList1;
      }

      filteredList.forEach((element) {
        var existingCategoryIndex = groupedItems.indexWhere((item) => item['domain'] == element.category);
        if (existingCategoryIndex != -1) {
          groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
        } else {
          groupedItems.add({'domain': element.category, 'realAmount': element.realAmount});
        }
      });

      groupedItems.forEach((item) {
        double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
        double percentages = (item['realAmount'] as double) / totalAmount * 100;
        item['measure'] = percentages.toInt();
      });

      groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      groupedItems.forEach((item) {
        Map<String, dynamic> newMap = {
          'domain': item['domain'],
          'measure': item['measure'],
        };
        item.clear();
        item.addAll(newMap);
      });
    }
    else if(dateType  == 4 ){
      List<List<SpendInfo>> allSpendInfo = [];
      for (var i = 0; i <= secondDate.difference(firstDate).inDays; i++) {
        var date = firstDate.add(Duration(days: i));
        List<SpendInfo> spendInfo = await SQLHelper.getItemsByOperationDayMonthAndYear(
            date.day.toString(), date.month.toString(), date.year.toString());
        allSpendInfo.add(spendInfo);
      }
      List<SpendInfo> items = allSpendInfo.expand((x) => x).toList();
      if(operationType == 'Hepsi'){
        filteredList = items;
      }else{
        List<SpendInfo> filteredList1 = items
            .where((element) => element.operationType == operationType)
            .toList();
        filteredList = filteredList1;
      }

      filteredList = registration == 1 ? filteredList.where((element) => element.registration == registration).toList() : filteredList;

      if(operationTool1 == 'Hepsi'){
      }
      else if(operationTool.length == 1 && operationTool1 != 'Hepsi'){
        filteredList = filteredList.where((element) => element.operationTool == operationTool1)
            .toList();
      }
      else{
        List<SpendInfo> filteredList1 = filteredList
            .where((element) => element.operationTool == operationTool1 || element.operationTool == operationTool2)
            .toList();
        filteredList = filteredList1;
      }

      filteredList.forEach((element) {
        var existingCategoryIndex = groupedItems.indexWhere((item) => item['domain'] == element.category);
        if (existingCategoryIndex != -1) {
          groupedItems[existingCategoryIndex]['realAmount'] += element.realAmount;
        } else {
          groupedItems.add({'domain': element.category, 'realAmount': element.realAmount});
        }
      });

      groupedItems.forEach((item) {
        double totalAmount = groupedItems.fold(0, (sum, item) => sum + item['realAmount']);
        double percentages = (item['realAmount'] as double) / totalAmount * 100;
        item['measure'] = percentages.toInt();
      });

      groupedItems.sort((a, b) => b['realAmount'].compareTo(a['realAmount']));

      groupedItems.forEach((item) {
        Map<String, dynamic> newMap = {
          'domain': item['domain'],
          'measure': item['measure'],
        };
        item.clear();
        item.addAll(newMap);
      });
    }

    return Future.value(groupedItems.length > 24 ? groupedItems.sublist(0,23): groupedItems);
  }



  List<String> getMonths(BuildContext context) {
    List<String> monthList = [
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
  List<String> getYears() {
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
