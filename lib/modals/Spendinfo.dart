class spendinfo {
  int ?id ;
  String ?gelir;
  String ?gider;
  String ?day ;
  String ?month ;
  String ?year ;

  spendinfo(this.gelir, this.gider,this.day, this.month, this.year);
  spendinfo.withId(this.id, this.gelir, this.gider,this.day, this.month, this.year);

  Map<String,dynamic> toMap(){
    var map = < String, dynamic>{} ;
    print("tomap çalıştı.");
    map["id"] = id ;
    map["gelir"] = gelir ;
    map["gider"] = gider ;
    map["day"] = day ;
    map["month"] = month ;
    map["year"] = year ;
    print("tomap sonlandı");
    return map ;
  }
  spendinfo.fromObject(dynamic o){
    id =  o["id"] as int ;
    gelir = o["gelir"]  ;
    gider = o["gider"]  ;
    day   = o["day"];
    month = o["month"];
    year  = o["year"] ;
  }

}