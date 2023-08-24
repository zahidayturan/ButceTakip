import 'package:butcekontrol/Pages/more/communicate.dart';
import 'package:butcekontrol/app/information_app.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/pages/more/assets_page.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:butcekontrol/pages/more/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:pay/pay.dart';
import '../../riverpod_management.dart';
import '../../utils/payment_config.dart';
import 'Help/help_page.dart';
import 'password_splash.dart';
import 'backup.dart';

class More extends ConsumerWidget {
  More({Key? key}) : super(key: key);
  final renkler = CustomColors();
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSetting = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    //var readNavBar = ref.read(botomNavBarRiverpod);
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
                                  color: renkler.koyuuRenk,
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).canvasColor
                                  ),
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
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).canvasColor
                                  ),
                                  color: renkler.koyuuRenk,
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.question_mark, color: renkler.arkaRenk, size: 35),
                                  Text(translation(context).help,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1,),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
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
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).canvasColor
                                  ),
                                  color: renkler.koyuuRenk,
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
                        ],
                      ),

                      SizedBox(height: size.width / 15,),

                      Row(
                        children: [
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
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).canvasColor
                                  ),
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.wallet, color: renkler.yaziRenk, size: 35),
                                  Text(translation(context).assets,style: TextStyle(color: renkler.yaziRenk,fontSize: 13,fontFamily: 'Nexa3',height: 1),maxLines: 2,textAlign: TextAlign.center,),
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
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).canvasColor
                                  ),
                                  color: renkler.koyuuRenk,
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
                                  color: renkler.koyuuRenk,
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).canvasColor
                                  ),
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