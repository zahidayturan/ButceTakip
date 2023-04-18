import 'package:flutter/foundation.dart';

class CalenderBka {
  List <String> mounths = ["Ocak", "Subat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Agustos", "Eylül", "Ekim", "Kasım", "Aralık" ];
  List <String> years = ["2020","2021","2022","2023","2024","2025", "2026", "2027", "2028", "2029", "2030"];
  List <String> days = ["Monday", "Thuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
}

class HomeRiverpod extends ChangeNotifier {

  int indexyear = CalenderBka().years.indexOf(DateTime.now().year.toString());
  int indexmounth = DateTime.now().month - 1  ;
  String ?income  ;
  String ?expense ;
  String ?totally ;

  void setDailyStatus(String income, String expense, String totally){
     this.income = income;
     this.expense = expense ;
     this.totally = totally ;
     notifyListeners();
  }
  void changeindex(indexmounthh, indexyearr){
    indexmounth = indexmounthh;
    indexyear = indexyearr ;
    notifyListeners();
  }
}