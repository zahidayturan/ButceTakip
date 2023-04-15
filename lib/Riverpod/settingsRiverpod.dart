import 'package:butcekontrol/modals/settingsinfo.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:flutter/material.dart';

class SettingsRiverpod extends ChangeNotifier{
  int ?id;
  String ?Prefix;
  int ?DarkMode;
  int ?isPassword;
  String ?Language;
  int ?isBackUp;
  String ?Backuptimes ;

  Future readDb() async{
    List<settingsinfo> setting = await SQLHelper.settingsControl() ;
    id = setting[setting.length - 1].id ;
    Prefix = setting[setting.length - 1].Prefix ;
    DarkMode = setting[setting.length - 1].DarkMode;
    isPassword = setting[setting.length - 1].isPassword;
    Language = setting[setting.length - 1].Language;
    isBackUp = setting[setting.length - 1].isBackUp;
    Backuptimes = setting[setting.length - 1].Backuptimes;
    print("id : ${setting[setting.length - 1].id},\ndil :${setting[setting.length - 1].Prefix},\nDarkmode :${setting[setting.length - 1].DarkMode},\nisPassword : ${setting[setting.length - 1].isPassword}\nLanguage : ${setting[setting.length - 1].Language}\nisBackup :${isBackUp = setting[setting.length - 1].isBackUp}\nBackuptims : ${setting[setting.length - 1].Backuptimes}");
    notifyListeners();
  }
  Future controlSettings() async{ //settings Kayıt değerlendiriyoruz.
    List<settingsinfo> ?settingsReglength = await SQLHelper.settingsControl();
    if(settingsReglength.length > 0) {
      readDb();
    }else{
      final info = settingsinfo("TRY", 0, 0, "Turkce", 0, "day") ;
      await SQLHelper.addItemSetting(info);
    }
    notifyListeners();
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
    } else if(time == "Haftalık") {
      Backuptimes = "Haftalık";
    } else {
      Backuptimes = "Yıllık";
    }
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
        Backuptimes );
    await SQLHelper.updateSetting(info);
  }
}