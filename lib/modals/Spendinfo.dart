class spendinfo {
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

  spendinfo(
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
  spendinfo.withId(
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
  spendinfo.fromObject(dynamic o){
    id =  o["id"] as int ;
    operationType = o["operationType"]  ;
    category = o["category"]  ;
    operationTool   = o["operationTool"];
    registration = o["registration"];
    amount  = o["amount"] ;
    note  = o["note"] ;
    operationDay = o["operationDay"]  ;
    operationMonth = o["operationMonth"]  ;
    operationYear   = o["operationYear"];
    operationTime = o["operationTime"];
    operationDate  = o["operationDate"] ;
  }

}