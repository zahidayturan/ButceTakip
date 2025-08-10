import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalenderBka {
  List <String> mounths = ["Ocak", "Subat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Agustos", "Eylül", "Ekim", "Kasım", "Aralık"]; //12
  List <String> years = ["2020","2021","2022","2023","2024","2025", "2026", "2027", "2028", "2029", "2030"]; //11
  List <String> days = ["Monday", "Thuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
}

class HomeRiverpod extends ChangeNotifier {

  String ?income  ;
  String ?expense ;
  String ?totally ;
  bool refrestst = false ; //veri eklemede general_infonun yenilenmesi için

  void setDailyStatus(String income, String expense, String totally){ //gelir gider ve toplam verilerini güncellliyor.
     this.income = income;
     this.expense = expense ;
     this.totally = totally ;
     notifyListeners();
  }
  void setStatus(){ // sayfayı yenilettirmek için kullandık
    refrestst = !refrestst ;
    notifyListeners();
  }

  bool menuControllerForRepeated = false;
  bool menuControllerForRegistery = false;
}
