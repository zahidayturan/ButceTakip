import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class settings extends ConsumerStatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  ConsumerState<settings> createState() => _settingsState();
}

class _settingsState extends ConsumerState<settings> {
  List<String> MoneyPrefix = <String>['TRY', 'USD', 'EUR'];
  List<String> Dilestegi = <String>["Türkçe", "English"];
  CustomColors renkler = CustomColors();
  bool darkthememode = false ;
  bool isPassword = false ;
  String Languagefirst = "Türkçe" ;
  String dropdownshowitem = 'TRY';
  @override
  Widget build(BuildContext context) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
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
                      color: Color(0xffD9D9D9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              "Koyu Tema",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                            ),
                            Spacer(),
                            darkthememode ? Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                          : Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                            Switch(
                                value: darkthememode ,
                                onChanged: (bool value) {
                                  setState(() {
                                    darkthememode = value;
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
                      color: Color(0xffD9D9D9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "Giriş Şifresi",
                              style: TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            Spacer(),
                            isPassword ? Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                : Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                            Switch(
                              value: isPassword ,
                              onChanged: (bool value) {
                                setState(() {
                                  isPassword = value;
                                });
                              },
                            ),
                          ],
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
                      color: Color(0xffD9D9D9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () => readNavBar.setCurrentindex(13),
                          child: Row(
                            children: const [
                              Text(
                                "Yedekleme Durumu",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                              ),
                              Spacer(),
                              Icon(
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
                      color: Color(0xffD9D9D9),
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
                      color: Color(0xffD9D9D9),
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
