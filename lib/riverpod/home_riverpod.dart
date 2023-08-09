import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalenderBka {
  List <String> mounths = ["Ocak", "Subat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Agustos", "Eylül", "Ekim", "Kasım", "Aralık"]; //12
  List <String> years = ["2020","2021","2022","2023","2024","2025", "2026", "2027", "2028", "2029", "2030"]; //11
  List <String> days = ["Monday", "Thuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
}

class HomeRiverpod extends ChangeNotifier {

  int indexyear = CalenderBka().years.indexOf(DateTime.now().year.toString());
  int indexmounth = DateTime.now().month - 1  ;
  PageController ? controllerPageMontly ;
  String ?income  ;
  String ?expense ;
  String ?totally ;
  bool refrestst = false ; //veri eklemede general_infonun yenilenmesi için

  void setControllerPageMontly(PageController  controllerPageMontly){
    this.controllerPageMontly = controllerPageMontly;
  }
  void setDailyStatus(String income, String expense, String totally){ //gelir gider ve toplam verilerini güncellliyor.
     this.income = income;
     this.expense = expense ;
     this.totally = totally ;
     notifyListeners();
  }
  void changeindex(indexmounthh, indexyearr){ //ay ve yıl index değişikliği yapıyor
    indexmounth = indexmounthh;
    indexyear = indexyearr ;
    notifyListeners();
  }
  void setStatus(){ // sayfayı yenilettirmek için kullandık
    refrestst = !refrestst ;
    notifyListeners();
  }
}
