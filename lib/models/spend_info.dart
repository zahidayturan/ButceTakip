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
      this.operationDate
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
      this.operationDate
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

  factory SpendInfo.fromCVSObjetct(List<dynamic> o ){
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
    );
  }
}