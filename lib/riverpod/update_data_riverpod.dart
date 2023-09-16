import 'package:butcekontrol/models/spend_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod_management.dart';
import '../utils/date_time_manager.dart';
import '../utils/db_helper.dart';

class UpdateDataRiverpod extends ChangeNotifier {
  SpendInfo? items;
  var id;
  var menuController;

  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _operationType = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _operationTool = TextEditingController();
  final TextEditingController _registration = TextEditingController();
  final TextEditingController _operationDate = TextEditingController();
  final TextEditingController _moneyType = TextEditingController();
  final TextEditingController _customize = TextEditingController();
  final TextEditingController _realAmount = TextEditingController();
  final TextEditingController _userCategory = TextEditingController();
  final TextEditingController _systemMessage = TextEditingController();

  setMenu(int menuController) {
    this.menuController = menuController;
  }

  setItems(SpendInfo items) {
    this.items = items;
    id = items.id.toString();
    _note.text = items.note.toString();
    _amount.text = items.amount.toString();
    _operationType.text = items.operationType.toString();
    _category.text = items.category.toString();
    _operationTool.text = items.operationTool.toString();
    _registration.text = items.registration.toString();
    _operationDate.text = items.operationDate.toString();
    _moneyType.text = items.moneyType.toString();
    _customize.text = items.processOnce.toString();
    _realAmount.text = items.realAmount.toString();
    _userCategory.text = items.userCategory.toString();
    _systemMessage.text = items.systemMessage.toString();
  }

  getMenuController(){
    return menuController;
  }

  getId() {
    return id;
  }

  getNote() {
    return _note;
  }

  getType() {
    return _operationType;
  }

  getAmount() {
    return _amount;
  }

  getOperationTool() {
    return _operationTool;
  }

  getCategory() {
    return _category;
  }

  getRegistration() {
    return _registration;
  }

  getOperationDate() {
    return _operationDate;
  }

  getMoneyType() {
    return _moneyType;
  }
  getProcessOnce() {
    return _customize;
  }
  getRealAmount() {
    return _realAmount;
  }

  getUserCategory() {
    return _userCategory;
  }

  getSystemMessage() {
    return _systemMessage;
  }

  bool isuseinsert = false;

  Future updateDataBase(
      int id,
      String? operationType ,
      String? category,
      String? operationTool,
      int registration,
      double? amount,
      String? note,
      String operationDate,
      String moneyType,
      String processOnce,
      double? realamount,
      String userCategory,
      String systemMessage
      )async {
    String time = operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    final updateinfo = SpendInfo.withId(
        id,
        operationType,
        category,
        operationTool,
        registration,
        amount,
        note,
        parseDay.toString(),
        parseMonth.toString(),
        parseYear.toString(),
        DateTimeManager.getCurrentTime(),
        operationDate,
        moneyType,
        processOnce,
        realamount,
        userCategory,
        systemMessage
    );
    await SQLHelper.updateItem(updateinfo);
    isuseinsert = !isuseinsert;
    notifyListeners();
  }

  void removeProcessOnce(int id){
    SQLHelper.updateCustomize(id, "");
  }

  Future<Map<String, List<String>>> myCategoryLists(BuildContext context) async {
    List<SpendInfo> spendInfoListExpense =
        await SQLHelper.getCategoryListByType('Gider');
    List<String> categoryListExpense = [];
/*
    List<String> oldCategoryListExpense = [
      "الهوايات",
      "Hobi",
      "Hobby"
    ];
*/
    for (var spendInfo in spendInfoListExpense) {
      if (!categoryListExpense.contains(spendInfo.userCategory) && spendInfo.userCategory != '') {
        /*if(oldCategoryListExpense.contains(spendInfo.userCategory) == false){
          categoryListExpense.add(spendInfo.userCategory!);
        }*/
          categoryListExpense.add(spendInfo.userCategory!);
      }
    }

    List<SpendInfo> spendInfoListIncome =
        await SQLHelper.getCategoryListByType('Gelir');
    List<String> categoryListIncome = [];

    for (var spendInfo in spendInfoListIncome) {
      if (!categoryListIncome.contains(spendInfo.userCategory) && spendInfo.userCategory != '') {
        categoryListIncome.add(spendInfo.userCategory!);
      }
    }
    return {
      'expense': categoryListExpense,
      'income': categoryListIncome,
    };
  }

