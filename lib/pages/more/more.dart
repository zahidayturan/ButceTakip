import 'package:butcekontrol/Pages/more/communicate.dart';
import 'package:butcekontrol/app/information_app.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/pages/more/assets_page.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:butcekontrol/pages/more/settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../riverpod_management.dart';
import 'Help/help_page.dart';
import 'password_splash.dart';
import 'backup.dart';

class More extends ConsumerWidget {
  More({Key? key}) : super(key: key);
  final renkler = CustomColors();
  /*
  var buton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
          label: "Total" ,
          amount: "10.0",
          status: PaymentItemStatus.final_price
      ),
    ],
    width: double.infinity,
    type: GooglePayButtonType.subscribe,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => print('Payment Result ${result}'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );
   */
  Future<void> shareButceTakip(BuildContext context) async {
    await FlutterShare.share(
        title: translation(context).download,
        text: translation(context).heyDoYouWantManage,
        linkUrl: 'https://play.google.com/store/apps/details?id=com.fezaitech.butcetakip',
        chooserTitle: 'Bütçe Takip',
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size;
    ref.watch(settingsRiverpod).isuseinsert;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          //backgroundColor: const Color(0xffF2F2F2),
          appBar: AppBarForPage(title: translation(context).otherActivitiesTitle),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(  // 9 adet butonun bulundugu yer, her uc buton bir Row`a yerlestirildi.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly, conteınerlar fixed sizes oldukları için bu kodun bir etkisi olmuyor
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const Settings(),
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.settings, color: renkler.arkaRenk, size: 35),
                                  Text(translation(context).settings,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => assetsPage(),
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 4.5 + size.width/15,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: Theme.of(context).disabledColor,
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).disabledColor
                                  ),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.wallet_rounded, color: renkler.koyuuRenk, size: 35),
                                        Expanded(child: Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Text(translation(context).assets,style: TextStyle(color: renkler.koyuuRenk,fontSize: 16,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Text(translation(context).yourNetAsset,style: TextStyle(color: renkler.koyuuRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width / 15,),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if(readSetting.isPassword == 1 && readSetting.Password != "null"){
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ref.read(settingsRiverpod).isPassword == 1
                                      ? Icon(Icons.lock, color: renkler.arkaRenk, size: 35)
                                      : Icon(Icons.lock_open, color: renkler.arkaRenk, size: 35),
                                  Text(translation(context).loginPassword,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () async{
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.download, color: renkler.arkaRenk, size: 35),
                                  Text(translation(context).downloadData,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () {
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => communicate()));
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const Communicate(),
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.message, color: renkler.arkaRenk, size: 35),
                                  Text(translation(context).contactUs,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width / 15),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const HelpCenter(),
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Container(
                              height: size.height / 18,
                              width: size.height / 6+size.width/30,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).disabledColor
                                  ),
                                  color: Theme.of(context).disabledColor,
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(15))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  children: [
                                    Icon(Icons.question_mark, color: renkler.koyuuRenk, size: 26),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.only(top:6.0),
                                      child: Text(translation(context).help,style: TextStyle(color: renkler.koyuuRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1,),textAlign: TextAlign.center,),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () async {

                              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                              print('Phone Model: ${androidInfo.manufacturer}/${androidInfo.model} \nAndroid Version: ${androidInfo.version.release} \n Language: ${readSetting.Language} \nVersion: ${informationApp.version}\n\n${translation(context).write}');
                              String? encodeQueryParameters(Map<String, String> params) {
                                return params.entries
                                    .map((MapEntry<String, String> e) =>
                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                    .join('&');
                              }
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: 'fezaitech@gmail.com',
                                query: encodeQueryParameters(<String, String>{
                                  'subject': 'Bütçe Takip Öneri/Hata Bildirimi',
                                  'body' : 'Phone Model: ${androidInfo.manufacturer}/${androidInfo.model} \nAndroid Version: ${androidInfo.version.release} \n Language: ${readSetting.Language} \nVersion: ${informationApp.version}\n\n${translation(context).write}'

                                }),
                              );
                              try{
                                await launchUrl(emailLaunchUri);
                              }catch(e){
                                print(e.toString());
                              }
                            },
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Container(
                              height: size.height / 18,
                              width: size.height / 6+size.width/30,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.mail_outline_rounded, color: renkler.yaziRenk, size: 26),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.only(top:6.0),
                                      child: Text(translation(context).feedback,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width / 30),
                      Row(
                        children: [
                          InkWell(
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Container(
                              height: size.height / 18,
                              width: size.height / 6+size.width/30,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.star_rate_rounded, color: renkler.arkaRenk, size: 26),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.only(top:6.0),
                                      child: Text(translation(context).evaluate,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1,),textAlign: TextAlign.center,),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: ()  {
                              shareButceTakip(context);
                            },
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Container(
                              height: size.height / 18,
                              width: size.height / 6+size.width/30,
                              decoration: BoxDecoration(
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ],
                                  color: renkler.koyuuRenk,
                                  border: Border.all(color: renkler.koyuAraRenk),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.share, color: renkler.yaziRenk, size: 26),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.only(top:6.0),
                                      child: Text(translation(context).recommend,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/image/icon_BKA/LOGOBKA-4.png",
                        height: 70,
                      ),
                      const SizedBox(height: 8),
                      TextMod("${translation(context).version}  ${informationApp.version}", Theme.of(context).canvasColor, 13),
                      const SizedBox(height: 2),
                      TextMod("FezaiTech", Theme.of(context).canvasColor, 13),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}