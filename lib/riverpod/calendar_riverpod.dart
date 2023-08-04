import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:core';

import 'package:intl/intl.dart';

import '../models/spend_info.dart';
import '../utils/db_helper.dart';
import 'package:butcekontrol/classes/language.dart';

class CalendarRiverpod extends ChangeNotifier {
  static const List<int> _daysInMonth = [
    31, // Ocak
    28, // Şubat
    31, // Mart
    30, // Nisan
    31, // Mayıs
    30, // Haziran
    31, // Temmuz
    31, // Ağustos
    30, // Eylül
    31, // Ekim
    30, // Kasım
    31, // Aralık
  ];

  List<String> getCalendarDays(int year, int month) {
    DateTime date = DateTime(year, month);
    int startWeekday = date.weekday;
    int daysInMonth = _daysInMonth[month - 1];
    if (month == DateTime.february &&
        year % 4 == 0 &&
        (year % 100 != 0 || year % 400 == 0)) {
      daysInMonth = 29;
    }
    int emptySlots = (startWeekday - DateTime.monday + 7) % 7;
    DateTime prevMonthDate = date.subtract(Duration(days: emptySlots));
    int daysInPrevMonth = _daysInMonth[prevMonthDate.month - 1];
    List<String> prevMonthDays = List.generate(
        emptySlots,
            (i) => DateFormat('dd.MM.yyyy').format(
            DateTime(prevMonthDate.year, prevMonthDate.month, daysInPrevMonth - emptySlots + i + 1)));
    List<String> currentMonthDays = List.generate(
        daysInMonth,
            (i) => DateFormat('dd.MM.yyyy')
            .format(DateTime(year, month, i + 1)));
    int remainingSlots = 42 - currentMonthDays.length - prevMonthDays.length;
    DateTime nextMonthDate = DateTime(year, month + 1, 1);
    List<String> nextMonthDays = List.generate(
        remainingSlots,
            (i) => DateFormat('dd.MM.yyyy')
            .format(DateTime(nextMonthDate.year, nextMonthDate.month, i + 1)));
    List<String> allDays = [
      ...prevMonthDays,
      ...currentMonthDays,
      ...nextMonthDays
    ];
    return allDays;
  }

  Future<double> getDateColor(int day, int month, int year) async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationDayMonthAndYear(day.toString(), month.toString(), year.toString());

    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    double result = totalAmount - totalAmount2;
    return Future.value(result);
  }

  Future<List> getMonthAmount(int month, int year) async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());

    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    double result = totalAmount - totalAmount2;
    String formattedResult = result.toStringAsFixed(1);
    List amountList = [totalAmount.toStringAsFixed(1),totalAmount2.toStringAsFixed(1),formattedResult];
    return Future.value(amountList);
  }

  Future<List> getMonthAmountCount(int month, int year) async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());

    var totalCount = items.where((element) => element.operationType == 'Gelir');
    int count = totalCount.length;

    var totalCount2 = items.where((element) => element.operationType == 'Gider');
    int count2 = totalCount2.length;

    List amountList = [count,count2];
    return Future.value(amountList);
  }
/*
  getDateColor(int day, int month, int year) {
    ///DATABASE SORGUGU
    double result = 0;
    return result;
  }
*/
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

  List getMonths(BuildContext context) {
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
