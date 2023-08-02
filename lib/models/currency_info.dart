class currencyInfo {
  int ?id;
  String ?BASE;
  String ?TRY;
  String ?USD;
  String ?EUR;
  String ?GBP;
  String ?KWD;
  String ?lastApiUpdateDate;

  currencyInfo(
      this.BASE,
      this.TRY,
      this.USD,
      this.EUR,
      this.GBP,
      this.KWD,
      this.lastApiUpdateDate
      );
  currencyInfo.withId(
      this.id,
      this.BASE,
      this.TRY,
      this.USD,
      this.EUR,
      this.GBP,
      this.KWD,
      this.lastApiUpdateDate
      );
  Map <String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["BASE"] = BASE;
    map["TRY"] = TRY;
    map["USD"] = USD;
    map["EUR"] = EUR;
    map["GBP"] = GBP;
    map["KWD"] = KWD;
    map["lastApiUpdateDate"] = lastApiUpdateDate;
    return map;
  }
  currencyInfo.fromObject(dynamic o){
    id = o["id"];
    BASE = o["BASE"] ;
    TRY = o["TRY"];
    USD = o["USD"];
    EUR = o["EUR"];
    GBP = o["GBP"];
    KWD = o["KWD"];
    lastApiUpdateDate = o["lastApiUpdateDate"];
  }
}