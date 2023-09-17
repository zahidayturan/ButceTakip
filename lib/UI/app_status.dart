import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStatus extends ConsumerStatefulWidget {
  final String status;
  const AppStatus({Key? key,required this.status}) : super(key: key);

  @override
  ConsumerState<AppStatus> createState() => _AppStatusState();
}

class _AppStatusState extends ConsumerState<AppStatus> {

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: helloPage(context)
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
            lampCounter < 10 ? readSetting.setDarkModeNotBool() : null;
            lampCounter += 1;
            lampCounter == 15 ? lampCounter = 0 : null;
            print(lampCounter);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
            width: 50,
            height: 100,
            padding: darkMode == 0 ?  EdgeInsets.zero : EdgeInsets.only(bottom: 20,right: 0),
            child: Image.asset(
              lampCounter < 10 ?
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

  String? selectedLanguage;
  Widget helloPage(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var language = readSetting.Language == 'Turkce' ? "Türkçe" : readSetting.Language;

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
                      widget.status == "care" ?  translation(context).care1 : translation(context).update1,
                      style: TextStyle(
                          fontSize: 44,
                          height: 1,
                          fontFamily: "Nexa4",
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).secondaryHeaderColor),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.status == "care" ?  translation(context).care2 : translation(context).update2,
                      style: TextStyle(
                          fontSize: 32,
                          height: 1,
                          fontFamily: "Nexa3",
                          color: Theme.of(context).canvasColor),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
          Column(
            children: [
              Text(
                widget.status == "care" ?  translation(context).care3 : "",
                style: TextStyle(
                    fontSize: 22,
                    height: 1,
                    fontFamily: "Nexa4",
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).canvasColor),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: widget.status == "update",
                child: InkWell(
                  child:
                      Text(
                        translation(context).update3,
                        style: const  TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontFamily: "Nexa3"
                          ),
                        ),
                  onTap: () {
                    final appId = 'com.fezaitech.butcetakip';
                    final url = Uri.parse(
                        "market://details?id=$appId"
                    );
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  widget.status == "care" ?  "fezaitech@gmail.com" : "",
                  style: TextStyle(
                      fontSize: 22,
                      height: 1,
                      fontFamily: "Nexa3",
                      color: Theme.of(context).canvasColor),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
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
                  width: 192,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).disabledColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
