import 'package:flutter/material.dart';

class AddDataRiverpod extends ChangeNotifier{

  bool _isIncome = true;
  bool get isIncome => _isIncome;

  void setAddDataType(bool value) {
    _isIncome = value;
    notifyListeners();
  }

}