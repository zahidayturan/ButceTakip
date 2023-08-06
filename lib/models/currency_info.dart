class currencyInfo {
  int ?id;
  String ?BASE;
  String ?TRY; //Türk Lirası
  String ?USD; //AMerikan Doları
  String ?EUR; //EURO
  String ?GBP; //İngiliz Sterlini
  String ?KWD; //Kuveyt Dinarı
  String ?JOD; //Ürdün Dinarı
  String ?IQD; //Irak Dinarı
  String ?SAR; //Suudi Arabistan Riyali

  String ?lastApiUpdateDate;

  currencyInfo(
      this.BASE,
      this.TRY,
      this.USD,
      this.EUR,
      this.GBP,
      this.KWD,
      this.JOD,
      this.IQD,
      this.SAR,
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
      this.JOD,
      this.IQD,
      this.SAR,
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
    map["JOD"] = JOD;
    map["IQD"] = IQD;
    map["SAR"] = SAR;
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
    JOD = o["JOD"];
    IQD = o["IQD"];
    SAR = o["SAR"];
    lastApiUpdateDate = o["lastApiUpdateDate"];
  }
}