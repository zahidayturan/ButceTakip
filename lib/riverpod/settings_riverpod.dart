import 'dart:io';
import 'package:butcekontrol/models/settings_info.dart';
import 'package:butcekontrol/pages/bka_slider.dart';
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
  int ?isBackUp; //yedeklenme açık mı
  String ?Backuptimes ;
  String ?lastBackup;
  String ?Password ;
  String ?securityQu ;
  int ?securityClaim ;
  int ?adCounter;
  bool ?Status; // şifre girildi mi ?
  String ?prefixSymbol = "₺";
  int ?monthStartDay;
  String ?dateFormat;
  bool backUpAlert = false ;

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
    monthStartDay = setting[setting.length - 1].monthStartDay;
    dateFormat = setting[setting.length - 1].dateFormat;

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
      adCounter(Kalan Hak) : ${setting[setting.length - 1].adCounter}
      tarih ve gün : ${setting[setting.length - 1].dateFormat}${setting[setting.length - 1].monthStartDay}""");
    notifyListeners();
  }
  Future controlSettings(BuildContext context) async{ //settings Kayıt değerlendiriyoruz.A
    List<SettingsInfo> ?settingsReglength = await SQLHelper.settingsControl();
    if(settingsReglength.length > 0) {
      prefixSymbol = settingsReglength[0].prefixSymbol;
      monthStartDay = settingsReglength[0].monthStartDay;
      dateFormat = settingsReglength[0].dateFormat;
      await readDb();
    }else{
     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => bkaSlider()));
      final info = SettingsInfo("TRY", 0, 0, "Turkce", 0, "Günlük", "00.00.0000", "null", "null", 3, 2, " ₺", 1, "dd.MM.yyyy") ;
      await SQLHelper.addItemSetting(info);
      await readDb();
    }
    notifyListeners();
  }

  void reset(){
    this.securityQu = "null";
    Updating();
  }
  void setbackUpAlert(){
    backUpAlert = true;
    setisuseinsert();
  }
  void setisuseinsert(){
    isuseinsert = !isuseinsert ;
    notifyListeners();
  }
  void Backup(String fileName){
    writeToCvs(fileName);
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
  String convertPrefix(String prefix){
    switch(prefix){
      case "TRY":
        return " ₺";
      case "EUR":
        return  " €";
      case "USD":
        return  " \$";
      case "GBP":
        return " £";
      case "KWD":
        return " د.ك";
      case "JOD":
        return " JD";
      case "IQD":
        return " د.ع";
      case "SAR":
        return " ر.س";
      default:
        return  " ?";
    }
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
  void setLastBackup({bool? a}){
    DateTime now = DateTime.now();
    if(a ?? false){
      lastBackup = DateFormat('dd.MM.yyyy').format(now.subtract(const Duration(days: 1)));
    }else{
      lastBackup =  DateFormat('dd.MM.yyyy').format(now) ;
    }
    Updating();
  }

  void setLanguage(String language){
    Language = language;
    Updating();
  }
  void setMonthStartDay(int monthStartDay){
    this.monthStartDay = monthStartDay;
    Updating();
  }
  void setDateFormat(String dateFormat){
    this.dateFormat = dateFormat;
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
        monthStartDay,
        dateFormat
    );
    await SQLHelper.updateSetting(info);
    notifyListeners();
  }
  void setStatus(bool value){
    Status = value ;
    notifyListeners();
  }
}