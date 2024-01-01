class SettingsInfo {
  int ?id;//kayıt id
  String ?prefix;//Varsayılan paraBirimi
  int ?darkMode;//Koyu Tema
  int ?isPassword;//Password Var mı? 0, 1
  String ?language;// Dil
  int ?isBackUp;//Yedekleme Açık mı? 0, 1
  String ?backupTimes ;//Yedekleme sıklığı
  String ?lastBackup ;//en son yedeklenme tarihi
  String ?password ;//Şifre alanı yoksa "null"
  String ?securityQu; // şifremi unuttum güvenlik sorusu
  int ?securityClaim ;//Güvenlik sorusu cevaplama hakkı
  int ?adCounter ;//Reklam sayacı
  String ?prefixSymbol;//para birimi sembolü
  int ?monthStartDay;
  String ?dateFormat;
  int ?adEventCounter;
  String ?isAssistant; //Asistanım özelliği açık mı ?
  String ?assistantLastShowDate; //Asistan son gösteilme tarihi
  int ?addDataType;

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
      this.adEventCounter,
      this.isAssistant,
      this.assistantLastShowDate,
      this.addDataType
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
      this.adEventCounter,
      this.isAssistant,
      this.assistantLastShowDate,
      this.addDataType
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
    map["isAssistant"] = isAssistant;
    map["assistantLastShowDate"] = assistantLastShowDate;
    map["addDataType"] = addDataType;
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
    isAssistant = o["isAssistant"] ;
    assistantLastShowDate = o["assistantLastShowDate"] ;
    addDataType = o["addDataType"] as int;
  }
}