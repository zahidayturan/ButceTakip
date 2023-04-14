import 'package:flutter/foundation.dart';

class Calender_Bka {
  List <String> Mounths = ["Ocak", "Subat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Agustos", "Eylül", "Ekim", "Kasım", "Aralık" ];
  List <String> Years = ["2020","2021","2022","2023","2024","2025", "2026", "2027", "2028", "2029", "2030"];
  List <String> Days = ["Monday", "Thuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
}

class HomeRiverpod extends ChangeNotifier {

  int indexyear = Calender_Bka().Years.indexOf(DateTime.now().year.toString());
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