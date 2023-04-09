import 'package:flutter/material.dart';

class editInfo extends ChangeNotifier {
  int ?id ;

  void set_id(int id){
    this.id = id ;
    notifyListeners();
  }
}