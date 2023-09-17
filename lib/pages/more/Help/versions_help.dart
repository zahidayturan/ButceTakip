import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VersionsHelp extends ConsumerStatefulWidget {
  const VersionsHelp({Key? key}) : super(key: key);

  @override
  ConsumerState<VersionsHelp> createState() => _VersionsHelpState();
}

class _VersionsHelpState extends ConsumerState<VersionsHelp> {

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size ;
    return SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: translation(context).helpTitle2),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                              child: Icon(
                                size: 20,
                                Icons.new_releases_outlined,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              translation(context).version2,
                              style: TextStyle(
                                fontFamily: "Nexa4",
                                fontSize: 24,
                                height: 1,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              translation(context).budgetUpdate
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15,fontFamily: "Nexa4"),textAlign: TextAlign.start,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      Text(
                        translation(context).implementedSuggestions
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    border: Border.all(
                        width: 1,
                        color: Theme.of(context).highlightColor,
                        strokeAlign: BorderSide.strokeAlignOutside
                    ),
                    boxShadow: darkMode == 1 ? [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      )
                    ] : [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 2,
                          offset: const Offset(0, 2)
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4,left: 18,right: 18),
                        child: Text(
                          translation(context).whatsNewVersion,
                          style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontFamily: "Nexa4",
                              fontSize: 23
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(
                          "assets/image/LogoBkaShort.png",
                          height: 36,
                          width: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16
                  ),
                  child: Column(
                    children: [
                      buildText(context, translation(context).languageSupport, translation(context).yeniNew, Icons.language_rounded, 0, darkMode!, translation(context).supportedLanguages),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).currencies, translation(context).yeniNew, Icons.currency_lira_rounded, 0, darkMode!, translation(context).supportedCurrencies),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).exchangeSystem, translation(context).yeniNew, Icons.currency_exchange_rounded, 0, darkMode!, translation(context).exchangeSystemDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).currencyConverter, translation(context).yeniNew, Icons.currency_pound_rounded, 0, darkMode!, translation(context).currencyConverterDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).darkMode, translation(context).yeniNew, Icons.dark_mode_outlined, 0, darkMode!, translation(context).darkModeDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).categories, translation(context).update, Icons.category_outlined, 1, darkMode!, translation(context).categoriesDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).activityCustomize, translation(context).yeniNew, Icons.dashboard_customize_outlined, 0, darkMode!, translation(context).activityCustomizeDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).newBackupSystem, translation(context).yeniNew, Icons.backup_outlined, 0, darkMode!, translation(context).backupSystemDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).search, translation(context).yeniNew, Icons.search_rounded, 0, darkMode!, translation(context).searchDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).myAssetsPage, translation(context).yeniNew, Icons.wallet_rounded, 0, darkMode!, translation(context).myAssetsPageDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).installation, translation(context).yeniNew, Icons.phonelink_setup_rounded, 0, darkMode!, translation(context).installationDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).statisticsImprovements, translation(context).update, Icons.equalizer_rounded, 1, darkMode!, translation(context).statisticsImprovementsDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).interfaceImprovements, translation(context).update, Icons.settings_accessibility_rounded, 1, darkMode!, translation(context).interfaceImprovementsDescription),
                      const SizedBox(height: 14,),
                      buildText(context, translation(context).newSettings, translation(context).yeniNew, Icons.settings_rounded, 0, darkMode!, translation(context).newSettingsDescription),
                      const SizedBox(height: 14,),
                      SizedBox(
                        width: size.width*0.4,
                        child: Image.asset(
                            "assets/image/icon_BKA/LOGOBKA-4.png",
                          color: darkMode == 0 ? renkler.sariRenk : renkler.arkaRenk,
                        ),
                      ),
                    ],
                  ),
                ),
                helpFooter(context)
              ],
            ),
          ),
        )
    );
  }
}

Widget buildText(BuildContext context,String title1, String title2,IconData iconName, int title2Mode, int darkMode, String bodyText){
  CustomColors renkler = CustomColors();
  return Column(
    children: [
      Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: const Offset(0, 2)
                  )
                ]
            ),
            child: Icon(
              size: 16,
              iconName,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 6,top: 4),
            child: Text(
              title1
              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).highlightColor,
                boxShadow: darkMode == 1 ? [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ] : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: const Offset(0, 2)
                  )
                ],
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 6,top: 4),
            child: Text(
              title2
              ,style: TextStyle(color: title2Mode == 0 ? renkler.yesilRenk : Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 15,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          bodyText
          ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 14),textAlign: TextAlign.justify,
        ),
      ),
    ],
  );
}
