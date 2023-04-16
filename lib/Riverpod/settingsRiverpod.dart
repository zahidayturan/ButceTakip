import 'package:butcekontrol/modals/settingsinfo.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/CvsConverter.dart';

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
  bool Status  = false ; // şifre girildi mi ?

  Future readDb() async{
    List<settingsinfo> setting = await SQLHelper.settingsControl() ;
    id = setting[setting.length - 1].id ;
    Prefix = setting[setting.length - 1].Prefix ;
    DarkMode = setting[setting.length - 1].DarkMode;
    isPassword = setting[setting.length - 1].isPassword;
    Language = setting[setting.length - 1].Language;
    isBackUp = setting[setting.length - 1].isBackUp;
    Backuptimes = setting[setting.length - 1].Backuptimes;
    lastBackup = setting[setting.length - 1].lastBackup;
    Password = setting[setting.length - 1].Password;
    print("""
      id : ${setting[setting.length - 1].id}
      dil :${setting[setting.length - 1].Prefix}
      Darkmode :${setting[setting.length - 1].DarkMode}
      isPassword : ${setting[setting.length - 1].isPassword}
      Language : ${setting[setting.length - 1].Language}
      isBackup :${isBackUp = setting[setting.length - 1].isBackUp}
      Backuptims : ${setting[setting.length - 1].Backuptimes}
      lastBackup : ${setting[setting.length - 1].lastBackup}
      Password : ${setting[setting.length - 1].Password}""");
    notifyListeners();
  }
  Future controlSettings() async{ //settings Kayıt değerlendiriyoruz.
    List<settingsinfo> ?settingsReglength = await SQLHelper.settingsControl();
    if(settingsReglength.length > 0) {
      readDb();
    }else{
      final info = settingsinfo("TRY", 0, 0, "Turkce", 0, "Günlük", "00.00.0000", "null") ;
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
    final info = settingsinfo.withId(
        id,
        Prefix,
        DarkMode,
        isPassword,
        Language,
        isBackUp,
        Backuptimes,
        lastBackup,
        Password
    );
    await SQLHelper.updateSetting(info);
  }
  void setStatus(bool value){
    Status = value ;
    notifyListeners();
  }
}