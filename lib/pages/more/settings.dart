import 'package:app_settings/app_settings.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();



  @override
  void initState() {
    var readSettings = ref.read(settingsRiverpod);
    var adEventCounter = readSettings.adEventCounter;
    if (adEventCounter! < 6) {
      _interstitialAdManager.loadInterstitialAd();
    } else {
    }
    super.initState();
  }
  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }

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

  List<String> moneyNameList = <String>[
    'TRY - Türkiye - ₺',
    "USD - USA - \$",
    "EUR - Europe - €",
    "GBP - UK - £",
    "KWD - Kuwait - د.ك",
    "JOD - Jordan - د.أ'",
    "IQD - Iraq - د.ع",
    "SAR - Suudi Ar. - ر.س",
  ];

  List<String> dilDestegi = <String>["Türkçe", "English", "العربية"];
  List<String> monthStartDays = <String>["1", "8", "15", "22", "29"];
  CustomColors renkler = CustomColors();
  int lampCounter = 0;
  @override
  Widget build(BuildContext context) {
    List<String> dateFormats = <String>[
      translation(context).dayMonthYear,
      translation(context).monthDayYear,
      translation(context).yearMonthDay
    ];
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = Theme
        .of(context)
        .primaryColor;
    ref
        .watch(settingsRiverpod)
        .isuseinsert;
    var size = MediaQuery
        .of(context)
        .size;
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
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
    String? Prefix = readSetting.Prefix;
    String? listIndexPrefix;
    String getListIndexInPrefix() {
      moneyNameList.forEach((element) {
        if (element.contains(Prefix!)) {
          listIndexPrefix = element.toString();
        }
      });
      return listIndexPrefix ?? "";
    }
    ref
        .watch(settingsRiverpod)
        .isuseinsert;
    var adEventCounter = readSetting.adEventCounter;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          bottomNavigationBar: const NavBar(),
          appBar: AppBarForPage(title: translation(context).settingsTitle),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            child:
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
              SliverFillRemaining(
              hasScrollBody: false,
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            height: 40,
                            width: size.width * 0.75,
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .indicatorColor, // Set border color
                                  width: 1.0),
                              //color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 7.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Theme
                                          .of(context)
                                          .scaffoldBackgroundColor,
                                      shape: BoxShape.circle,
                                      /*boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(-1, 1),
                                          ),
                                        ]*/
                                    ),
                                    child: Icon(
                                      Icons.language_rounded,
                                      color: Theme
                                          .of(context)
                                          .secondaryHeaderColor,
                                      size: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, left: 8, right: 8),
                                    child: Text(
                                      translation(context).language,
                                      style: const TextStyle(
                                          fontFamily: "Nexa3",
                                          fontSize: 14,
                                          height: 1),
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 26,
                                      width: 100,
                                      color: Theme
                                          .of(context)
                                          .highlightColor,
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
                                          items: dilDestegi
                                              .map((item) =>
                                              DropdownMenuItem(
                                                value: item,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(top: 2),
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Nexa3',
                                                          color: renkler
                                                              .arkaRenk),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                              .toList(),
                                          value: language,
                                          onChanged: (newValue) {
                                            if (adEventCounter! <= 0) {
                                              _showInterstitialAd(context);
                                              readSetting.resetAdEventCounter();
                                            } else {
                                              readSetting.useAdEventCounter();
                                            }
                                            if (newValue == "Türkçe") {
                                              /// database te Turkce yazılı olduğu için if koşulu kullandık.
                                              readSetting.setLanguage("Turkce");
                                              readSetting
                                                  .setDateFormat("dd.MM.yyyy");
                                            } else
                                            if (newValue == dilDestegi[1]) {
                                              readSetting.setLanguage(newValue!);
                                              readSetting
                                                  .setDateFormat("MM.dd.yyyy");
                                            } else
                                            if (newValue == dilDestegi[2]) {
                                              readSetting.setLanguage(newValue!);
                                              readSetting
                                                  .setDateFormat("yyyy.MM.dd");
                                            } else {
                                              readSetting.setLanguage(newValue!);
                                              readSetting
                                                  .setDateFormat("MM.dd.yyyy");
                                            }
                                            readSetting.setisuseinsert();
                                          },
                                          barrierColor:
                                          renkler.koyuAraRenk.withOpacity(0.4),
                                          buttonStyleData: ButtonStyleData(
                                            overlayColor: MaterialStatePropertyAll(
                                                renkler
                                                    .koyuAraRenk),
                                            // BAŞLANGIÇ BASILMA RENGİ
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            height: 30,
                                            width: 100,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                              maxHeight: 250,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Theme
                                                      .of(context)
                                                      .highlightColor,
                                                  borderRadius: const BorderRadius
                                                      .all(
                                                      Radius.circular(5))),
                                              scrollbarTheme: ScrollbarThemeData(
                                                  radius: const Radius.circular(
                                                      15),
                                                  thumbColor: MaterialStatePropertyAll(
                                                      Theme
                                                          .of(context)
                                                          .disabledColor))),
                                          menuItemStyleData: MenuItemStyleData(
                                            overlayColor: MaterialStatePropertyAll(
                                                renkler
                                                    .sariRenk),
                                            // MENÜ BASILMA RENGİ
                                            height: 30,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                            ),
                                            iconSize: 24,
                                            iconEnabledColor: renkler.arkaRenk,
                                            iconDisabledColor: renkler.arkaRenk,
                                            openMenuIcon: Icon(
                                              Icons.keyboard_arrow_up_rounded,
                                              color: renkler.arkaRenk,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            height: 40,
                            width: size.width * 0.75,
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .indicatorColor, // Set border color
                                  width: 1.0),
                              //color: Theme.of(context).primaryColor,
                            ),
                            child: InkWell(
                              onTap: () {
                                AppSettings.openAppSettings(
                                    type: AppSettingsType.notification);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Theme
                                            .of(context)
                                            .scaffoldBackgroundColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.notifications_rounded,
                                        color: Theme
                                            .of(context)
                                            .secondaryHeaderColor,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, left: 8, right: 8),
                                      child: Text(
                                        translation(context).notifications,
                                        style: const TextStyle(
                                            fontFamily: "Nexa3",
                                            fontSize: 14,
                                            height: 1),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).splashColor,
                                        shape: BoxShape.circle
                                      ),
                                      child: Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Theme
                                            .of(context)
                                            .canvasColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                        onTap: () {
                          lampCounter < 9 ? readSetting.setDarkModeNotBool() : null;
                          lampCounter += 1;
                          lampCounter == 12 ? lampCounter = 0 : null;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                          width: darkMode == 0 ? 50 : 40,
                          height: darkMode == 0 ? 100 : 80,
                          //padding: darkMode == 0 ?  EdgeInsets.zero : EdgeInsets.only(bottom: 20),
                          child: Image.asset(
                            lampCounter < 9 ?
                            darkMode == 0
                                ? "assets/icons/lightTheme.png"
                                : "assets/icons/darkTheme.png" :
                            darkMode == 0
                                ? "assets/icons/lightTheme2.png"
                                : "assets/icons/darkTheme2.png",
                          ),

                        )

                    ),
                    const SizedBox(width: 0.1,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      boxShadow: darkMode == 1 ? [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        )
                      ] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .indicatorColor, // Set border color
                          width: 1.0),
                      //color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
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
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                                /*boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(-1, 1),
                                          ),
                                        ]*/
                              ),
                              child: Icon(
                                isPassword ? Icons.lock_rounded : Icons
                                    .lock_open_rounded,
                                color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, left: 8, right: 8),
                              child: Text(
                                translation(context).loginPassword,
                                style: const TextStyle(
                                    fontFamily: "Nexa3", fontSize: 14, height: 1),
                              ),
                            ),
                            const Spacer(),
                            isPassword
                                ? Padding(
                              padding: const EdgeInsets.only(top: 2,left: 8,right: 8),
                              child: Text(
                                translation(context).on,
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                  color: Theme
                                      .of(context)
                                      .secondaryHeaderColor,
                                  height: 1,
                                  fontSize: 14,
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.only(top: 2,left: 8,right: 8),
                              child: Text(
                                translation(context).off,
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                  color: Theme
                                      .of(context)
                                      .canvasColor,
                                  height: 1,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Theme
                                    .of(context)
                                    .canvasColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      boxShadow: darkMode == 1 ? [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        )
                      ] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .indicatorColor, // Set border color
                          width: 1.0),
                      //color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
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
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                                /*boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(-1, 1),
                                          ),
                                        ]*/
                              ),
                              child: Icon(
                                isBackup ? Icons.backup_rounded : Icons
                                    .backup_outlined,
                                color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, left: 8, right: 8),
                              child: Text(
                                translation(context).backupStatus,
                                style: const TextStyle(
                                    fontFamily: "Nexa3", fontSize: 14, height: 1),
                              ),
                            ),
                            const Spacer(),
                            isBackup
                                ? Padding(
                              padding: const EdgeInsets.only(top: 2,left: 8,right: 8),
                              child: Text(
                                translation(context).on,
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                  color: Theme
                                      .of(context)
                                      .secondaryHeaderColor,
                                  height: 1,
                                  fontSize: 14,
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.only(top: 2,left: 8,right: 8),
                              child: Text(
                                translation(context).off,
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                  color: Theme
                                      .of(context)
                                      .canvasColor,
                                  height: 1,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Theme
                                    .of(context)
                                    .canvasColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      boxShadow: darkMode == 1 ? [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        )
                      ] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .indicatorColor, // Set border color
                          width: 1.0),
                      //color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                              /*boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(-1, 1),
                                        ),
                                      ]*/
                            ),
                            child: Icon(
                              Icons.currency_lira_rounded,
                              color: Theme
                                  .of(context)
                                  .secondaryHeaderColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, left: 8, right: 8),
                            child: Text(
                              translation(context).currency,
                              style: const TextStyle(
                                  fontFamily: "Nexa3", fontSize: 14, height: 1),
                            ),
                          ),
                          const Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 26,
                              width: 150,
                              color: Theme
                                  .of(context)
                                  .highlightColor,
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
                                  items: moneyNameList.map((item) =>
                                      DropdownMenuItem(
                                        value: item,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.zero,
                                            child: FittedBox(
                                              child: Text(item,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "TL",
                                                    color: renkler.arkaRenk),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  value: getListIndexInPrefix(),
                                  onChanged: (newValue) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration:
                                        const Duration(milliseconds: 1),
                                        pageBuilder:
                                            (context, animation, nextanim) =>
                                            changePrefixAlert(
                                                newValue.toString().substring(
                                                    0, 3)),
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
                                  },
                                  barrierColor: renkler.koyuAraRenk.withOpacity(
                                      0.4),
                                  buttonStyleData: ButtonStyleData(
                                    overlayColor: MaterialStatePropertyAll(renkler
                                        .sariRenk), // BAŞLANGIÇ BASILMA RENGİ
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      maxHeight: 280,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Theme
                                              .of(context)
                                              .highlightColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(15),
                                          thumbColor: MaterialStatePropertyAll(
                                              Theme
                                                  .of(context)
                                                  .disabledColor))),
                                  menuItemStyleData: MenuItemStyleData(
                                    overlayColor: MaterialStatePropertyAll(Theme
                                        .of(context)
                                        .disabledColor), // MENÜ BASILMA RENGİ
                                    height: 32,
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    iconSize: 24,
                                    iconEnabledColor: renkler.arkaRenk,
                                    iconDisabledColor: renkler.arkaRenk,
                                    openMenuIcon: Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: renkler.arkaRenk,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      boxShadow: darkMode == 1 ? [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        )
                      ] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .indicatorColor, // Set border color
                          width: 1.0),
                      //color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                              /*boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(-1, 1),
                                        ),
                                      ]*/
                            ),
                            child: Icon(
                              Icons.timelapse_rounded,
                              color: Theme
                                  .of(context)
                                  .secondaryHeaderColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, left: 8, right: 8),
                            child: Text(
                              translation(context).firstDayOfTheMonth,
                              style: const TextStyle(
                                  fontFamily: "Nexa3", fontSize: 14, height: 1),
                            ),
                          ),
                          const Spacer(),
                          Tooltip(
                            message:  translation(context).answer6,
                            triggerMode: TooltipTriggerMode.tap,
                            showDuration: const Duration(seconds: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            textStyle: TextStyle(
                                fontSize: 14,
                                color: renkler.arkaRenk,
                                height: 1),
                            textAlign: TextAlign.justify,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).highlightColor,
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .indicatorColor, // Set border color
                                  width: 1.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  color: Theme
                                      .of(context)
                                      .canvasColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .highlightColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
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
                                    .map((item) =>
                                    DropdownMenuItem(
                                      value: item,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(top: 2),
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
                                          if (adEventCounter! <= 0) {
                                            _showInterstitialAd(context);
                                            readSetting.resetAdEventCounter();
                                          } else {
                                            readSetting.useAdEventCounter();
                                          }
                                      readSetting.setMonthStartDay(
                                          int.parse(newValue!));
                                      ref.read(calendarRiverpod).setMonthStartDay(int.parse(newValue!));
                                      readSetting.setMonthStarDayForHomePage(int.parse(newValue!));
                                      ref.read(databaseRiverpod).setMonthandYear(readSetting.monthIndex.toString(), readSetting.yearIndex.toString());
                                      ref.read(homeRiverpod).setStatus();
                                      readSetting.setisuseinsert();
                                    },
                                  );
                                },
                                barrierColor: renkler.koyuAraRenk.withOpacity(
                                    0.4),
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
                                        color: Theme
                                            .of(context)
                                            .highlightColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(15),
                                        thumbColor: MaterialStatePropertyAll(
                                            Theme
                                                .of(context)
                                                .disabledColor))),
                                menuItemStyleData: MenuItemStyleData(
                                  overlayColor: MaterialStatePropertyAll(renkler
                                      .sariRenk), // MENÜ BASILMA RENGİ
                                  height: 34,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                  ),
                                  iconSize: 24,
                                  iconEnabledColor: renkler.arkaRenk,
                                  iconDisabledColor: renkler.arkaRenk,
                                  openMenuIcon: Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    color: renkler.arkaRenk,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      boxShadow: darkMode == 1 ? [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        )
                      ] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Theme
                              .of(context)
                              .indicatorColor, // Set border color
                          width: 1.0),
                      //color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                              /*boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: const Offset(-1, 1),
                                            ),
                                          ]*/
                            ),
                            child: Icon(
                              Icons.calendar_month_rounded,
                              color: Theme
                                  .of(context)
                                  .secondaryHeaderColor,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, left: 8, right: 8),
                            child: Text(
                              translation(context).dateFormat,
                              style: const TextStyle(
                                  fontFamily: "Nexa3", fontSize: 14, height: 1),
                            ),
                          ),
                          const Spacer(),
                          Tooltip(
                            message:  translation(context).answer7,
                            triggerMode: TooltipTriggerMode.tap,
                            showDuration: const Duration(seconds: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            textStyle: TextStyle(
                                fontSize: 14,
                                color: renkler.arkaRenk,
                                height: 1),
                            textAlign: TextAlign.justify,
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).highlightColor,
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .indicatorColor, // Set border color
                                  width: 1.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    shape: BoxShape.circle
                                ),
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  color: Theme
                                      .of(context)
                                      .canvasColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .highlightColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
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
                                    .map((item) =>
                                    DropdownMenuItem(
                                      value: item,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(top: 2),
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
                                          if (adEventCounter! <= 0) {
                                            _showInterstitialAd(context);
                                            readSetting.resetAdEventCounter();
                                          } else {
                                            readSetting.useAdEventCounter();
                                          }
                                      if (newValue ==
                                          translation(context).dayMonthYear) {
                                        readSetting.setDateFormat("dd.MM.yyyy");
                                      } else if (newValue ==
                                          translation(context).monthDayYear) {
                                        readSetting.setDateFormat("MM.dd.yyyy");
                                      } else if (newValue ==
                                          translation(context).yearMonthDay) {
                                        readSetting.setDateFormat("yyyy.MM.dd");
                                      } else {
                                        readSetting.setDateFormat("dd.MM.yyyy");
                                      }
                                      readSetting.setisuseinsert();
                                    },
                                  );
                                },
                                barrierColor: renkler.koyuAraRenk.withOpacity(
                                    0.4),
                                buttonStyleData: ButtonStyleData(
                                  overlayColor: MaterialStatePropertyAll(renkler
                                      .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  height: 34,
                                  width: double.parse(
                                      translation(context).dateFormatSize),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: 250,
                                    width: double.parse(
                                        translation(context).dateFormatSize),
                                    decoration: BoxDecoration(
                                        color: Theme
                                            .of(context)
                                            .highlightColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(15),
                                        thumbColor: MaterialStatePropertyAll(
                                            Theme
                                                .of(context)
                                                .disabledColor))),
                                menuItemStyleData: MenuItemStyleData(
                                  overlayColor: MaterialStatePropertyAll(renkler
                                      .sariRenk), // MENÜ BASILMA RENGİ
                                  height: 34,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                  ),
                                  iconSize: 24,
                                  iconEnabledColor: renkler.arkaRenk,
                                  iconDisabledColor: renkler.arkaRenk,
                                  openMenuIcon: Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    color: renkler.arkaRenk,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: BannerAds(
                        adSize: AdSize.banner,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
          ),
        ),
      ),)
    );
  }
}
