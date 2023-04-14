import 'package:flutter/cupertino.dart';

class AppBarType2Riverpod extends ChangeNotifier {
  String ?Date ;

  setDate(String Date){
    this.Date = Date ;
  }
}