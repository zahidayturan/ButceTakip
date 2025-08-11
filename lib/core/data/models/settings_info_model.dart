class SettingsInfoModel {

  int ?id;
  int ?darkMode;

  SettingsInfoModel(
      this.id,
      this.darkMode,
      );

  Map <String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map["DarkMode"] = darkMode;
    return map ;
  }
  SettingsInfoModel.fromObject(dynamic o){
    id = o["id"] as int ;
    darkMode = o["DarkMode"] as int ;
  }
}