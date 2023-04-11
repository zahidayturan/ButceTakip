class settingsinfo {
  int ?id;
  String ?Prefix;
  bool ?DarkMode;
  bool ?isPassword;
  String ?Language;

  settingsinfo(
      this.Prefix,
      this.DarkMode,
      this.isPassword,
      this.Language
      );
  settingsinfo.withId(
      this.id,
      this.Prefix,
      this.DarkMode,
      this.isPassword,
      this.Language
      );
  Map <String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["Prefix"] = Prefix ;
    map["DarkMode"] = DarkMode;
    map["isPassword"] = isPassword ;
    map["Language"] = Language;
    return map ;
  }
  settingsinfo.fromObject(dynamic o){
    id = o["id"] as int ;
    Prefix = o["Prefix"] ;
    DarkMode = o["DarkMode"] ;
    isPassword = o["isPassword"] ;
    Language = o["Language"];
  }
}