import 'package:butcekontrol/Pages/Calculator.dart';
import 'package:butcekontrol/Pages/Home.dart';
import 'package:butcekontrol/Pages/calendar.dart';
import 'package:butcekontrol/Pages/more/Help/Backup.dart';
import 'package:butcekontrol/Pages/more/Help/Communicate.dart';
import 'package:butcekontrol/Pages/more/Help/HelpCalculator.dart';
import 'package:butcekontrol/Pages/more/Help/HelpCalender.dart';
import 'package:butcekontrol/Pages/more/Help/HelpStatistic.dart';
import 'package:butcekontrol/Pages/more/Help/VersionsHelp.dart';
import 'package:butcekontrol/Pages/more/Help/helpPage.dart';
import 'package:butcekontrol/Pages/more/more.dart';
import 'package:butcekontrol/Pages/more/settings.dart';
import 'package:butcekontrol/Pages/statistic.dart';
import 'package:flutter/material.dart';
import 'package:butcekontrol/Pages/statistic.dart';

import '../Pages/more/Help/HelpHomePage.dart';

class BottomNavBarRiverpod extends ChangeNotifier { //statelesswidget
  int currentindex = 0 ;
  int ?current ;
  Color currentColor = Colors.white;
  void refreshbuidl(){
    currentindex = currentindex ;
  }
  void setcur(){
    current = currentindex;
    notifyListeners();
  }

  void setCurrentindex(int index) {
    currentindex = index ;
    notifyListeners();
  }
  void setBackColor(Color color){
    currentColor = color ;
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
      case 5 :
        return helpCenter();
      case 6 :
        return helpHomePage();
      case 7 :
        return helpStatisic();
      case 8 :
        return helpCalender();
      case 9 :
        return helpCalculator();
      case 10 :
        return versionshelp();
      case 11 :
        return settings();
      case 12 :
        return communicate();
      case 13 :
        return backUp();
      default :
        return Home();
    }
  }
}