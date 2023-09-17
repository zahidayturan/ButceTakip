import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:butcekontrol/App/base_BKA.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' as intl;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends ConsumerStatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends ConsumerState<IntroductionPage> {
  final controller = PageController();
  final controllerBackUp = PageController();
  final controllerInstall = PageController();
  int skipController = 0;
  @override
  void initState() {
    super.initState();
    checkNotificationStatus();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: [
                helloPage(context),
                PageView(
                    controller: controllerInstall,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      installPage(context),
                      skipPage(context),
                      lastPage(context),
                    ],
                ),
                moneyTypePage(context),
                notificationsPage(context),
                PageView(
                  controller: controllerBackUp,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    backUpPage(context),
                    backUpOpenPage(context),
                  ],
                ),
                assetsPage(context),
                lastPage(context),
              ],
            ),
            Visibility(
              visible: currentPage != 0,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: counterContainer(context, currentPage)),
            )
          ],
        ),
      ),
    );
  }
  int lampCounter = 0;
  Widget lampMode(BuildContext context){
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          lampCounter < 5 ? readSetting.setDarkModeNotBool() : null;
          lampCounter += 1;
          lampCounter == 10 ? lampCounter = 0 : null;
          print(lampCounter);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
          width: 50,
          height: 100,
          padding: darkMode == 0 ?  EdgeInsets.zero : EdgeInsets.only(bottom: 20,right: 0),
          child: Image.asset(
            lampCounter < 5 ?
            darkMode == 0
                ? "assets/icons/lightTheme.png"
                : "assets/icons/darkTheme.png" :
            darkMode == 0
                ? "assets/icons/lightTheme2.png"
                : "assets/icons/darkTheme2.png",
          ),
        )
      ),
    );
  }
  Widget backButton(BuildContext context, String text,int pageMode){
    var readSetting = ref.read(settingsRiverpod);
    var readGglAuth = ref.read(gglDriveRiverpod);
    return SizedBox(
        height: 44,
        child: TextButton(
          onPressed: () async {
            if(pageMode == 0){
              selectedLanguage = null;
              controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }else if(pageMode ==1){
              setState(() {
                skipController = 0;
              });
              controllerInstall.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }else if(pageMode == 2){
              controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }else if(pageMode == 3){
              await readGglAuth.signOutWithGoogle();
              readGglAuth.setAccountStatus(false);
              readSetting.setBackup(false);
              controllerBackUp.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).canvasColor),
            shape: readSetting.Language == "العربية"
                ? MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))))
                : MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)))),
          ),
          child: Row(
            children: [
              Icon(
                readSetting.Language == "العربية"
                    ? Icons.arrow_circle_right_outlined
                    : Icons.arrow_circle_left_outlined,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding:
                EdgeInsets.only(top: 4, left: 4, right: 10),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      height: 1,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ));
  }

  String? selectedLanguage;
  Widget helloPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;
    var language =
        readSetting.Language == 'Turkce' ? "Türkçe" : readSetting.Language;
    List<String> languageList = <String>["Türkçe", "English", "العربية"];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: lampMode(context),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Merhaba",
                      style: TextStyle(
                          fontSize: 40,
                          height: 1,
                          color: darkMode == 0
                              ? renkler.koyuuRenk
                              : language == 'Türkçe'
                                  ? Theme.of(context).disabledColor
                                  : renkler.arkaRenk),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: 40,
                          height: 1,
                          color: darkMode == 0
                              ? renkler.koyuuRenk
                              : language == 'English'
                                  ? Theme.of(context).disabledColor
                                  : renkler.arkaRenk),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "مرحبًا",
                      style: TextStyle(
                          fontSize: 40,
                          height: 1,
                          color: darkMode == 0
                              ? renkler.koyuuRenk
                              : language == 'العربية'
                                  ? Theme.of(context).disabledColor
                                  : renkler.arkaRenk),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                  height: 44,
                  width: size.width * 0.7,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(darkMode == 0
                          ? renkler.arkaRenk
                          : Theme.of(context).secondaryHeaderColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(
                                  width: 2, color: renkler.koyuuRenk))),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Center(
                          child: Text(
                            selectedLanguage ?? translation(context).selectLanguage,
                            style: TextStyle(
                                fontSize: 18,
                                height: 1,
                                color: renkler.koyuuRenk),
                          ),
                        ),
                        items: languageList
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 18,
                                          height: 1,
                                          color: Theme.of(context).canvasColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedLanguage,
                        onChanged: (String? value) {
                          setState(() {
                            if (value == "Türkçe") {
                              readSetting.setLanguage("Turkce");
                              readSetting.setPrefix("TRY");
                            } else if (value == "English") {
                              readSetting.setLanguage(value!);
                              readSetting.setPrefix("USD");
                            } else if (value == "العربية") {
                              readSetting.setLanguage(value!);
                              readSetting.setPrefix("SAR");
                            } else {
                              readSetting.setLanguage("English");
                              readSetting.setPrefix("USD");
                            }
                            readSetting.setisuseinsert();
                            selectedLanguage = value;
                          });
                          controller.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOut);
                        },
                        iconStyleData: const IconStyleData(
                          iconSize: 0,
                        ),
                        //alignment: Alignment.center,
                        dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        )),
                        buttonStyleData: ButtonStyleData(
                          height: 36,
                          width: size.width * 0.7,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          overlayColor:
                              MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: SizedBox(
                width: size.width * 0.5,
                child: Image.asset(
                  "assets/image/icon_BKA/LOGOBKA-4.png",
                  color: Theme.of(context).dialogBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget installPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, translation(context).languageSelection, 0),
              lampMode(context),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).betterExperience,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                  height: 44,
                  width: size.width * 0.7,
                  child: TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Theme.of(context).disabledColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                    child: Text(
                      translation(context).startInstallation,
                      style: TextStyle(fontSize: 18, color: renkler.koyuuRenk, height: 1),
                    ),
                  )),
            ),
          ),
          Align(
            alignment: readSetting.Language == "العربية" ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 80,
              ),
              child: SizedBox(
                  height: 36,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        skipController = 1;
                      });
                      controllerInstall.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).canvasColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          readSetting.Language == "العربية" ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30))) : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30)))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 4),
                      child: Text(
                        translation(context).skipInstallation,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            height: 1
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget skipPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, translation(context).continueInstallation, 1),
              lampMode(context),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).skipInstallationWarning,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                  height: 44,
                  width: size.width * 0.7,
                  child: TextButton(
                    onPressed: () async{
                      controllerInstall.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
                      setState(() {
                        _isLoading = true;
                      });
                      delayedFunction();
                      },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Theme.of(context).disabledColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                    child: Text(
                        translation(context).skip,
                      style: TextStyle(fontSize: 18, color: renkler.koyuuRenk),
                    ),
                  )),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 60,
              ),
              child: SizedBox(
                  height: 36,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String? selectedMoneyType;
  Widget moneyTypePage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;
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

    String getMoneyTypeText() {
      var language = readSetting.Language;
      if (language == 'Turkce') {
        return moneyNameList[0];
      } else if (language == 'English') {
        return moneyNameList[1];
      } else if (language == 'العربية') {
        return moneyNameList[7];
      } else {
        return moneyNameList[2];
      }
    }

    var moneyType = getMoneyTypeText();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, "", 2),
             lampMode(context),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).selectCurrencyForApplication,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                  height: 44,
                  width: size.width * 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Center(
                          child: Text(
                            selectedMoneyType ?? moneyType,
                            style: TextStyle(
                                fontSize: 18,
                                height: 1,
                                fontFamily: 'TL',
                                color: renkler.koyuuRenk),
                          ),
                        ),
                        items: moneyNameList
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 18,
                                          height: 1,
                                          fontFamily: 'TL',
                                          color: renkler.koyuuRenk),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedMoneyType,
                        onChanged: (String? value) {
                          setState(() {
                            if (value == moneyNameList[0]) {
                              readSetting.setPrefix("TRY");
                            } else if (value == moneyNameList[1]) {
                              readSetting.setPrefix("USD");
                            } else if (value == moneyNameList[2]) {
                              readSetting.setPrefix("EUR");
                            } else if (value == moneyNameList[3]) {
                              readSetting.setPrefix("GBP");
                            } else if (value == moneyNameList[4]) {
                              readSetting.setPrefix("KWD");
                            } else if (value == moneyNameList[5]) {
                              readSetting.setPrefix("JOD");
                            } else if (value == moneyNameList[6]) {
                              readSetting.setPrefix("IQD");
                            } else if (value == moneyNameList[7]) {
                              readSetting.setPrefix("SAR");
                            }
                            readSetting.setisuseinsert();
                            selectedMoneyType = value!;
                            calculateAmount(3,emptyList,ref);
                          });
                          //controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
                        },
                        iconStyleData: const IconStyleData(
                          iconSize: 0,
                        ),
                        //alignment: Alignment.center,
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 144,
                            decoration: BoxDecoration(
                              color: renkler.arkaRenk,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            )),
                        buttonStyleData: ButtonStyleData(
                          height: 36,
                          width: size.width * 0.7,
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          overlayColor:
                              MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Align(
            alignment: readSetting.Language == "العربية" ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SizedBox(
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).canvasColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          readSetting.Language == "العربية" ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))) : const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30)))
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Text(
                        translation(context).continueProcessing,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  String? selectedNotification;
  bool isNotificationGranted = false;

  Future<void> checkNotificationStatus() async {
    PermissionStatus status = await Permission.notification.status;
    setState(() {
      isNotificationGranted = status.isGranted;
    });
  }

  int notificationsController = 0;
  Widget notificationsPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    String notificationStatus = isNotificationGranted ? translation(context).on : translation(context).off;

    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, translation(context).currency, 2),
              lampMode(context),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).appNotifications,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  await AppSettings.openAppSettings(
                      type: AppSettingsType.notification);
                  setState(() {
                    notificationsController = 1;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                        height: 44,
                        width: size.width * 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(
                            notificationsController == 0
                                ? notificationStatus
                                : "Ayarlayın",
                            style: TextStyle(
                                height: 1,
                                fontSize: 18,
                                color: renkler.koyuuRenk),
                          )),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).turnOnNotifications,
                    style: TextStyle(
                        fontSize: 20,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: readSetting.Language == "العربية" ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SizedBox(
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).canvasColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          readSetting.Language == "العربية" ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))) : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30)))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Text(
                        translation(context).continueProcessing,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget backUpPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var readGglAuth = ref.read(gglDriveRiverpod);
    //ref.watch(gglDriveRiverpod).RfPageSt;
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, translation(context).notifications, 2),
              lampMode(context),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).backupPreference,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    translation(context).backupYourDataSecurelyViaGoogleAccount,
                    // translation(context).backupYourDataSecurely,
                    style: TextStyle(
                        fontSize: 20,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).disabledColor,
                            backgroundColor: renkler.koyuuRenk,
                          ));
                    },
                  );
                  try{
                    await readGglAuth.signInWithGoogle();
                    //await readGglAuth.checkAuthState(ref);
                    readGglAuth.setAccountStatus(true);
                    readGglAuth.refreshPage();
                    readSetting.setisuseinsert();
                    readSetting.setBackup(true);
                    Navigator.of(context).pop();
                    readSetting.setBackuptimes("Aylık");
                    controllerBackUp.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut);
                  }catch(e){
                    print("Hata var = $e");
                    await readGglAuth.signOutWithGoogle();
                  }
                  setState(() {

                  });
                  /*await readGglAuth.signInWithGoogle();
                  readGglAuth.setAccountStatus(true);
                  readSetting.setBackup(true);*/

                },
                child: SizedBox(
                    height: 44,
                    width: size.width * 0.74,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                            translation(context).signInGoogle,
                        style: TextStyle(
                            height: 1, fontSize: 18, color: renkler.koyuuRenk),
                      )),
                    )),
              ),
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: SizedBox(
                width: size.width * 0.5,
                child: Image.asset(
                  "assets/image/googleDrive.png",
                ),
              ),
            ),
          ),*/
          Align(
            alignment: readSetting.Language == "العربية" ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SizedBox(
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).canvasColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          readSetting.Language == "العربية" ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))) : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30)))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Text(
                        translation(context).skipBackup,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  String? selectedBackUpType;
  Widget backUpOpenPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var readGglAuth = ref.read(gglDriveRiverpod);
    //ref.watch(gglDriveRiverpod).RfPageSt;

    List<String> backUpList = <String>[
      translation(context).dailyBackup,
      translation(context).monthlyBackup,
      translation(context).yearlyBackup,
    ];
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, translation(context).accountSelection, 3),
              lampMode(context),
            ],
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).backupPreference,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: SizedBox(
                      height: 44,
                      width: size.width * 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                            child: Text(
                          readGglAuth.accountStatus != false ? "${readGglAuth.getUserEmail()}" : "",
                          style: TextStyle(
                              height: 1,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor),
                        )),
                      )),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    translation(context).backupFrequency,
                    style: TextStyle(
                        fontSize: 40,
                        height: 1,
                        color: Theme.of(context).canvasColor),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {},
                    child: SizedBox(
                        height: 44,
                        width: size.width * 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Center(
                                    child: Text(
                                      selectedBackUpType ?? translation(context).monthlyBackup,
                                      style: TextStyle(
                                          fontSize: 18,
                                          height: 1,
                                          fontFamily: 'Nexa3',
                                          color: renkler.koyuuRenk),
                                    ),
                                  ),
                                  items: backUpList
                                      .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Center(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 18,
                                            height: 1,
                                            fontFamily: 'Nexa3',
                                            color: renkler.koyuuRenk),
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: selectedBackUpType,
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value == translation(context).dailyBackup) {
                                          readSetting.setBackuptimes("Günlük");
                                      } else if (value == translation(context).monthlyBackup) {
                                          readSetting.setBackuptimes("Aylık");
                                      }
                                      else if (value == translation(context).yearlyBackup){
                                          readSetting.setBackuptimes("Yıllık");
                                      }
                                      else{
                                        readSetting.setBackuptimes("Aylık");
                                      }
                                      selectedBackUpType = value!;
                                    });
                                    //controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
                                  },
                                  iconStyleData: const IconStyleData(
                                    iconSize: 0,
                                  ),
                                  //alignment: Alignment.center,
                                  dropdownStyleData: DropdownStyleData(
                                      maxHeight: 144,
                                      decoration: BoxDecoration(
                                        color: renkler.arkaRenk,
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(10)),
                                      )),
                                  buttonStyleData: ButtonStyleData(
                                    height: 36,
                                    width: size.width * 0.7,
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    overlayColor:
                                    MaterialStatePropertyAll(Theme.of(context).disabledColor),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ),
                              ),),
                        )),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: readSetting.Language == "العربية" ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SizedBox(
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).canvasColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          readSetting.Language == "العربية" ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))) : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30)))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Text(
                        translation(context).continueProcessing,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  final TextEditingController amount = TextEditingController();
  List<String> moneyTypes = ["TRY", "USD", "EUR", "GBP", "KWD", "JOD", "IQD", "SAR"];
  List<Map<String, dynamic>> cardAmountList = [];
  List<Map<String, dynamic>> cashAmountList = [];
  List<Map<String, dynamic>> otherAmountList = [];
  List<Map<String, dynamic>> emptyList = [];
  double cardTotal = 0;
  double cashTotal = 0;
  double otherTotal = 0;
  double emptyTotal = 0;
  var operationMoneyType ;

  void calculateAmount(int menuType,List<Map<String, dynamic>> listName,WidgetRef ref){
    var readCurrency = ref.read(currencyRiverpod);
    var readSetting = ref.read(settingsRiverpod);
    if(menuType ==0){
      cardTotal =0;
      for(int i=0; i<listName.length ; i++){
        double calculated = readCurrency.calculateRealAmount(listName[i]["amount"], listName[i]["currency"], readSetting.Prefix.toString());
        cardTotal = cardTotal + calculated;
      }
    }else if(menuType == 1){
      cashTotal = 0;
      for(int i=0; i<listName.length ; i++){
        double calculated = readCurrency.calculateRealAmount(listName[i]["amount"], listName[i]["currency"], readSetting.Prefix.toString());
        cashTotal = cashTotal + calculated;
      }
    }else if(menuType == 2){
      otherTotal = 0;
      for(int i=0; i<listName.length ; i++){
        double calculated = readCurrency.calculateRealAmount(listName[i]["amount"], listName[i]["currency"], readSetting.Prefix.toString());
        otherTotal = otherTotal + calculated;
      }
    }else if(menuType == 3){
      cardTotal =0;
      cashTotal =0;
      otherTotal =0;
      for(int i=0; i<cardAmountList.length ; i++){
        double calculated = readCurrency.calculateRealAmount(cardAmountList[i]["amount"], cardAmountList[i]["currency"], readSetting.Prefix.toString());
        cardTotal = cardTotal + calculated;
      }
      for(int i=0; i<cashAmountList.length ; i++){
        double calculated = readCurrency.calculateRealAmount(cardAmountList[i]["amount"], cardAmountList[i]["currency"], readSetting.Prefix.toString());
        cashTotal = cashTotal + calculated;
      }
      for(int i=0; i<otherAmountList.length ; i++){
        double calculated = readCurrency.calculateRealAmount(cardAmountList[i]["amount"], cardAmountList[i]["currency"], readSetting.Prefix.toString());
        otherTotal = otherTotal + calculated;
      }
    }else{
      emptyTotal =0;
      print("boş");
    }
  }


  Widget assetsPage(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    var darkMode = readSetting.DarkMode;
    var readCurrency = ref.read(currencyRiverpod);
    var read = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(context, translation(context).accountSelection, 2),
              lampMode(context),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                translation(context).yourAssetStatus,
                style: TextStyle(
                    fontSize: 40,
                    height: 1,
                    color: Theme.of(context).canvasColor),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              translation(context).trackAssets,
              style: TextStyle(
                  fontSize: 18, height: 1, color: Theme.of(context).canvasColor),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              translation(context).startFromZero,
              style: TextStyle(
                  fontSize: 18, height: 1, color: Theme.of(context).canvasColor),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: SizedBox(
                      height: 44,
                      width: size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return amountCalculate(context,translation(context).enterBankAssets,0,cardAmountList);
                            },
                          ).then((_) => setState(() {}));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        child: Text(cardTotal != 0 ? "${translation(context).bank} ${cardTotal.toStringAsFixed(2)} ${readSetting.Prefix!}"
                            :translation(context).enterBankAssets,style: TextStyle(color: renkler.koyuuRenk),)
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: SizedBox(
                      height: 44,
                      width: size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                             return amountCalculate(context,translation(context).enterCashAssets,1,cashAmountList);
                            },
                          ).then((_) => setState(() {}));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        child: Text(cashTotal != 0 ? "${translation(context).cashAsset} ${cashTotal.toStringAsFixed(2)} ${readSetting.Prefix!}"
                              :translation(context).enterCashAssets,style: TextStyle(color: renkler.koyuuRenk),)
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: SizedBox(
                      height: 44,
                      width: size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return amountCalculate(context,translation(context).enterOtherAssets,2,otherAmountList);
                              },
                            ).then((_) => setState(() {}));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Theme.of(context).disabledColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        child: Text(otherTotal != 0 ? "${translation(context).other} ${otherTotal.toStringAsFixed(2)} ${readSetting.Prefix!}"
                            :translation(context).enterOtherAssets,style: TextStyle(color: renkler.koyuuRenk),)
                      )),
                ),
              ),
            ],
          ),
          Text(
            "${translation(context).startingAmount} ${(cardTotal+cashTotal+otherTotal).toStringAsFixed(1)} ${readSetting.Prefix} ",
            style: TextStyle(
                fontSize: 20, height: 1, color: Theme.of(context).canvasColor),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Align(
            alignment: readSetting.Language == "العربية" ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SizedBox(
                  height: 44,
                  child: TextButton(
                    onPressed: () async {
                      String formattedDate = intl.DateFormat('dd.MM.yyyy').format(DateTime.now());
                      for(int i = 0 ; i < cardAmountList.length; i++){
                        final newinfo = SpendInfo(
                          "Gelir",
                          "null",
                          "Kart",
                          0,
                          cardAmountList[i]["amount"],
                          "",
                          "null",
                          "null",
                          "null",
                          "null",
                          formattedDate,
                          cardAmountList[i]["currency"]+"1",
                          "",
                          readCurrency.calculateRealAmount(
                              cardAmountList[i]["amount"],
                              cardAmountList[i]["currency"],
                              readSetting.Prefix!),
                          "",
                          "",
                        );
                        print(newinfo.toMap());
                        await SQLHelper.createItem(newinfo);
                      }
                      for(int i = 0 ; i < cashAmountList.length; i++){
                        final newinfo = SpendInfo(
                          "Gelir",
                          "null",
                          "Nakit",
                          0,
                          cashAmountList[i]["amount"],
                          "",
                          "null",
                          "null",
                          "null",
                          "null",
                          formattedDate,
                          cashAmountList[i]["currency"]+"1",
                          "",
                          readCurrency.calculateRealAmount(
                              cashAmountList[i]["amount"],
                              cashAmountList[i]["currency"],
                              readSetting.Prefix!),
                          "",
                          "",
                        );
                        print(newinfo.toMap());
                        await SQLHelper.createItem(newinfo);
                      }
                      for(int i = 0 ; i < otherAmountList.length; i++){
                        final newinfo = SpendInfo(
                          "Gelir",
                          "null",
                          "Diğer",
                          0,
                          otherAmountList[i]["amount"],
                          "",
                          "null",
                          "null",
                          "null",
                          "null",
                          formattedDate,
                          otherAmountList[i]["currency"]+"1",
                          "",
                          readCurrency.calculateRealAmount(
                              otherAmountList[i]["amount"],
                              otherAmountList[i]["currency"],
                              readSetting.Prefix!),
                          "",
                          "",
                        );
                        print(newinfo.toMap());
                        await SQLHelper.createItem(newinfo);
                      }
                      controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                      setState(() {
                        _isLoading = true;
                      });
                      delayedFunction();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).canvasColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          readSetting.Language == "العربية" ? const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))) : const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30)))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Text(
                        translation(context).complete,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget amountCalculate(BuildContext context,String title,int menuType,List<Map<String, dynamic>> listName){
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var readCurrency = ref.read(currencyRiverpod);
    var size = MediaQuery.of(context).size;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Theme.of(context).primaryColor,
          shadowColor: Colors.black54,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontFamily: "Nexa4",
                                fontSize: 21),
                          ),
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icons/remove.png",
                                  height: 16,
                                  width: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                                iconSize: 24,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context).canvasColor
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 4,left: 4,right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(translation(context).amount,style: TextStyle(color: Theme.of(context).canvasColor,fontFamily: "Nexa4",height: 1),),
                                    SizedBox(
                                      height: 30,
                                      width: 130,
                                      child: TextFormField(
                                          onTap: () {
                                            //_amount.clear();
                                          },
                                          style: TextStyle(
                                            color: Theme.of(context).canvasColor,
                                            fontSize: 17,
                                            fontFamily: 'Nexa3',
                                          ),
                                          controller: amount,
                                          autofocus: false,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d{0,7}(\.\d{0,1})?'),
                                            )
                                          ],
                                          textAlign: TextAlign.center,
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              hintText: "00.00",
                                              hintStyle: TextStyle(
                                                color: Theme.of(context).canvasColor,
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(
                                                  top: 6))),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(translation(context).currency,style: TextStyle(color: Theme.of(context).canvasColor,fontFamily: "Nexa4",height: 1)),
                                    SizedBox(
                                      height: 30,
                                      width: 80,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Center(
                                            child: Text(
                                              operationMoneyType ?? translation(context).select,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  height: 1,
                                                  fontFamily: 'Nexa3',
                                                  color: Theme.of(context).canvasColor),
                                            ),
                                          ),
                                          items: moneyTypes
                                              .map((String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Center(
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    height: 1,
                                                    fontFamily: 'Nexa3',
                                                    color: Theme.of(context).canvasColor),
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                          value: operationMoneyType,
                                          onChanged: (String? value) {
                                            setState(() {
                                              operationMoneyType = value!;
                                            });
                                            //controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
                                          },
                                          iconStyleData: const IconStyleData(
                                            iconSize: 0,
                                          ),
                                          //alignment: Alignment.center,
                                          dropdownStyleData: DropdownStyleData(
                                              maxHeight: 144,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(10)),
                                              )),
                                          buttonStyleData: ButtonStyleData(
                                            height: 36,
                                            width: size.width * 0.7,
                                          ),
                                          menuItemStyleData: MenuItemStyleData(
                                            overlayColor:
                                            MaterialStatePropertyAll(Theme.of(context).disabledColor),
                                            padding: const EdgeInsets.all(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState((){
                                    operationMoneyType = operationMoneyType ?? readSetting.Prefix.toString();
                                    listName.add({
                                      'amount': double.parse(amount.text),
                                      'currency': operationMoneyType,
                                    });
                                    amount.clear();
                                    operationMoneyType = null;
                                    calculateAmount(menuType,listName,ref);
                                  });
                                  this.setState((){});
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: renkler.yesilRenk
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: renkler.yaziRenk,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height : 100,
                    width: size.width * 0.8,
                    child: ListView.builder(
                      itemCount: listName.length,
                      itemBuilder: (ctx, index) {
                        return SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width : 130,
                                child: Center(
                                  child: Text(
                                    listName[index]['amount'].toString(),style: TextStyle(fontSize: 16,fontFamily: "Nexa3"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width : 80,
                                child: Center(
                                  child: Text(
                                      '${listName[index]['currency']}',style: TextStyle(fontSize: 16,fontFamily: "Nexa3")
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: renkler.kirmiziRenk
                                  ),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: renkler.yaziRenk,
                                    size: 16,
                                  ),
                                ),
                                onTap: () {
                                  listName.removeAt(index);
                                  calculateAmount(menuType,listName,ref);
                                  this.setState(() {
                                  });
                                  setState((){
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: SizedBox(
                      width: size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: listName.isNotEmpty,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  listName.clear();
                                  if(menuType ==0){
                                    cardTotal =0;
                                  }else if(menuType == 1){
                                    cashTotal = 0;
                                  }else if(menuType == 2){
                                    otherTotal = 0;
                                  }else{
                                    emptyTotal =0;
                                    print("boş");
                                  }
                                });
                                this.setState(() {

                                });
                              },
                              child: Container(
                                height: 26,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).shadowColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Text(
                                      translation(context).deleteAll2,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 15,
                                          fontFamily: 'Nexa3'),
                                    )),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: listName.isNotEmpty,
                            child: InkWell(
                              onTap: () {
                                setState((){
                                  if(menuType ==0){
                                    cardTotal = 0;
                                  }else if(menuType == 1){
                                    cashTotal =0;
                                  }else if(menuType == 2){
                                    otherTotal =0;
                                  }else{
                                    emptyTotal =0;
                                  }
                                });
                                calculateAmount(menuType,listName,ref);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Text(
                                      translation(context).okStatistics,
                                      style: TextStyle(
                                          color: renkler.arkaRenk,
                                          fontSize: 15,
                                          fontFamily: 'Nexa3'),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isLoading = true;
  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("showBTA", true);
    final bool? showBTA = prefs.getBool("showBTA");
    print(showBTA);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => base_BKA(showBTA: true, appInfo:{"appInfoString": "normal", "version": "1.0.0"}))
    );
  }

  Widget lastPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode == 0
              ? const ExactAssetImage(
                  "assets/image/introductionBackground.png",
                )
              : const ExactAssetImage(
                  "assets/image/introductionBackground2.png",
                ),
          opacity: 0.06,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: lampMode(context),
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        translation(context).budgetTrackOnlyTurkish,
                        style: TextStyle(
                            fontSize: 32,
                            height: 1,
                            color: Theme.of(context).secondaryHeaderColor,
                            fontFamily: "Nexa4"),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        translation(context).thankYouMessage,
                        style: TextStyle(
                            fontSize: 32,
                            height: 1,
                            color: Theme.of(context).canvasColor),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text(
            translation(context).appPreparationMessage,
            style: TextStyle(
                fontSize: 20, height: 1, color: Theme.of(context).canvasColor),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: _isLoading == true
                ? CircularProgressIndicator(
                    color: Theme.of(context).disabledColor,
                    backgroundColor: renkler.koyuuRenk,
                  )
                : null,
          ),
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool("showBTA", true);
              final bool? showBTA = prefs.getBool("showBTA");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const base_BKA(showBTA: true,appInfo:{"appInfoString": "normal", "version": "1.0.0"})));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 10,
                      offset: const Offset(5, 5))
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/image/icon_BKA/İKON.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget counterContainer(BuildContext context, int pageCount) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Visibility(
        visible: skipController == 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: pageCount != 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).canvasColor),
                ),
              ),
            ),
            Visibility(
              visible: pageCount != 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: pageCount == 1 ? 42 : 14,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: pageCount == 1
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).canvasColor),
                ),
              ),
            ),
            Visibility(
              visible: pageCount != 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: pageCount == 2 ? 42 : 14,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: pageCount == 2
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).canvasColor),
                ),
              ),
            ),
            Visibility(
              visible: pageCount != 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: pageCount == 3 ? 42 : 14,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: pageCount == 3
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).canvasColor),
                ),
              ),
            ),
            Visibility(
              visible: pageCount != 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: pageCount == 4 ? 42 : 14,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: pageCount == 4
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).canvasColor),
                ),
              ),
            ),
            Visibility(
              visible: pageCount != 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: pageCount == 5 ? 42 : 14,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: pageCount == 5
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).canvasColor),
                ),
              ),
            ),
            Visibility(
              visible: pageCount == 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Fezai Tech",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontFamily: "Nexa3",
                            height: 1),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: pageCount == 6 ? 192 : 0,
                      height: 14,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
