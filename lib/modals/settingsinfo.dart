class settingsinfo {
  int ?id;
  String ?Prefix;
  int ?DarkMode;
  int ?isPassword;
  String ?Language;
  int ?isBackUp;
  String ?Backuptimes ;
  String ?lastBackup ;
  String ?Password ;

  settingsinfo(
      this.Prefix,
      this.DarkMode,
      this.isPassword,
      this.Language,
      this.isBackUp,
      this.Backuptimes,
      this.lastBackup,
      this.Password
      );
  settingsinfo.withId(
      this.id,
      this.Prefix,
      this.DarkMode,
      this.isPassword,
      this.Language,
      this.isBackUp,
      this.Backuptimes,
      this.lastBackup,
      this.Password
      );
  Map <String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["Prefix"] = Prefix ;
    map["DarkMode"] = DarkMode;
    map["isPassword"] = isPassword ;
    map["Language"] = Language;
    map["isBackUp"] = isBackUp;
    map["Backuptimes"] = Backuptimes;
    map["lastBackup"] = lastBackup ;
    map["Password"] = Password ;
    return map ;
  }
  settingsinfo.fromObject(dynamic o){
    id = o["id"] as int ;
    Prefix = o["Prefix"] ;
    DarkMode = o["DarkMode"] as int ;
    isPassword = o["isPassword"] as int;
    Language = o["Language"];
    isBackUp = o["isBackUp"] as int;
    Backuptimes = o["Backuptimes"];
    lastBackup = o["lastBackup"] ;
    Password = o["Password"] ;
  }
}