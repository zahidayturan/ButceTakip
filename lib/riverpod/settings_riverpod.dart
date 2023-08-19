import 'dart:io';
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
  int ?adCounter;
  bool ?Status; // şifre girildi mi ?
  String ?prefixSymbol = "₺";

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
    adCounter = setting[setting.length - 1].adCounter;
    prefixSymbol = setting[setting.length - 1].prefixSymbol;

    print("""
      id : ${setting[setting.length - 1].id}
      prefix :${setting[setting.length - 1].prefix}
      prefixSymbol :${setting[setting.length - 1].prefixSymbol}
      Darkmode :${setting[setting.length - 1].darkMode}
      isPassword : ${setting[setting.length - 1].isPassword}
      Language : ${setting[setting.length - 1].language}
      isBackup :${isBackUp = setting[setting.length - 1].isBackUp}
      Backuptims : ${setting[setting.length - 1].backupTimes}
      lastBackup : ${setting[setting.length - 1].lastBackup}
      Password : ${setting[setting.length - 1].password}
      securityQu : ${setting[setting.length - 1].securityQu}
      securityClaimK(Kalan Hak) : ${setting[setting.length - 1].securityClaim}
      adCounter(Kalan Hak) : ${setting[setting.length - 1].adCounter}""");
    notifyListeners();
  }
  Future controlSettings() async{ //settings Kayıt değerlendiriyoruz.
    List<SettingsInfo> ?settingsReglength = await SQLHelper.settingsControl();
    if(settingsReglength.length > 0) {
      prefixSymbol = settingsReglength[0].prefixSymbol;
      readDb();
    }else{
      final info = SettingsInfo("TRY", 0, 0, getDeviceLocaleLanguage(), 0, "Günlük", "00.00.0000", "null", "null", 3, 2, " ₺") ;
      await SQLHelper.addItemSetting(info);
      readDb();
    }
    notifyListeners();
  }

  void reset(){
    this.securityQu = "null";
    Updating();
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
  void useAdCounter(){
    adCounter = (adCounter! - 1);
    Updating();
  }
  void resetAdCounter(){
    this.adCounter = 2 ;
    Updating();
  }
  void setDarkMode(bool mode){
    DarkMode = mode ? 1 : 0 ;
    Updating();
  }
  void setDarkModeNotBool(){
    DarkMode = DarkMode == 1 ? 0 : 1 ;
    Updating();

  }
  void setPrefix(String prefix){
    this.Prefix = prefix;

    switch(prefix){
      case "TRY":
        this.prefixSymbol = " ₺";
        break;
      case "EUR":
        this.prefixSymbol = " €";
        break;
      case "USD":
        this.prefixSymbol =  " \$";
        break;
      case "GBP":
        this.prefixSymbol =  " £";
        break;
      case "KWD":
        this.prefixSymbol = " د.ك";
        break;
      case "JOD":
        this.prefixSymbol = " JD";
        break;
      case "IQD":
        this.prefixSymbol = " د.ع";
        break;
      case "SAR":
        this.prefixSymbol =  " ر.س";
        break;
      default:
        this.prefixSymbol =  " ?";
    }
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
  void setLanguage(String language){
    Language = language;
    Updating();
  }
  Locale localChanger(){
    if(Language == "Turkce"){
      return Locale("tr");
    }else if(Language == "English"){
      return Locale("en");
    }else if(Language == "العربية"){
      return Locale("ar");
    }else{
      return Locale("en");
    }
  }
  String getDeviceLocaleLanguage(){
    var deviceLocaleFullLanguageCode  = Platform.localeName; /// 'en_US' şeklinde return'lüyor
    var deviceLanguageCode = deviceLocaleFullLanguageCode.split('_')[0]; /// ayırıp sadece 'en' yi alıyoruz.

    if(deviceLanguageCode == "tr"){
      return "Turkce";
    }else if(deviceLanguageCode == "en"){
      return "English";
    }else if(deviceLanguageCode == "ar"){
      return "العربية";
    }else{
      return "English";
    }
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
        adCounter,
        prefixSymbol,
    );
    await SQLHelper.updateSetting(info);
    notifyListeners();
  }
  void setStatus(bool value){
    Status = value ;
    notifyListeners();
  }
}