import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../classes/language.dart';
import 'password_splash.dart';
import 'backup.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}
///Koyu tema , Yedeklenme durumunun  database ile implementi sağlanrı
class _SettingsState extends ConsumerState<Settings> {
  List<String> moneyPrefix = <String>['TRY'];
  List<String> dilDestegi = <String>["Türkçe", "English", "العربية"];
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    ref.watch(settingsRiverpod).isuseinsert;
    var size = MediaQuery.of(context).size;
    var readSetting = ref.read(settingsRiverpod);
    bool darkthememode = readSetting.DarkMode == 1 ? true : false ;
    bool isPassword = readSetting.isPassword == 1 ? true : false ;
    bool isBackup = readSetting.isBackUp == 1 ? true : false ;
    //String? Prefix = readSetting.Prefix ;
    String language = readSetting.Language! == "Turkce" ? "Türkçe" : readSetting.Language!; /// dilDestegi ile database çakışmasından dolayı böyle bir koşullu atama ekledik
    String dropdownshowitem = 'TRY';
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          bottomNavigationBar: const NavBar(),
          appBar: AppBarForPage(title: translation(context).settingsTitle),
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
                      color: renkler.arkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              translation(context).darkMode,
                              style: const TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            const Spacer(),
                            darkthememode ? Text(translation(context).on, style: const TextStyle(fontFamily: "Nexa3"),)
                                 :Text(translation(context).off, style: const TextStyle(fontFamily: "Nexa3"),),
                            Switch(
                              activeColor: renkler.sariRenk,
                              value: darkthememode,
                              onChanged: null
                                 /*
                                  (bool value) {
                                setState(() {
                                  readSetting.setDarkMode(value) ;
                                });

                              },
                                    */
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
                      color: renkler.arkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () {
                            if(isPassword && readSetting.Password != "null"){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const PasswordSplash(mode: "admin"),
                                  reverseTransitionDuration: const Duration(milliseconds: 1),
                                  transitionsBuilder: (context, animation, nexttanim, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }else {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) =>
                                      const PasswordPage(),
                                  reverseTransitionDuration:
                                  const Duration(milliseconds: 1),
                                  transitionsBuilder:
                                      (context, animation, nexttanim, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                translation(context).loginPassword,
                                style: const TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                              ),
                              const Spacer(),
                              isPassword
                                  ? Text(translation(context).on, style: const TextStyle(fontFamily: "Nexa3"),)
                                  : Text(translation(context).off, style: const TextStyle(fontFamily: "Nexa3"),),
                              const Icon(
                                Icons.arrow_forward_ios,
                              ),
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
                      color: renkler.arkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 1),
                                pageBuilder: (context, animation, nextanim) => const BackUp(),
                                reverseTransitionDuration: const Duration(milliseconds: 1),
                                transitionsBuilder: (context, animation, nexttanim, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Row(
                            children:  [
                              Text(
                                translation(context).backupStatus,
                                style: const TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                              ),
                              const Spacer(),
                              isBackup  ? Text(translation(context).on, style: const TextStyle(fontFamily: "Nexa3"),)
                                  : Text(translation(context).off, style: const TextStyle(fontFamily: "Nexa3"),),
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
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.arkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              translation(context).currency,
                              style: const TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            const Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 61,
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                  items: moneyPrefix
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
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: renkler.arkaRenk,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              translation(context).language,
                              style: const TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            const Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 30,
                                width: 80,
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                color: renkler.koyuuRenk,
                                child: DropdownButton(
                                  dropdownColor: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.circular(20),
                                  value: language,
                                  elevation: 16,
                                  style: TextStyle(color: renkler.sariRenk),
                                  underline: Container(
                                    height: 2,
                                    color: renkler.koyuuRenk,
                                  ),
                                  onChanged: (newValue) {
                                    if(newValue == "Türkçe"){ /// database te Turkce yazılı olduğu için if koşulu kullandık.
                                      readSetting.setLanguage("Turkce");
                                    }else{
                                      readSetting.setLanguage(newValue!);
                                    }
                                    readSetting.setisuseinsert();
                                  },
                                  items: dilDestegi
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
