import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import '../models/spend_info.dart';
import '../utils/db_helper.dart';
import 'package:butcekontrol/classes/language.dart';

class CalendarRiverpod extends ChangeNotifier {

  int currentIndex = (DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12);
  int monthIndex = (((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))%12)+1;
  int yearIndex = (((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))~/12)+2020;


  DateTime startDate = DateTime((((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))~/12)+2020, (((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))%12)+1, 1);
  DateTime endDate = DateTime((((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))~/12)+2020, (((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))%12)+2, 1);

  late PageController pageMonthController;
  late PageController pageYearController;

  Future<void> setMonthStartDay(int monthStartDay) async{
    if(monthStartDay > DateTime.now().day){
      currentIndex = (DateTime.now().month - 2) + ((DateTime.now().year - 2020) * 12);
      monthIndex = (((DateTime.now().month - 2) + ((DateTime.now().year - 2020) * 12))%12)+1;
      yearIndex = (((DateTime.now().month - 2) + ((DateTime.now().year - 2020) * 12))~/12)+2020;
    }
    else if(monthStartDay <= DateTime.now().day){
      currentIndex = (DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12);
      monthIndex = (((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))%12)+1;
      yearIndex = (((DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12))~/12)+2020;
    }
  }

  setIndex(int index,int operation,WidgetRef ref) {
    if(operation == 0){///ay arttırma
      monthIndex = index+1;
      currentIndex = (monthIndex-1)+((yearIndex-2020)*12);
    }
    else if(operation == 1){///yıl arttırma
      yearIndex = index+2020;
      currentIndex = (monthIndex-1)+((yearIndex-2020)*12);
    }
    else if(operation == 2){///page değiştirme
      if(index == 0){///1AY GERİ
        currentIndex = currentIndex-1;
        monthIndex = (currentIndex % 12)+1;
        yearIndex = (currentIndex~/12)+2020;
      }else if(index == 2){///1AY İLERİ
        currentIndex = currentIndex+1;
        monthIndex = (currentIndex % 12)+1;
        yearIndex = (currentIndex~/12)+2020;
      }
      else if(index == 1){///SABİT
        currentIndex = currentIndex;
        monthIndex = (currentIndex % 12)+1;
        yearIndex = (currentIndex~/12)+2020;
      }
    }
    else if(operation == 3){///resetleme
      if(ref.read(settingsRiverpod).monthStartDay! > DateTime.now().day){
        currentIndex = (DateTime.now().month - 2) + ((DateTime.now().year - 2020) * 12);
      }
      else if(ref.read(settingsRiverpod).monthStartDay! <= DateTime.now().day){
        currentIndex = (DateTime.now().month - 1) + ((DateTime.now().year - 2020) * 12);
      }
      monthIndex = (currentIndex % 12)+1;
      yearIndex = (currentIndex~/12)+2020;
    }
  }
  List<int> getIndex() {
    return [currentIndex,monthIndex,yearIndex];
  }
  List<int> indexCalculator(int index){
    int monthIndexCalc = (index % 12)+1;
    int yearIndexCalc = (index~/12)+2020;
    return[monthIndexCalc,yearIndexCalc];
  }
  resetPageController(){
    pageMonthController = PageController(initialPage:monthIndex-1);
    pageYearController = PageController(initialPage: yearIndex-2020);
  }

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

  List<String> getCalendarDays(int year, int month,int startDay) {
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
            DateTime(prevMonthDate.year, prevMonthDate.month, daysInPrevMonth - emptySlots + i + startDay)));

    List<String> currentMonthDays = List.generate(
        daysInMonth,
            (i) => DateFormat('dd.MM.yyyy')
            .format(DateTime(year, month, i + startDay)));
    int remainingSlots = 42 - currentMonthDays.length - prevMonthDays.length;
    DateTime nextMonthDate = DateTime(year, month + 1, 1);


    List<String> nextMonthDays = List.generate(
        remainingSlots,
            (i) => DateFormat('dd.MM.yyyy')
            .format(DateTime(nextMonthDate.year, nextMonthDate.month, i + startDay)));
    print(prevMonthDays);
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
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double result = totalAmount - totalAmount2;
    return Future.value(result);
  }

  Future<List> getMonthAmount(int month, int year, int startDay) async {
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());
    DateTime startDate = DateTime(yearIndex, monthIndex, startDay-1);
    DateTime endDate = DateTime(yearIndex, monthIndex+1, startDay);
    List<SpendInfo> items2 = await SQLHelper.getItemsByOperationMonthAndYear((month+1).toString(), year.toString());
    items.addAll(items2);
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir' && isDateInRange(DateTime(int.parse(element.operationYear!),int.parse(element.operationMonth!),int.parse(element.operationDay!)), startDate, endDate) == true)
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider' && isDateInRange(DateTime(int.parse(element.operationYear!),int.parse(element.operationMonth!),int.parse(element.operationDay!)), startDate, endDate) == true)
        .fold(0, (previousValue, element) => previousValue + element.realAmount!);

    double result = totalAmount - totalAmount2;
    String formattedResult = result.toStringAsFixed(1);
    List amountList = [totalAmount.toStringAsFixed(1),totalAmount2.toStringAsFixed(1),formattedResult];
    return Future.value(amountList);
  }
  bool isDateInRange(DateTime dateToCheck, DateTime startDate, DateTime endDate) {
    return dateToCheck.isAfter(startDate) && dateToCheck.isBefore(endDate);
  }

  Future<List> getMonthAmountCount(int month, int year, int startDay) async {
    DateTime startDate = DateTime(yearIndex, monthIndex, startDay-1);
    DateTime endDate = DateTime(yearIndex, monthIndex+1, startDay);
    List<SpendInfo> items = await SQLHelper.getItemsByOperationMonthAndYear(month.toString(), year.toString());
    List<SpendInfo> items2 = await SQLHelper.getItemsByOperationMonthAndYear((month+1).toString(), year.toString());
    items.addAll(items2);

    var totalCount = items.where((element) => element.operationType == 'Gelir' && isDateInRange(DateTime(int.parse(element.operationYear!),int.parse(element.operationMonth!),int.parse(element.operationDay!)), startDate, endDate) == true);
    int count = totalCount.length;

    var totalCount2 = items.where((element) => element.operationType == 'Gider'&& isDateInRange(DateTime(int.parse(element.operationYear!),int.parse(element.operationMonth!),int.parse(element.operationDay!)), startDate, endDate) == true);
    int count2 = totalCount2.length;

    List amountList = [count,count2];
    return Future.value(amountList);
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
