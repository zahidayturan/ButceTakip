class SettingsInfo {
  int ?id;
  String ?prefix;
  int ?darkMode;
  int ?isPassword;
  String ?language;
  int ?isBackUp;
  String ?backupTimes ;
  String ?lastBackup ;
  String ?password ;

  SettingsInfo(
      this.prefix,
      this.darkMode,
      this.isPassword,
      this.language,
      this.isBackUp,
      this.backupTimes,
      this.lastBackup,
      this.password
      );
  SettingsInfo.withId(
      this.id,
      this.prefix,
      this.darkMode,
      this.isPassword,
      this.language,
      this.isBackUp,
      this.backupTimes,
      this.lastBackup,
      this.password
      );
  Map <String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["Prefix"] = prefix ;
    map["DarkMode"] = darkMode;
    map["isPassword"] = isPassword ;
    map["Language"] = language;
    map["isBackUp"] = isBackUp;
    map["Backuptimes"] = backupTimes;
    map["lastBackup"] = lastBackup ;
    map["Password"] = password ;
    return map ;
  }
  SettingsInfo.fromObject(dynamic o){
    id = o["id"] as int ;
    prefix = o["Prefix"] ;
    darkMode = o["DarkMode"] as int ;
    isPassword = o["isPassword"] as int;
    language = o["Language"];
    isBackUp = o["isBackUp"] as int;
    backupTimes = o["Backuptimes"];
    lastBackup = o["lastBackup"] ;
    password = o["Password"] ;
  }
}