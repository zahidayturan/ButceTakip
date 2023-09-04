import 'package:app_settings/app_settings.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../UI/change_prefix_alert.dart';
import 'password_splash.dart';
import 'backup.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

///Koyu tema , Yedeklenme durumunun  database ile implementi sağlanrı
class _SettingsState extends ConsumerState<Settings> {
  List<String> moneyPrefix = <String>[
    'TRY',
    "USD",
    "EUR",
    "GBP",
    "KWD",
    "JOD",
    "IQD",
    "SAR"
  ];
  List<String> getMoneyNameList() {
    List<String> moneyNameList = <String>[
      'TRY - Türkiye - ₺',
      "USD - USA - \$",
      "EUR - Europe - €",
      "GBP - The United Kingdom - £",
      "KWD - Kuwait - د.ك",
      "JOD - Jordan - د.أ'",
      "IQD - Iraq - د.ع",
      "SAR - Saudi Arabia - ر.س",
    ];
    return moneyNameList;
  }

  List<String> dilDestegi = <String>["Türkçe", "English", "العربية"];
  List<String> monthStartDays = <String>["1", "8", "15", "22", "29"];
  CustomColors renkler = CustomColors();

  @override
  Widget build(BuildContext context) {
    List<String> dateFormats = <String>[translation(context).dayMonthYear, translation(context).monthDayYear, translation(context).yearMonthDay];
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = Theme.of(context).primaryColor;
    ref.watch(settingsRiverpod).isuseinsert;
    var size = MediaQuery.of(context).size;
    var readSetting = ref.read(settingsRiverpod);
    var readDb = ref.read(databaseRiverpod);
    //String? Language = readSetting.Language;
    bool darkthememode = readSetting.DarkMode == 1 ? true : false;
    bool isPassword = readSetting.isPassword == 1 ? true : false;
    bool isBackup = readSetting.isBackUp == 1 ? true : false;
    String language =
        readSetting.Language! == "Turkce" ? "Türkçe" : readSetting.Language!;
    int monthStartDay = readSetting.monthStartDay!;
    String dateFormat = readSetting.dateFormat == "dd.MM.yyyy"
        ? translation(context).dayMonthYear
        : readSetting.dateFormat == "MM.dd.yyyy"
            ? translation(context).monthDayYear
            : translation(context).yearMonthDay;

    /// dilDestegi ile database çakışmasından dolayı böyle bir koşullu atama ekledik
    String dropdownshowitem = 'TRY';
    String? Prefix = readSetting.Prefix;
    ref.watch(settingsRiverpod).isuseinsert;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          //backgroundColor: ThemeData().scaffoldBackgroundColor,
          bottomNavigationBar: const NavBar(),
          appBar: AppBarForPage(title: translation(context).settingsTitle),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(
                          translation(context).darkMode,
                          style: const TextStyle(
                              fontFamily: "Nexa3", fontSize: 15, height: 1),
                        ),
                        const Spacer(),
                        darkthememode
                            ? Text(
                                translation(context).on,
                                style: const TextStyle(
                                  fontFamily: "Nexa3",
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                translation(context).off,
                                style: const TextStyle(
                                  fontFamily: "Nexa3",
                                  fontSize: 15,
                                ),
                              ),
                        Switch(
                          activeColor: renkler.sariRenk,
                          value: darkthememode,
                          onChanged: (bool value) {
                            setState(() {
                              readSetting.setDarkMode(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///Koyu tema
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        if (isPassword && readSetting.Password != "null") {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 1),
                              pageBuilder: (context, animation, nextanim) =>
                                  const PasswordSplash(mode: "admin"),
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
                        } else {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 1),
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
                                fontFamily: "Nexa3", fontSize: 15, height: 1),
                          ),
                          const Spacer(),
                          isPassword
                              ? Text(
                                  translation(context).on,
                                  style: const TextStyle(
                                    fontFamily: "Nexa3",
                                    height: 1,
                                    fontSize: 15,
                                  ),
                                )
                              : Text(
                                  translation(context).off,
                                  style: const TextStyle(
                                    fontFamily: "Nexa3",
                                    height: 1,
                                    fontSize: 15,
                                  ),
                                ),
                          const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 1),
                            pageBuilder: (context, animation, nextanim) =>
                                const BackUp(),
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
                      },
                      child: Row(
                        children: [
                          Text(
                            translation(context).backupStatus,
                            style: const TextStyle(
                                fontFamily: "Nexa3", fontSize: 15, height: 1),
                          ),
                          const Spacer(),
                          isBackup
                              ? Text(
                                  translation(context).on,
                                  style: const TextStyle(
                                    fontFamily: "Nexa3",
                                    height: 1,
                                    fontSize: 15,
                                  ),
                                )
                              : Text(
                                  translation(context).off,
                                  style: const TextStyle(
                                    fontFamily: "Nexa3",
                                    height: 1,
                                    fontSize: 15,
                                  ),
                                ),
                          const Icon(
                            Icons.arrow_forward_ios,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        AppSettings.openAppSettings(
                            type: AppSettingsType.notification);
                      },
                      child: Row(
                        children: [
                          Text(
                            translation(context).notifications,
                            style: const TextStyle(
                                fontFamily: "Nexa3", fontSize: 15, height: 1),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: renkler.arkaRenk, // Set border color
                          width: 1.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text(
                            translation(context).defaultCurrency,
                            style: const TextStyle(
                                fontFamily: "Nexa3", fontSize: 15, height: 1),
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
                                value: Prefix,
                                elevation: 16,
                                style: TextStyle(color: renkler.sariRenk),
                                underline: Container(
                                  height: 2,
                                  color: renkler.koyuuRenk,
                                ),
                                onChanged: (newValue) async {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false, //sayfa saydam olması için
                                      transitionDuration:
                                          const Duration(milliseconds: 1),
                                      pageBuilder:
                                          (context, animation, nextanim) =>
                                              changePrefixAlert(newValue!),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 1),
                                      transitionsBuilder: (context, animation,
                                          nexttanim, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                  /*


                                   */
                                },
                                items: moneyPrefix
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                    onTap: () {
                                      print(value);
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: renkler.arkaRenk, // Set border color
                        width: 1.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(
                          translation(context).language,
                          style: const TextStyle(
                              fontFamily: "Nexa3", fontSize: 15, height: 1),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 30,
                            width: 80,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
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
                                if (newValue == "Türkçe") {
                                  /// database te Turkce yazılı olduğu için if koşulu kullandık.
                                  readSetting.setLanguage("Turkce");
                                  readSetting.setDateFormat("dd.MM.yyyy");
                                } else if(newValue == dilDestegi[1]) {
                                  readSetting.setLanguage(newValue!);
                                  readSetting.setDateFormat("MM.dd.yyyy");
                                } else if (newValue == dilDestegi[2]) {
                                  readSetting.setLanguage(newValue!);
                                  readSetting.setDateFormat("yyyy.MM.dd");
                                } else{
                                  readSetting.setLanguage(newValue!);
                                  readSetting.setDateFormat("MM.dd.yyyy");
                                }
                                readSetting.setisuseinsert();
                              },
                              items: dilDestegi.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: () {},
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8,left: 8),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).highlightColor,
                            border: Border.all(width: 1,color: renkler.arkaRenk,strokeAlign: BorderSide.strokeAlignOutside)
                        ),
                        child: Icon(
                          Icons.timelapse_rounded,
                          color: renkler.arkaRenk,
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            translation(context).firstDayOfTheMonth,
                            style: const TextStyle(
                                fontFamily: "Nexa3", fontSize: 15, height: 1),
                          ),
                          const Spacer(),
                          Container(
                            height: 28,
                            decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Center(
                                  child: Text(
                                    translation(context).select,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Nexa3',
                                      color: renkler.arkaRenk,
                                    ),
                                  ),
                                ),
                                items: monthStartDays
                                    .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Nexa3',
                                            color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: monthStartDay.toString(),
                                onChanged: (newValue) {
                                  setState(
                                        () {
                                          readSetting
                                              .setMonthStartDay(int.parse(newValue!));
                                          readSetting.setisuseinsert();
                                    },
                                  );
                                },
                                barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                buttonStyleData: ButtonStyleData(
                                  overlayColor: MaterialStatePropertyAll(renkler
                                      .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  height: 34,
                                  width: 60,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).highlightColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                    scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(15),
                                        thumbColor: MaterialStatePropertyAll(
                                            renkler.sariRenk))),
                                menuItemStyleData: MenuItemStyleData(
                                  overlayColor: MaterialStatePropertyAll(
                                      renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                  height: 34,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  iconEnabledColor:
                                  renkler.arkaRenk,
                                  iconDisabledColor:
                                  Theme.of(context).secondaryHeaderColor,
                                  openMenuIcon: Icon(
                                    Icons.arrow_right,
                                    color: Theme.of(context).canvasColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8,left: 8),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).highlightColor,
                            border: Border.all(width: 1,color: renkler.arkaRenk,strokeAlign: BorderSide.strokeAlignOutside)
                        ),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          color: renkler.arkaRenk,
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            translation(context).dateFormat,
                            style: const TextStyle(
                                fontFamily: "Nexa3", fontSize: 15, height: 1),
                          ),
                          const Spacer(),
                          Container(
                            height: 28,
                            decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Center(
                                  child: Text(
                                    translation(context).select,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Nexa3',
                                      color: renkler.arkaRenk,
                                    ),
                                  ),
                                ),
                                items: dateFormats
                                    .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Nexa3',
                                            color: renkler.arkaRenk),
                                      ),
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: dateFormat,
                                onChanged: (newValue) {
                                  setState(
                                        () {
                                      if (newValue == translation(context).dayMonthYear) {
                                        readSetting.setDateFormat("dd.MM.yyyy");
                                      } else if (newValue == translation(context).monthDayYear) {
                                        readSetting.setDateFormat("MM.dd.yyyy");
                                      } else if (newValue == translation(context).yearMonthDay) {
                                        readSetting.setDateFormat("yyyy.MM.dd");
                                      } else {
                                        readSetting.setDateFormat("dd.MM.yyyy");
                                      }
                                      readSetting.setisuseinsert();
                                    },
                                  );
                                },
                                barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                buttonStyleData: ButtonStyleData(
                                  overlayColor: MaterialStatePropertyAll(renkler
                                      .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  height: 34,
                                  width: double.parse(translation(context).dateFormatSize),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    width: double.parse(translation(context).dateFormatSize),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).highlightColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                    scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(15),
                                        thumbColor: MaterialStatePropertyAll(
                                            renkler.sariRenk))),
                                menuItemStyleData: MenuItemStyleData(
                                  overlayColor: MaterialStatePropertyAll(
                                      renkler.koyuAraRenk), // MENÜ BASILMA RENGİ
                                  height: 34,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  iconEnabledColor:
                                  renkler.arkaRenk,
                                  iconDisabledColor:
                                  Theme.of(context).secondaryHeaderColor,
                                  openMenuIcon: Icon(
                                    Icons.arrow_right,
                                    color: Theme.of(context).canvasColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );

    /// Yedekleme durumu
    ///Dil seçeneği
  }
  /*
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
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)
                      ),
                      border: Border.all(
                          color: renkler.arkaRenk, // Set border color
                          width: 1.0),
                      color: Theme.of(context).primaryColor,
                    ),
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
    style: TextStyle(
    fontFamily: "Nexa3",
    ),
    ),
    const Spacer(),
   */

  /*


   */
/*
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
                                  value: Prefix,
                                  elevation: 16,
                                  style: TextStyle(color: renkler.sariRenk),
                                  underline: Container(
                                    height: 2,
                                    color: renkler.koyuuRenk,
                                  ),
                                  onChanged: (newValue) {
                                    if(readSetting.Prefix != newValue){
                                      readSetting.setPrefix(newValue!);
                                      currencyRiv.calculateAllSQLRealTime();//Bütün kayıtları hocam değiştiriyor.
                                      readSetting.setisuseinsert();
                                    }
                                    print("");
                                  },
                                  items: moneyPrefix.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                      },
                                    );
                                  }).toList(),
                            Icon(
                              Icons.arrow_forward_ios,
                            ),
                              isBackup  ? Text(translation(context).on, style: const TextStyle(fontFamily: "Nexa3"),)
                                : Text(translation(context).off, style: const TextStyle(fontFamily: "Nexa3"),),


 */
} /*
 Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)
                      ),
                      border: Border.all(
                          color: renkler.arkaRenk, // Set border color
                          width: 1.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Text(
                            translation(context).currency,
                            style: TextStyle(
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
                ),///Para Birimi
*/
