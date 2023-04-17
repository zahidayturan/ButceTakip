import 'package:butcekontrol/Pages/Calculator.dart';
import 'package:butcekontrol/Pages/Home.dart';
import 'package:butcekontrol/Pages/calendar.dart';
import 'package:butcekontrol/Pages/more/more.dart';
import 'package:butcekontrol/Pages/statistic.dart';
import 'package:flutter/material.dart';

class BottomNavBarRiverpod extends ChangeNotifier { //statelesswidget
  int currentindex = 0 ;
  int ?current ;
  Color currentColor = Colors.white;
  void setcur(){
    current = currentindex;
    notifyListeners();
  }

  void setCurrentindex(int index) {
    currentindex = index ;
    notifyListeners();
  }

  Widget body(){
    switch(currentindex) {
      case 0 :
        return Home();
      case 1:
        return Statistics();
      case 2:
        return Calendar() ;
      case 3 :
        return Calculator();
      case 4 :
        return More();
      default :
        return Home();
    }
  }
}