import 'package:butcekontrol/UI/check_user_delete.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:butcekontrol/pages/more/Help/help_backup.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:butcekontrol/utils/cvs_converter.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../classes/app_bar_for_page.dart';
import '../../classes/nav_bar.dart';
import '../../riverpod_management.dart';

class AppearanceSettings extends ConsumerStatefulWidget {
  const AppearanceSettings({Key? key}) : super(key: key);

  @override
  ConsumerState<AppearanceSettings> createState() => _AppearanceSettingsState();
}

class _AppearanceSettingsState extends ConsumerState<AppearanceSettings> {
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  Future <ListResult> ?futureFiles ;
  int  backupPushCount = 5 ;

  @override
  void initState() {
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    if (adCounter! < 1) {
      _interstitialAdManager.loadInterstitialAd();
    } else {
    }
    super.initState();
  }
  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: renkler.koyuuRenk,
        child: SafeArea(
          child: Scaffold(
            //backgroundColor: const Color(0xffF2F2F2),
            bottomNavigationBar: const NavBar(),
            appBar: AppBarForPage(title: "Görünüm Ayarları"),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  addDataAppearance()
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget addDataAppearance(){
    var readSetting = ref.watch(settingsRiverpod);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).indicatorColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).scaffoldBackgroundColor
              ),
              child: Center(child: getLineText("Veri Ekleme - Düzenleme Sayfası\nGörünüm Tercihi", Theme.of(context).canvasColor, 15,TextAlign.center))),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: InkWell(
                onTap: () {
                  readSetting.setAddDataType(0);
                  readSetting.setisuseinsert();
                  ref.read(addDataRiverpod).pageViewController.animateToPage(readSetting.addDataType!, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Visibility(
                            visible : readSetting.addDataType == 0,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  color: Theme.of(context).disabledColor
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8,bottom: 4),
                          child: getLineText("Tablo Görünümü", Theme.of(context).canvasColor, 14, TextAlign.center),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                        decoration: BoxDecoration(
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(0, 4),
                              )
                            ],
                            color: readSetting.addDataType == 0 ? Theme.of(context).disabledColor : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Row(
                              children: [
                                Expanded(child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 0 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                                SizedBox(width: 8,),
                                Expanded(child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 0 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Row(
                              children: [
                                Expanded(child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 0 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Row(
                              children: [
                                Expanded(flex:2,child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 0 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                                SizedBox(width: 8,),
                                Expanded(flex:1,child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 0 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              )),
              SizedBox(width: 12,),
              Expanded(child: InkWell(
                onTap: () {
                  readSetting.setAddDataType(1);
                  readSetting.setisuseinsert();
                  ref.read(addDataRiverpod).pageViewController.animateToPage(readSetting.addDataType!, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Visibility(
                            visible : readSetting.addDataType == 1,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).disabledColor
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8,bottom: 4),
                          child: getLineText("Liste Görünümü", Theme.of(context).canvasColor, 15, TextAlign.center),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 4),
                            )
                          ],
                          color: readSetting.addDataType == 1 ? Theme.of(context).disabledColor : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Row(
                              children: [
                                Expanded(child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 1 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Row(
                              children: [
                                Expanded(child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 1 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: Row(
                              children: [
                                Expanded(child: getDecoratedBox(radius: BorderRadius.all(Radius.circular(5)),height: 20,boxColor: readSetting.addDataType == 1 ? renkler.koyuuRenk : Theme.of(context).indicatorColor,)),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLineText(String text,Color textColor,double size,TextAlign align,{String? fontFamily,FontWeight? weight , Color? backgroundColor}){
    return Text(
      text,style: TextStyle(
        color: textColor,
        height: 1,
        fontFamily: fontFamily ?? "Nexa3",
        fontSize: size,
        fontWeight: weight ?? FontWeight.normal,
        backgroundColor: backgroundColor
    ),
      textAlign: align,
    );
  }

  Widget getDecoratedBox({double? width,double? height,BorderRadiusGeometry? radius,Color? boxColor,Widget? child,EdgeInsetsGeometry? padding,BoxBorder? border}){
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: radius,
              color: boxColor,
              border: border
          ),
          child: child,
        ),
      ),
    );
  }


}



