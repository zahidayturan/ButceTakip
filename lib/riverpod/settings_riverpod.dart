import 'package:butcekontrol/models/settings_info.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/cvs_converter.dart';

class SettingsRiverpod extends ChangeNotifier{
  bool isuseinsert = false ; //Settings verileri pop sonrası güncellenmesi için
  int ?id;
  String ?Prefix;
  int ?DarkMode;
  int ?isPassword;
  String ?Language;
  int ?isBackUp;
  String ?Backuptimes ;
  String ?lastBackup;
  String ?Password ;
  String ?securityQu ;
  int ?securityClaim ;
  bool Status  = false ; // şifre girildi mi ?

  Future readDb() async{
    List<SettingsInfo> setting = await SQLHelper.settingsControl() ;
    id = setting[setting.length - 1].id ;
    Prefix = setting[setting.length - 1].prefix ;
    DarkMode = setting[setting.length - 1].darkMode;
    isPassword = setting[setting.length - 1].isPassword;
    Language = setting[setting.length - 1].language;
    isBackUp = setting[setting.length - 1].isBackUp;
    Backuptimes = setting[setting.length - 1].backupTimes;
    lastBackup = setting[setting.length - 1].lastBackup;
    Password = setting[setting.length - 1].password;
    securityQu = setting[setting.length - 1].securityQu;
    securityClaim = setting[setting.length - 1].securityClaim;
    print("""
      id : ${setting[setting.length - 1].id}
      dil :${setting[setting.length - 1].prefix}
      Darkmode :${setting[setting.length - 1].darkMode}
      isPassword : ${setting[setting.length - 1].isPassword}
      Language : ${setting[setting.length - 1].language}
      isBackup :${isBackUp = setting[setting.length - 1].isBackUp}
      Backuptims : ${setting[setting.length - 1].backupTimes}
      lastBackup : ${setting[setting.length - 1].lastBackup}
      Password : ${setting[setting.length - 1].password}
      securityQu : ${setting[setting.length - 1].securityQu}
      securityClaimK(Kalan Hak) : ${setting[setting.length - 1].securityClaim}""");
    notifyListeners();
  }
  Future controlSettings() async{ //settings Kayıt değerlendiriyoruz.
    List<SettingsInfo> ?settingsReglength = await SQLHelper.settingsControl();
    if(settingsReglength.length > 0) {
      readDb();
    }else{
      final info = SettingsInfo("TRY", 0, 0, "Turkce", 0, "Günlük", "00.00.0000", "null", "null", 3) ;
      await SQLHelper.addItemSetting(info);
      readDb();
    }
    notifyListeners();
  }
  void setisuseinsert(){
    isuseinsert = !isuseinsert ;
    notifyListeners();
  }
  void Backup(){
    writeToCvs();
    setLastBackup();
  }
  void setSecurityQu(String securityQu){
    this.securityQu = securityQu ;
    Updating();
  }
  void useSecurityClaim(){
    securityClaim = (securityClaim! - 1);
    Updating();
  }
  void setDarkMode(bool mode){
    DarkMode = mode ? 1 : 0 ;
    Updating();
  }
  void setBackup(bool mode) {
    isBackUp = mode ? 1 : 0 ;
    Updating();
  }
  void setBackuptimes(String time) {
    if(time == "Günlük") {
      Backuptimes = "Günlük";
    } else if(time == "Aylık") {
      Backuptimes = "Aylık";
    } else {
      Backuptimes = "Yıllık";
    }
    Updating();
  }
  void setPasswordMode(bool mode) {
    isPassword = mode ? 1 : 0 ;
    securityClaim = 3 ;
    Updating();
  }
  void setPassword(String Password){
    this.Password = Password ;
    Updating();
  }
  void setLastBackup(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    lastBackup = formattedDate ;
    Updating();
  }
  Future Updating() async {
    final info = SettingsInfo.withId(
        id,
        Prefix,
        DarkMode,
        isPassword,
        Language,
        isBackUp,
        Backuptimes,
        lastBackup,
        Password,
        securityQu,
        securityClaim,
    );
    await SQLHelper.updateSetting(info);
  }
  void setStatus(bool value){
    Status = value ;
    notifyListeners();
  }
}