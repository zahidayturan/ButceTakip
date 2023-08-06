import 'package:butcekontrol/models/spend_info.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/driveactivity/v2.dart';

import '../utils/date_time_manager.dart';
import '../utils/db_helper.dart';

class UpdateDataRiverpod extends ChangeNotifier {
  SpendInfo? items;
  var id;

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
    _registration.text = items.registration.toString();
    _customize.text = items.processOnce.toString();
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
  /*
  getMoneyType() {
    return _moneyType;
  }*/
  getProcessOnce() {
    return _customize;
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
      double? realamount,
      )async {
    String time = operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    String moneyType = '0';
    String processOnce = '0';
    String userCategory = '';
    String systemMessage = '';
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

  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _operationType = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _operationTool = TextEditingController();
  final TextEditingController _registration = TextEditingController();
  final TextEditingController _operationDate = TextEditingController();
  //final TextEditingController _moneyType = TextEditingController();
  final TextEditingController _customize = TextEditingController();

  Future<Map<String, List<String>>> myCategoryLists() async {
    List<SpendInfo> spendInfoListExpense =
        await SQLHelper.getCategoryListByType('Gider');
    List<String> categoryListExpense = [];

    for (var spendInfo in spendInfoListExpense) {
      if (!categoryListExpense.contains(spendInfo.category)) {
        categoryListExpense.add(spendInfo.category!);
      }
    }

    List<SpendInfo> spendInfoListIncome =
        await SQLHelper.getCategoryListByType('Gelir');
    List<String> categoryListIncome = [];

    for (var spendInfo in spendInfoListIncome) {
      if (!categoryListIncome.contains(spendInfo.category)) {
        categoryListIncome.add(spendInfo.category!);
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

  Future customizeRepeatedOperation() async {
    List<SpendInfo> customizeItems =
        await SQLHelper.getCustomizeOperationList();
    customizeItems.forEach((item) {
      if (item.processOnce == 'Günlük') {
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
              "0",
              i == daysBetween - 1 ? item.processOnce : "",
              0.0,
              "",
              ""
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
              "0",
              i == daysBetween - 1 ? item.processOnce : "",
                0.0,
                "",
                ""
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
              "0",
              i == daysBetween - 1 ? item.processOnce : "",
                0.0,
                "",
                ""
            );
            SQLHelper.createItem(newinfo);
            print("Veri Eklendi ${item.operationDate} - ${item.processOnce}");
            // Bir sonraki günün tarihini al
            date1 = date1.add(Duration(days: 14));
          }
          SQLHelper.updateCustomize(item.id, "");
        }else{

        }
      }else{
        ///Diğerleri
      }


    });
  }

  Future customizeInstallmentOperation() async {
    List<SpendInfo> customizeItems = await SQLHelper.getCustomizeOperationList();
    List<SpendInfo> filteredList = customizeItems
        .where((element) => _isProcessOnceValidNumber(element.processOnce!))
        .toList();
    filteredList.forEach((item) {
      List<String> partsProcessOnce = item.processOnce!.split("/");
      int finished = int.parse(partsProcessOnce[0]);
      int total = int.parse(partsProcessOnce[1]);
      int remainder = total - finished;


      String time = item.operationDate!;
      List<String> parts = time.split(".");
      int parseDay = int.parse(parts[0]);
      int parseMonth = int.parse(parts[1]);
      int parseYear = int.parse(parts[2]);
      DateTime initialDate = DateTime(parseYear, parseMonth, parseDay);
      DateTime currentDate = DateTime.now();

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
      if (parseDay > lastDayOfMonth) {//son günse
        initialDate = DateTime(nextYear, nextMonth, lastDayOfMonth);
      } else { //son gün değilse
        initialDate = DateTime(nextYear, nextMonth, parseDay);
      }

        if(remainder == 1 && !currentDate.isBefore(DateTime(int.parse(item.operationYear!),int.parse(item.operationMonth!),int.parse(item.operationDay!)))){///SON TAKSİT
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
            "0",
            "",
              0.0,
              "",
              ""
          );
          SQLHelper.createItem(newinfo);
          SQLHelper.updateCustomize(item.id, "");
        }
        else if (!currentDate.isBefore(initialDate) && remainder > 1) {
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
            "0",
            "${finished + 1}/$total",
              0.0,
              "",
              ""
          );
          SQLHelper.createItem(newinfo);
          SQLHelper.updateCustomize(item.id, "");
        }
        else{
          print("boş");
          null;
        }

    });

  }

  bool _isProcessOnceValidNumber(String processOnce) {
    return processOnce.contains(RegExp(r'\d'));
  }

  customizeOperation(
      String customize,
      String operationDate,
      String operationType,
      String category,
      String operationTool,
      int registration,
      double amount,
      String note) {
    String time = operationDate;
    List<String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    int customizeController = int.parse(customize);
    double amountController = amount / customizeController;

    DateTime initialDate = DateTime(parseYear, parseMonth, parseDay);

    for (int i = 1; i <= customizeController; i++) {
      String noteWithCustomizeInfo =
          note + " Taksit Ödemesi (${i}/${customize}) Ay";
      final newinfo = SpendInfo(
        operationType,
        category,
        operationTool,
        registration,
        amountController,
        noteWithCustomizeInfo,
        initialDate.day.toString(),
        initialDate.month.toString(),
        initialDate.year.toString(),
        DateTimeManager.getCurrentTime(),
        operationDate,
        "0",
        "",
          0.0,
          "",
          ""
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
}
