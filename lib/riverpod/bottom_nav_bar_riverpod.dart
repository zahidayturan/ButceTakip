import 'package:butcekontrol/Pages/calculator_page.dart';
import 'package:butcekontrol/Pages/home_page.dart';
import 'package:butcekontrol/Pages/calendar_page.dart';
import 'package:butcekontrol/Pages/more/more.dart';
import 'package:butcekontrol/Pages/statistics_page.dart';
import 'package:flutter/material.dart';

class BottomNavBarRiverpod extends ChangeNotifier { //statelesswidget
  int currentindex = 0 ;
  int ?current ;
  Color currentColor = Color(0xFFE9E9E9);
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
        return const Home();
      case 1:
        return const Statistics();
      case 2:
        return const Calendar() ;
      case 3 :
        return const Calculator();
      case 4 :
        return More();
      default :
        return const Home();
    }
  }
}