  Future<List<SpendInfo>> getCustomizeRepeatedOperation() async {
    List<SpendInfo> customizeItems = await SQLHelper.getCustomizeOperationList();
    List<SpendInfo> filteredList = customizeItems
        .where((element) => _isProcessOnceValid(element.processOnce!))
        .toList();
    return filteredList;
  }

  bool _isProcessOnceValid(String processOnce) {
    return !processOnce.contains(RegExp(r'\d'));
  }

  Future<List<SpendInfo>> getCustomizeInstallmentOperation() async {
    List<SpendInfo> customizeItems = await SQLHelper.getCustomizeOperationList();
    List<SpendInfo> filteredList = customizeItems
        .where((element) => _isProcessOnceValidNumber(element.processOnce!))
        .toList();
    return filteredList;
  }

  Future customizeRepeatedOperation(WidgetRef ref) async {
    List<SpendInfo> customizeItems = await SQLHelper.getCustomizeOperationList();
    customizeItems.forEach((item) {
      if (item.processOnce == 'Günlük')  {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);
        if (operationDate.isBefore(currentDate)) {
          int calculateDaysBetween(DateTime date1, DateTime date2) {
            Duration difference = date2.difference(date1);
            print("Fark Hesaplandı ${difference.inDays}");
            return difference.inDays;
          }

          DateTime date1 = DateTime(int.parse(item.operationYear!),
              int.parse(item.operationMonth!), int.parse(item.operationDay!));
          DateTime date2 = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          int daysBetween = calculateDaysBetween(date1, date2);

          date1 = date1.add(Duration(days: 1));
          for (int i = 0; i < daysBetween; i++) {
            final newinfo = SpendInfo(
              item.operationType,
              item.category,
              item.operationTool,
              item.registration,
              item.amount,
              item.note,
              date1.day.toString(),
              date1.month.toString(),
              date1.year.toString(),
              DateTimeManager.getCurrentTime(),
              "${date1.day.toString()}.${date1.month.toString()}.${date1.year.toString()}", // item.operationDate güncellendi
              item.moneyType,
              i == daysBetween - 1 ? item.processOnce : "",
              //item.realAmount,
              ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
              item.userCategory,
              item.systemMessage
            );
            SQLHelper.createItem(newinfo);
            print("Veri Eklendi ${item.operationDate} - ${item.processOnce}");
            // Bir sonraki günün tarihini al
            date1 = date1.add(Duration(days: 1));
          }
          SQLHelper.updateCustomize(item.id, "");
        } else {
          null;
        }
      } else if(item.processOnce == 'Haftalık') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);
        int calculateDaysBetween(DateTime date1, DateTime date2) {
          Duration difference = date2.difference(date1);
          print("Fark Hesaplandı ${difference.inDays}");
          return difference.inDays~/7;
        }
        DateTime date1 = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!));
        DateTime date2 = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        int daysBetween = calculateDaysBetween(date1, date2);
        if (operationDate.isBefore(currentDate) && daysBetween != 0) {

          date1 = date1.add(Duration(days: 7));
          for (int i = 0; i < daysBetween; i++) {
            final newinfo = SpendInfo(
              item.operationType,
              item.category,
              item.operationTool,
              item.registration,
              item.amount,
              item.note,
              date1.day.toString(),
              date1.month.toString(),
              date1.year.toString(),
              DateTimeManager.getCurrentTime(),
              "${date1.day.toString()}.${date1.month.toString()}.${date1.year.toString()}", // item.operationDate güncellendi
              item.moneyType,
              i == daysBetween - 1 ? item.processOnce : "",
              //item.realAmount,
              ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
              item.userCategory,
              item.systemMessage
            );
            SQLHelper.createItem(newinfo);
            print("Veri Eklendi ${item.operationDate} - ${item.processOnce}");
            // Bir sonraki günün tarihini al
            date1 = date1.add(Duration(days: 7));
          }
          SQLHelper.updateCustomize(item.id, "");
      }else{

      }
    }
      else if(item.processOnce == 'İki Haftada Bir') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);
        int calculateDaysBetween(DateTime date1, DateTime date2) {
          Duration difference = date2.difference(date1);
          print("Fark Hesaplandı ${difference.inDays}");
          return difference.inDays~/14;
        }
        DateTime date1 = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!));
        DateTime date2 = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        int daysBetween = calculateDaysBetween(date1, date2);
        if (operationDate.isBefore(currentDate) && daysBetween != 0) {

          date1 = date1.add(Duration(days: 14));
          for (int i = 0; i < daysBetween; i++) {
            final newinfo = SpendInfo(
              item.operationType,
              item.category,
              item.operationTool,
              item.registration,
              item.amount,
              item.note,
              date1.day.toString(),
              date1.month.toString(),
              date1.year.toString(),
              DateTimeManager.getCurrentTime(),
              "${date1.day.toString()}.${date1.month.toString()}.${date1.year.toString()}", // item.operationDate güncellendi
              item.moneyType,
              i == daysBetween - 1 ? item.processOnce : "",
              //item.realAmount,
              ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
              item.userCategory,
              item.systemMessage
            );
            SQLHelper.createItem(newinfo);
            print("Veri Eklendi ${item.operationDate} - ${item.processOnce}");
            // Bir sonraki günün tarihini al
            date1 = date1.add(Duration(days: 14));
          }
          SQLHelper.updateCustomize(item.id, "");
        }else{

        }
      } else if(item.processOnce == 'Aylık') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);

        if (!currentDate.isBefore(operationDate)) {
          int calculateMonthsBetween(DateTime date1, DateTime date2) {
            int difference = 0 ;
            int differenceYear = 0;
            if(date2.day < date1.day){
              difference = (date2.month - date1.month) -1;
            }
            else if(date2.day == date1.day){
              difference = date2.month - date1.month;
            }
            else if(date2.day > date1.day){
              difference = date2.month - date1.month;
            }
            else{
              difference = 1;
            }
            differenceYear = date2.year - date1.year;
            return (differenceYear*12)+difference;
          }
          DateTime date1 = DateTime(int.parse(item.operationYear!),
              int.parse(item.operationMonth!), int.parse(item.operationDay!));
          DateTime date2 = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          int monthsBetween = calculateMonthsBetween(date1, date2);

          calculateInitialDate(DateTime date,int count) {
            DateTime initialDate = DateTime(date.year, date.month, date.day);
            for(int i =0 ; i < count ; i++){
              print("\n Hesaplanan $date");
              int nextMonth = date.month + 1;

              int nextYear = date.year;
              print(nextYear);
              if (nextMonth > 12) {
                nextMonth = 1;
                nextYear++;
              }print(nextMonth);
              int lastDayOfMonth = DateTime(date.year, date.month+1, 0).day;
              int lastDayOfNextMonth = DateTime(nextYear, nextMonth+1, 0).day;
              print("last day $lastDayOfMonth");
              print("last day next month $lastDayOfNextMonth");
              if (date.day == lastDayOfMonth) {
                print("Son gün");
                initialDate = DateTime(nextYear, nextMonth, lastDayOfNextMonth);
              } else if(nextMonth == 2 && date.day > 28) {
                print("Değil Ama Şubat");
                initialDate = DateTime(nextYear, nextMonth,lastDayOfNextMonth);
              } else {
                print("Değil");
                initialDate = DateTime(nextYear, nextMonth,date.day);
              }
              print("Sonuç $initialDate");
              date = initialDate;

              final newinfo = SpendInfo(
                  item.operationType,
                  item.category,
                  item.operationTool,
                  item.registration,
                  item.amount,
                  item.note,
                  initialDate.day.toString(),
                  initialDate.month.toString(),
                  initialDate.year.toString(),
                  DateTimeManager.getCurrentTime(),
                  "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
                  item.moneyType,
                  i == monthsBetween - 1 ? item.processOnce : "",
                  //item.realAmount,
                  ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
                  item.userCategory,
                  item.systemMessage
              );
              SQLHelper.createItem(newinfo);
              SQLHelper.updateCustomize(item.id, "");
            }
          }
          calculateInitialDate(date1, monthsBetween);
        }else{

        }
      }else if(item.processOnce == 'İki Ayda Bir') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);

        if (!currentDate.isBefore(operationDate)) {
          int calculateMonthsBetween(DateTime date1, DateTime date2) {
            int difference = 0 ;
            int differenceYear = 0;
            if(date2.day < date1.day){
              difference = (date2.month - date1.month) -1;
            }
            else if(date2.day == date1.day){
              difference = date2.month - date1.month;
            }
            else if(date2.day > date1.day){
              difference = date2.month - date1.month;
            }
            else{
              difference = 1;
            }
            differenceYear = date2.year - date1.year;
            return (differenceYear*12)+difference;
          }
          DateTime date1 = DateTime(int.parse(item.operationYear!),
              int.parse(item.operationMonth!), int.parse(item.operationDay!));
          DateTime date2 = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          int monthsBetween = calculateMonthsBetween(date1, date2);

          calculateInitialDate(DateTime date,int count){
            DateTime initialDate = DateTime(date.year, date.month, date.day);
            for(int i =0 ; i < count ; i++){
              print("\n Hesaplanan $date");
              int nextMonth = date.month + 2;

              int nextYear = date.year;
              print(nextYear);
              if (nextMonth > 12) {
                nextMonth = 1;
                nextYear++;
              }print(nextMonth);
              int lastDayOfMonth = DateTime(date.year, date.month+1, 0).day;
              int lastDayOfNextMonth = DateTime(nextYear, nextMonth+1, 0).day;
              print("last day $lastDayOfMonth");
              print("last day next month $lastDayOfNextMonth");
              if (date.day == lastDayOfMonth) {
                print("Son gün");
                initialDate = DateTime(nextYear, nextMonth, lastDayOfNextMonth);
              } else if(nextMonth == 2 && date.day > 28) {
                print("Değil Ama Şubat");
                initialDate = DateTime(nextYear, nextMonth,lastDayOfNextMonth);
              } else {
                print("Değil");
                initialDate = DateTime(nextYear, nextMonth,date.day);
              }
              print("Sonuç $initialDate");
              date = initialDate;

              final newinfo = SpendInfo(
                  item.operationType,
                  item.category,
                  item.operationTool,
                  item.registration,
                  item.amount,
                  item.note,
                  initialDate.day.toString(),
                  initialDate.month.toString(),
                  initialDate.year.toString(),
                  DateTimeManager.getCurrentTime(),
                  "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
                  item.moneyType,
                  i == monthsBetween - 1 ? item.processOnce : "",
                  //item.realAmount,
                  ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
                  item.userCategory,
                  item.systemMessage
              );
              SQLHelper.createItem(newinfo);
              SQLHelper.updateCustomize(item.id, "");
            }
          }
          calculateInitialDate(date1, monthsBetween);
        }else{

        }
      }else if(item.processOnce == 'Dört Ayda Bir') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);

        if (!currentDate.isBefore(operationDate)) {
          int calculateMonthsBetween(DateTime date1, DateTime date2) {
            int difference = 0 ;
            int differenceYear = 0;
            if(date2.day < date1.day){
              difference = (date2.month - date1.month) -1;
            }
            else if(date2.day == date1.day){
              difference = date2.month - date1.month;
            }
            else if(date2.day > date1.day){
              difference = date2.month - date1.month;
            }
            else{
              difference = 1;
            }
            differenceYear = date2.year - date1.year;
            return (differenceYear*12)+difference;
          }
          DateTime date1 = DateTime(int.parse(item.operationYear!),
              int.parse(item.operationMonth!), int.parse(item.operationDay!));
          DateTime date2 = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          int monthsBetween = calculateMonthsBetween(date1, date2);

          calculateInitialDate(DateTime date,int count){
            DateTime initialDate = DateTime(date.year, date.month, date.day);
            for(int i =0 ; i < count ; i++){
              print("\n Hesaplanan $date");
              int nextMonth = date.month + 4;

              int nextYear = date.year;
              print(nextYear);
              if (nextMonth > 12) {
                nextMonth = 1;
                nextYear++;
              }print(nextMonth);
              int lastDayOfMonth = DateTime(date.year, date.month+1, 0).day;
              int lastDayOfNextMonth = DateTime(nextYear, nextMonth+1, 0).day;
              print("last day $lastDayOfMonth");
              print("last day next month $lastDayOfNextMonth");
              if (date.day == lastDayOfMonth) {
                print("Son gün");
                initialDate = DateTime(nextYear, nextMonth, lastDayOfNextMonth);
              } else if(nextMonth == 2 && date.day > 28) {
                print("Değil Ama Şubat");
                initialDate = DateTime(nextYear, nextMonth,lastDayOfNextMonth);
              } else {
                print("Değil");
                initialDate = DateTime(nextYear, nextMonth,date.day);
              }
              print("Sonuç $initialDate");
              date = initialDate;

              final newinfo = SpendInfo(
                  item.operationType,
                  item.category,
                  item.operationTool,
                  item.registration,
                  item.amount,
                  item.note,
                  initialDate.day.toString(),
                  initialDate.month.toString(),
                  initialDate.year.toString(),
                  DateTimeManager.getCurrentTime(),
                  "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
                  item.moneyType,
                  i == monthsBetween - 1 ? item.processOnce : "",
                  //item.realAmount,
                  ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
                  item.userCategory,
                  item.systemMessage
              );
              SQLHelper.createItem(newinfo);
              SQLHelper.updateCustomize(item.id, "");
            }
          }
          calculateInitialDate(date1, monthsBetween);
        }else{

        }
      }else if(item.processOnce == 'Altı Ayda Bir') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);

        if (!currentDate.isBefore(operationDate)) {
          int calculateMonthsBetween(DateTime date1, DateTime date2) {
            int difference = 0 ;
            int differenceYear = 0;
            if(date2.day < date1.day){
              difference = (date2.month - date1.month) -1;
            }
            else if(date2.day == date1.day){
              difference = date2.month - date1.month;
            }
            else if(date2.day > date1.day){
              difference = date2.month - date1.month;
            }
            else{
              difference = 1;
            }
            differenceYear = date2.year - date1.year;
            return (differenceYear*12)+difference;
          }
          DateTime date1 = DateTime(int.parse(item.operationYear!),
              int.parse(item.operationMonth!), int.parse(item.operationDay!));
          DateTime date2 = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          int monthsBetween = calculateMonthsBetween(date1, date2);

          calculateInitialDate(DateTime date,int count)  {
            DateTime initialDate = DateTime(date.year, date.month, date.day);
            for(int i =0 ; i < count ; i++){
              print("\n Hesaplanan $date");
              int nextMonth = date.month + 6;

              int nextYear = date.year;
              print(nextYear);
              if (nextMonth > 12) {
                nextMonth = 1;
                nextYear++;
              }print(nextMonth);
              int lastDayOfMonth = DateTime(date.year, date.month+1, 0).day;
              int lastDayOfNextMonth = DateTime(nextYear, nextMonth+1, 0).day;
              print("last day $lastDayOfMonth");
              print("last day next month $lastDayOfNextMonth");
              if (date.day == lastDayOfMonth) {
                print("Son gün");
                initialDate = DateTime(nextYear, nextMonth, lastDayOfNextMonth);
              } else if(nextMonth == 2 && date.day > 28) {
                print("Değil Ama Şubat");
                initialDate = DateTime(nextYear, nextMonth,lastDayOfNextMonth);
              } else {
                print("Değil");
                initialDate = DateTime(nextYear, nextMonth,date.day);
              }
              print("Sonuç $initialDate");
              date = initialDate;

              final newinfo = SpendInfo(
                  item.operationType,
                  item.category,
                  item.operationTool,
                  item.registration,
                  item.amount,
                  item.note,
                  initialDate.day.toString(),
                  initialDate.month.toString(),
                  initialDate.year.toString(),
                  DateTimeManager.getCurrentTime(),
                  "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
                  item.moneyType,
                  i == monthsBetween - 1 ? item.processOnce : "",
                  //item.realAmount,
                  ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
                  item.userCategory,
                  item.systemMessage
              );
              SQLHelper.createItem(newinfo);
              SQLHelper.updateCustomize(item.id, "");
            }
          }
          calculateInitialDate(date1, monthsBetween);
        }else{

        }
      }else if(item.processOnce == 'Yıllık') {
        DateTime currentDate = DateTime.now();
        DateTime operationDate = DateTime(int.parse(item.operationYear!),
            int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);

        if (!currentDate.isBefore(operationDate)) {
          int calculateMonthsBetween(DateTime date1, DateTime date2) {
            int difference = 0 ;
            int differenceYear = 0;
            if(date2.day < date1.day){
              difference = (date2.month - date1.month) -1;
            }
            else if(date2.day == date1.day){
              difference = date2.month - date1.month;
            }
            else if(date2.day > date1.day){
              difference = date2.month - date1.month;
            }
            else{
              difference = 1;
            }
            differenceYear = date2.year - date1.year;
            return (differenceYear*12)+difference;
          }
          DateTime date1 = DateTime(int.parse(item.operationYear!),
              int.parse(item.operationMonth!), int.parse(item.operationDay!));
          DateTime date2 = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          int monthsBetween = calculateMonthsBetween(date1, date2);

          calculateInitialDate(DateTime date,int count)  {
            DateTime initialDate = DateTime(date.year, date.month, date.day);
            for(int i =0 ; i < count ; i++){
              print("\n Hesaplanan $date");
              int nextMonth = date.month + 12;

              int nextYear = date.year;
              print(nextYear);
              if (nextMonth > 12) {
                nextMonth = 1;
                nextYear++;
              }print(nextMonth);
              int lastDayOfMonth = DateTime(date.year, date.month+1, 0).day;
              int lastDayOfNextMonth = DateTime(nextYear, nextMonth+1, 0).day;
              print("last day $lastDayOfMonth");
              print("last day next month $lastDayOfNextMonth");
              if (date.day == lastDayOfMonth) {
                print("Son gün");
                initialDate = DateTime(nextYear, nextMonth, lastDayOfNextMonth);
              } else if(nextMonth == 2 && date.day > 28) {
                print("Değil Ama Şubat");
                initialDate = DateTime(nextYear, nextMonth,lastDayOfNextMonth);
              } else {
                print("Değil");
                initialDate = DateTime(nextYear, nextMonth,date.day);
              }
              print("Sonuç $initialDate");
              date = initialDate;

              final newinfo = SpendInfo(
                  item.operationType,
                  item.category,
                  item.operationTool,
                  item.registration,
                  item.amount,
                  item.note,
                  initialDate.day.toString(),
                  initialDate.month.toString(),
                  initialDate.year.toString(),
                  DateTimeManager.getCurrentTime(),
                  "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
                  item.moneyType,
                  i == monthsBetween - 1 ? item.processOnce : "",
                  //item.realAmount,
                  ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
                  item.userCategory,
                  item.systemMessage
              );
              SQLHelper.createItem(newinfo);
              SQLHelper.updateCustomize(item.id, "");
            }
          }
          calculateInitialDate(date1, monthsBetween);
        }else{

        }
      }else{
        ///Diğerleri
      }


    });
  }

  Future customizeInstallmentOperation(WidgetRef ref) async {
    List<SpendInfo> customizeItems = await SQLHelper.getCustomizeOperationList();
    List<SpendInfo> filteredList = customizeItems
        .where((element) => _isProcessOnceValidNumber(element.processOnce!))
        .toList();

    filteredList.forEach((item) {

      DateTime currentDate = DateTime.now();
      DateTime operationDate = DateTime(int.parse(item.operationYear!),
          int.parse(item.operationMonth!), int.parse(item.operationDay!),23,59,59);


      List<String> partsProcessOnce = item.processOnce!.split("/");
      int finished = int.parse(partsProcessOnce[0]);
      int total = int.parse(partsProcessOnce[1]);
      int remainder = total - finished;


      int calculateMonthsBetween(DateTime date1, DateTime date2) {
        int difference = 0 ;
        int differenceYear = 0;
        if(date2.day < date1.day){
          difference = (date2.month - date1.month) -1;
        }
        else if(date2.day == date1.day){
          difference = date2.month - date1.month;
        }
        else if(date2.day > date1.day){
          difference = date2.month - date1.month;
        }
        else{
          difference = 1;
        }
        differenceYear = date2.year - date1.year;
        return (differenceYear*12)+difference;
      }
      DateTime date1 = DateTime(int.parse(item.operationYear!),
          int.parse(item.operationMonth!), int.parse(item.operationDay!));
      DateTime date2 = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      int monthsBetween = calculateMonthsBetween(date1, date2);

      calculateInitialDate(DateTime date,int count) async {
        DateTime initialDate = DateTime(date.year, date.month, date.day);
        for(int i =0 ; i < count ; i++){
          if(remainder >0){
            print("\n Hesaplanan $date");
            int nextMonth = date.month + 1;

            int nextYear = date.year;
            print(nextYear);
            if (nextMonth > 12) {
              nextMonth = 1;
              nextYear++;
            }print(nextMonth);
            int lastDayOfMonth = DateTime(date.year, date.month+1, 0).day;
            int lastDayOfNextMonth = DateTime(nextYear, nextMonth+1, 0).day;
            print("last day $lastDayOfMonth");
            print("last day next month $lastDayOfNextMonth");
            if (date.day == lastDayOfMonth) {
              print("Son gün");
              initialDate = DateTime(nextYear, nextMonth, lastDayOfNextMonth);
            } else if(nextMonth == 2 && date.day > 28) {
              print("Değil Ama Şubat");
              initialDate = DateTime(nextYear, nextMonth,lastDayOfNextMonth);
            } else {
              print("Değil");
              initialDate = DateTime(nextYear, nextMonth,date.day);
            }
            print("Sonuç $initialDate");
            remainder == 1 ? print("Son taksit") : null;
            date = initialDate;

            final newinfo = SpendInfo(
                item.operationType,
                item.category,
                item.operationTool,
                item.registration,
                item.amount,
                item.note,
                initialDate.day.toString(),
                initialDate.month.toString(),
                initialDate.year.toString(),
                DateTimeManager.getCurrentTime(),
                "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
                item.moneyType,
                count < remainder ? i == count -1 ? "${finished + 1}/$total" : "" : remainder == 1 ? "" : "" ,
                ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
                item.userCategory,
                remainder == 1 ? " ${total}/$total " : " ${finished+1}/$total "
            );
            SQLHelper.createItem(newinfo);
            SQLHelper.updateCustomize(item.id, "");
            finished++;
            remainder--;
            print("Kalan işlem $remainder");
          }else{print("else düştün");}
        }
      }
      calculateInitialDate(date1, monthsBetween);



       /* if(remainder == 1 && !currentDate.isBefore(operationDate)){///SON TAKSİT
          print("son taksit");
          final newinfo = SpendInfo(
            item.operationType,
            item.category,
            item.operationTool,
            item.registration,
            item.amount,
            item.note,
            initialDate.day.toString(),
            initialDate.month.toString(),
            initialDate.year.toString(),
            DateTimeManager.getCurrentTime(),
            "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
              item.moneyType,
              "",
              ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix!),
              item.userCategory,
              "${total}/$total Taksit Bitti"
          );
          SQLHelper.createItem(newinfo);
          SQLHelper.updateCustomize(item.id, "");
        }
        else if (!currentDate.isBefore(operationDate) && remainder > 1) {
          print("ara taksit");
          final newinfo = SpendInfo(
            item.operationType,
            item.category,
            item.operationTool,
            item.registration,
            item.amount,
            item.note,
            initialDate.day.toString(),
            initialDate.month.toString(),
            initialDate.year.toString(),
            DateTimeManager.getCurrentTime(),
            "${initialDate.day.toString()}.${initialDate.month.toString()}.${initialDate.year.toString()}", // item.operationDate güncellendi
              item.moneyType,
              "${finished + 1}/$total",
              ref.read(currencyRiverpod).calculateRealAmount(item.amount!, item.moneyType.toString(), ref.read(settingsRiverpod).Prefix.toString()),
              item.userCategory,
              item.systemMessage
          );
          SQLHelper.createItem(newinfo);
          SQLHelper.updateCustomize(item.id, "");
        }
        else{
          print("boş");
          null;
        }*/

    });

  }

  bool _isProcessOnceValidNumber(String processOnce) {
    return processOnce.contains(RegExp(r'\d'));
  }


  Future<int> categoryUsageCount(int operationTypeController, String categoryName, int operationController, String newCategory) async {
    String operationType = operationTypeController == 0 ? 'Gider' : 'Gelir';
    List<SpendInfo> customizeItems = await SQLHelper.getCategoryByType(operationType, categoryName);
    //customizeItems.forEach((element) {print("${element.category} ${element.userCategory} ${element.id} ${element.realAmount}");});

    if(operationController == 1 ){///delete 1
      customizeItems.forEach((element) {
        SQLHelper.updateCategory(element.id, element.category!,"");
      });
      if(customizeItems.isEmpty){
        List<SpendInfo> userCategoryItems = await SQLHelper.getUserCategoryByType(operationType, categoryName);
        userCategoryItems.forEach((element) {
          SQLHelper.updateCategory(element.id, element.category!,"");
        });
      }
    }else if(operationController == 2){///delete 2
      customizeItems.forEach((element) {

        if(element.userCategory != ""){
          SQLHelper.updateCategory(element.id, newCategory,newCategory);
        }
      });
        List<SpendInfo> userCategoryItems = await SQLHelper.getUserCategoryByType(operationType, categoryName);
        userCategoryItems.forEach((element) {
          if(element.userCategory != ""){
          SQLHelper.updateCategory(element.id, newCategory,newCategory);
          }
        });
    }
    else if(operationController == 3){///edit 1
      customizeItems.forEach((element) {
        SQLHelper.updateCategory(element.id, element.category!,newCategory);
      });
      if(customizeItems.isEmpty){
        List<SpendInfo> userCategoryItems = await SQLHelper.getUserCategoryByType(operationType, categoryName);
        userCategoryItems.forEach((element) {
          SQLHelper.updateCategory(element.id, element.category!,newCategory);
        });
      }
    }
    else if(operationController == 4){///edit 2
      customizeItems.forEach((element) {
        SQLHelper.updateCategory(element.id, newCategory,newCategory);
      });
      if(customizeItems.isEmpty){
        List<SpendInfo> userCategoryItems = await SQLHelper.getUserCategoryByType(operationType, categoryName);
        userCategoryItems.forEach((element) {
          SQLHelper.updateCategory(element.id, element.category!,newCategory);
        });
      }
    }
    return customizeItems.length;
  }



  /*
  customizeOperation(
      String customize,
      String operationDate,
      String operationType,
      String category,
      String operationTool,
      int registration,
      double amount,
      String note,
      String moneyType,
      String userCategory,
      String systemMessage,
      ref) {
    String time = operationDate;
    List<String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    int customizeController = int.parse(customize);
    double amountController = amount / customizeController;

    DateTime initialDate = DateTime(parseYear, parseMonth, parseDay);

    for (int i = 1; i <= customizeController; i++) {
      final newinfo = SpendInfo(
        operationType,
        category,
        operationTool,
        registration,
        amountController,
        note,
        initialDate.day.toString(),
        initialDate.month.toString(),
        initialDate.year.toString(),
        DateTimeManager.getCurrentTime(),
        operationDate,
        moneyType,
        "",
          ref.read(currencyRiverpod).calculateRealAmount(amount, _moneyType.text, ref.read(settingsRiverpod).Prefix!),
          userCategory,
          systemMessage
      );
      SQLHelper.createItem(newinfo);

      // Bir sonraki taksit tarihini hesaplama
      int nextMonth = initialDate.month + 1;
      int nextYear = initialDate.year;

      if (nextMonth > 12) {
        // Eğer bir sonraki ay 12'den büyükse, yılı güncelleyip ayı 1 yapma
        nextMonth = 1;
        nextYear++;
      }

      // Ayın son gününü al
      int lastDayOfMonth = DateTime(nextYear, nextMonth + 1, 0).day;

      // Sonraki taksit tarihini ayarla (ayın son gününe göre veya aynı gün)
      if (parseDay > lastDayOfMonth) {
        initialDate = DateTime(nextYear, nextMonth, lastDayOfMonth);
      } else {
        initialDate = DateTime(nextYear, nextMonth, parseDay);
      }
    }
  }
  */

}
