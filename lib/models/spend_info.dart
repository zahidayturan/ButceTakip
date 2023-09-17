import 'package:butcekontrol/Riverpod/settings_riverpod.dart';
import 'package:butcekontrol/riverpod/currency_riverpod.dart';
import 'package:flutter/material.dart';

import '../riverpod_management.dart';

class SpendInfo {
  int ?id ;
  String ?operationType;
  String ?category;
  String ?operationTool ;
  int ?registration ;
  double ?amount ;
  String ?note ;
  String ?operationDate ;
  String ?operationDay ;
  String ?operationMonth ;
  String ?operationYear ;
  String ?operationTime ;
  String ?moneyType ;
  String ?processOnce ;
  double ?realAmount ;
  String ?userCategory ;
  String ?systemMessage ;

  SpendInfo(
      this.operationType,
      this.category,
      this.operationTool,
      this.registration,
      this.amount,
      this.note,
      this.operationDay,
      this.operationMonth,
      this.operationYear,
      this.operationTime,
      this.operationDate,
      this.moneyType,
      this.processOnce,
      this.realAmount,
      this.userCategory,
      this.systemMessage,
      );
  SpendInfo.withId(
      this.id,
      this.operationType,
      this.category,
      this.operationTool,
      this.registration,
      this.amount,
      this.note,
      this.operationDay,
      this.operationMonth,
      this.operationYear,
      this.operationTime,
      this.operationDate,
      this.moneyType,
      this.processOnce,
      this.realAmount,
      this.userCategory,
      this.systemMessage,
      );

  Map<String,dynamic> toMap(){
    var map = < String, dynamic>{} ;
    map["operationType"] = operationType ;
    map["category"] = category ;
    map["operationTool"] = operationTool ;
    map["registration"] = registration ;
    map["amount"] = amount ;
    map["note"] = note ;
    map["operationDay"] = operationDay ;
    map["operationMonth"] = operationMonth ;
    map["operationYear"] = operationYear ;
    map["operationTime"] = operationTime ;
    map["operationDate"] = operationDate ;
    map["moneyType"] = moneyType ;
    map["processOnce"] = processOnce ;
    map["realAmount"] = realAmount ;
    map["userCategory"] = userCategory ;
    map["systemMessage"] = systemMessage ;

    return map ;
  }
  SpendInfo.fromObject(dynamic o){
    id =  o["id"] as int ;
    operationType = o["operationType"]  ;
    category = o["category"]  ;
    operationTool   = o["operationTool"];
    registration = o["registration"] ;
    amount  = o["amount"]  ;
    note  = o["note"] ;
    operationDay = o["operationDay"]  ;
    operationMonth = o["operationMonth"]  ;
    operationYear   = o["operationYear"];
    operationTime = o["operationTime"];
    operationDate  = o["operationDate"] ;
    moneyType = o["moneyType"];
    processOnce  = o["processOnce"] ;
    realAmount  = o["realAmount"] ;
    userCategory  = o["userCategory"] ;
    systemMessage  = o["systemMessage"] ;
  }
  dynamic fromCsvValue(String value) {
    if (value.isEmpty) {
      return null;
    }
    if (int.tryParse(value) != null) {
      return int.parse(value);
    }
    if (double.tryParse(value) != null) {
      return double.parse(value);
    }
    return value;
  }

  factory SpendInfo.fromCVSObjetct(List<dynamic> o){
    if(o.length > 15){
      print("yeni yedekleme");
      return SpendInfo.withId(
        int.parse(o[0].toString()),//id
        o[1].toString(),//operationType
        o[2].toString(),//category
        o[3].toString(),//operationTool
        int.parse(o[4].toString()),//registration
        double.parse(o[5].toString()),//amount
        o[6].toString(),//note
        o[7].toString(),//operationDay
        o[8].toString(),//operationMonth
        o[9].toString(),//operationYear
        o[10].toString(),//operationTime
        o[11].toString(),//operationDate
        o[12].toString(),//moneyType
        o[13].toString(),//processOnce
        double.parse(o[14].toString()),//realAmount
        o[15].toString(),//userCategory
        o[16].toString(),//systemMessage
      );
    }else {/// güncelleme sonrası spend infonun colum eklenmesinden çıkan sorundan dolayı eski kayıtlar buraya girecek .
      print("Eski yedekleme");
      return SpendInfo.withId(
        int.parse(o[0].toString()),
        o[1].toString(),
        o[2].toString(),
        o[3].toString(),
        int.parse(o[4].toString()),
        double.parse(o[5].toString()),
        o[6].toString(),
        o[7].toString(),
        o[8].toString(),
        o[9].toString(),
        o[10].toString(),
        o[11].toString(),
        o[12].toString(),
        "",
        double.parse(o[5].toString()),// amount ile aynı değeri eşitledim.
        "",
        "",
      );
    }

  }

}