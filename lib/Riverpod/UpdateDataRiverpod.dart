import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/DateTimeManager.dart';
import '../utils/dbHelper.dart';

class UpdateDataRiverpod extends ChangeNotifier {


  bool controller = false;
  void refreshSet(){
    controller = !controller;
    notifyListeners();
  }

  spendinfo? items;
  var id ;
  setItems(spendinfo items){
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
      String? _operationType ,
      String? _category,
      String? _operationTool,
      int _registration,
      double? _amount,
      String? _note,
      String _operationDate,
      )async {
    String time = _operationDate ;
    List <String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    final updateinfo = spendinfo.withId(
        id,
        _operationType,
        _category,
        _operationTool,
        _registration,
        _amount,
        _note,
        parseDay.toString(),
        parseMonth.toString(),
        parseYear.toString(),
        DateTimeManager.getCurrentTime(),
        _operationDate
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
