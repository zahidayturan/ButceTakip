import 'package:butcekontrol/models/spend_info.dart';
import 'package:flutter/material.dart';

import '../utils/date_time_manager.dart';
import '../utils/db_helper.dart';

class UpdateDataRiverpod extends ChangeNotifier {

  SpendInfo? items;
  var id ;
  setItems(SpendInfo items){
    this.items = items;
    id = items.id.toString();
    _note.text = items.note.toString();
    _amount.text = items.amount.toString();
    _operationType.text = items.operationType.toString();
    _category.text = items.category.toString();
    _operationTool.text = items.operationTool.toString();
    _registration.text = items.registration.toString();
    _operationDate.text = items.operationDate.toString();
  }
  getId(){
    return id;
  }

  getNote(){
    return _note;
  }
  getType(){
    return _operationType;
  }
  getAmount(){
    return _amount;
  }
  getOperationTool(){
    return _operationTool;
  }
  getCategory(){
    return _category;
  }
  getRegistration(){
    return _registration;
  }
  getOperationDate(){
    return _operationDate;
  }
  bool isuseinsert = false ;
  Future updateDataBase(
      int id,
      String? operationType ,
      String? category,
      String? operationTool,
      int registration,
      double? amount,
      String? note,
      String operationDate,
      )async {
    String time = operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    String moneyType = '0';
    String processOnce = '0';
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
        processOnce
    );
    await SQLHelper.updateItem(updateinfo);
    isuseinsert = !isuseinsert ;
    notifyListeners();
  }

  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _operationType = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _operationTool = TextEditingController();
  final TextEditingController _registration = TextEditingController();
  final TextEditingController _operationDate = TextEditingController();
}
