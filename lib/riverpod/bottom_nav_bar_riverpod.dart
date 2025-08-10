import 'package:butcetakip/Pages/calculator_page.dart';

import 'package:butcetakip/Pages/calendar_page.dart';
import 'package:butcetakip/Pages/more/more.dart';

import 'package:flutter/material.dart';

import '../features/home/home_page.dart';
import '../features/statistics/statistics_page.dart';

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