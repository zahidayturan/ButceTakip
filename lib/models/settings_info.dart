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
  String ?securityQu;
  int ?securityClaim ;
  int ?adCounter ;
  String ?prefixSymbol;
  int ?monthStartDay;
  String ?dateFormat;
  int ?adEventCounter;

  SettingsInfo(
      this.prefix,
      this.darkMode,
      this.isPassword,
      this.language,
      this.isBackUp,
      this.backupTimes,
      this.lastBackup,
      this.password,
      this.securityQu,
      this.securityClaim,
      this.adCounter,
      this.prefixSymbol,
      this.monthStartDay,
      this.dateFormat,
      this.adEventCounter
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
      this.password,
      this.securityQu,
      this.securityClaim,
      this.adCounter,
      this.prefixSymbol,
      this.monthStartDay,
      this.dateFormat,
      this.adEventCounter
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
    map["securityQu"] = securityQu ;
    map["securityClaim"] = securityClaim ;
    map["adCounter"] = adCounter ;
    map["prefixSymbol"] = prefixSymbol ;
    map["monthStartDay"] = monthStartDay ;
    map["dateFormat"] = dateFormat ;
    map["adEventCounter"] = adEventCounter;
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
    securityQu = o["securityQu"];
    securityClaim = o["securityClaim"] as int;
    adCounter = o["adCounter"] as int;
    prefixSymbol = o["prefixSymbol"] ;
    monthStartDay = o["monthStartDay"] as int;
    dateFormat = o["dateFormat"] ;
    adEventCounter = o["adEventCounter"] as int;
  }
}