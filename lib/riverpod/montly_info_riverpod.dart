import 'package:flutter/material.dart';

class MontlyInfoRiverpod extends ChangeNotifier{
  bool isuseinsert = false; // root dizini rebuild yaptırmak ve password çıkarmak için kullanacağım.

  int ?currentIndex;

  void setCurrentIndex(int index){
    this.currentIndex = index;
    notifyListeners();
  }

  void setisuseinsert(){
    isuseinsert != isuseinsert;
    notifyListeners();
  }
}