import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateDataRiverpod extends ChangeNotifier {
  spendinfo? items;
  setItems(spendinfo items){
    this.items = items;
    _note.text = items.note.toString();
    _amount.text = items.amount.toString();
    _operationType.text = items.operationType.toString();
    _category.text = items.category.toString();
    _operationTool.text = items.operationTool.toString();
    _registration.text = items.registration.toString();
    _operationDate.text = items.operationDate.toString();
  }
  getItems(final controller){
    return controller;
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

  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _operationType = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _operationTool = TextEditingController();
  final TextEditingController _registration = TextEditingController();
  final TextEditingController _operationDate = TextEditingController();
}
