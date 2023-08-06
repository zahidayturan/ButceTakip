import 'package:flutter/material.dart';

class PasswordRiverpod extends ChangeNotifier{
  bool isuseinsert = false; // root dizini rebuild yaptırmak ve password çıkarmak için kullanacağım.

  void setisuseinsert(){
    isuseinsert != isuseinsert;
    notifyListeners();
  }
}