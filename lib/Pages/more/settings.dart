import 'package:butcekontrol/Pages/more/Backup.dart';
import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class settings extends ConsumerStatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  ConsumerState<settings> createState() => _settingsState();
}
///Koyu tema , Yedeklenme durumunun  database ile implementi sağlanrı
class _settingsState extends ConsumerState<settings> {
  List<String> MoneyPrefix = <String>['TRY'];
  List<String> Dilestegi = <String>["Türkçe"];
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readNavBar = ref.read(botomNavBarRiverpod);
    var readSetting = ref.read(settingsRiverpod);
    bool darkthememode = readSetting.DarkMode == 1 ? true : false ;
    bool isPassword = readSetting.isPassword == 1 ? true : false ;
    bool isBackup = readSetting.isBackUp == 1 ? true : false ;
    String? Language = readSetting.Language;
    String? Prefix = readSetting.Prefix ;
    String Languagefirst = "Türkçe" ;
    String dropdownshowitem = 'TRY';

    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: navBar(),
          appBar: AppBarForPage(title: "AYARLAR"),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.ArkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "Koyu Tema",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                            ),
                            Spacer(),
                            darkthememode ?  const Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                          : const Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                            Switch(
                                value: darkthememode,
                                onChanged: (bool value) {
                                  setState(() {
                                    readSetting.setDarkMode(value) ;
                                  });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ), ///Koyu tema
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.ArkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () {
                            readNavBar.setCurrentindex(14);
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Giriş Şifresi",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                              ),
                              Spacer(),
                              isPassword  ? Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                  : Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                              Icon(
                                Icons.arrow_forward_ios,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ), /// Giriş şifresi
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.ArkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () => readNavBar.setCurrentindex(13),
                          child: Row(
                            children:  [
                              const Text(
                                "Yedeklenme Durumu",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                              ),
                              Spacer(),
                              isBackup  ? const Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                  : const Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                              const Icon(
                                Icons.arrow_forward_ios,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),/// Yedekleme durumu
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.ArkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "Para Birimi",
                              style: TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 61,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                color: renkler.koyuuRenk,
                                child: DropdownButton(
                                  dropdownColor: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.circular(20),
                                   value: dropdownshowitem,
                                  elevation: 16,
                                  style: TextStyle(color: renkler.sariRenk),
                                  underline: Container(
                                    height: 2,
                                    color: renkler.koyuuRenk,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownshowitem = newValue!;
                                    });
                                  },
                                  items: MoneyPrefix
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),/// Para Birimi
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.ArkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "Dil Desteği",
                              style: TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 80,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                color: renkler.koyuuRenk,
                                child: DropdownButton(
                                  dropdownColor: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.circular(20),
                                  value: Languagefirst,
                                  elevation: 16,
                                  style: TextStyle(color: renkler.sariRenk),
                                  underline: Container(
                                    height: 2,
                                    color: renkler.koyuuRenk,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      Languagefirst = newValue!;
                                    });
                                  },
                                  items: Dilestegi
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {

                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),///Dil seçeneği
              ],
            ),
          ),
        ),
      ),
    );
  }

}
