 import 'package:butcekontrol/UI/password_forget.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/more/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod_management.dart';

class PasswordSplash extends ConsumerStatefulWidget {
  final String ?mode;
  const PasswordSplash({Key? key, this.mode}) : super(key: key);

  @override
  ConsumerState<PasswordSplash> createState() => _PasswordSplashState();
}

class _PasswordSplashState extends ConsumerState<PasswordSplash> {
  bool num1 = false;
  bool num2 = false;
  bool num3 = false;
  bool num4 = false;
  List <String> password1list = [];
  String password1 = "" ;
  int abuzer = 0;
  String abuzerHesapla(BuildContext context){
    if(abuzer == 0){
      return translation(context).enterThePasscode;/// giris kodunu giriniz
    }else if(abuzer == 1){
      return  translation(context).wrongPassword;///yanlis sifre girdiniz
    }else{
      return translation(context).warning;
    }
  }
  String errorText = "" ;
  int ?Claim  ;
  bool security = false ;
  CustomColors renkler =  CustomColors();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async  => widget.mode == "admin" ? true : false,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: const Color(0xffF2F2F2),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  widget.mode == "admin"
                  ?Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                              Icons.arrow_back,
                            color: renkler.koyuuRenk,
                            size: 35,
                          )
                      ),
                      const SizedBox(width: 20),
                      Text(
                        translation(context).goBack,
                        style: TextStyle(
                          color: renkler.koyuuRenk,
                          fontSize: 20,
                          fontFamily: "Nexa2"
                        ),
                      )
                    ],
                  )
                  :SizedBox(height : size.height * .04),
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: size.height/15) ,
                      Text(
                        abuzerHesapla(context),
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontFamily: "Nexa4"
                        ),
                      ),
                    SizedBox(height: size.height/20) ,
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color: num1 ? Theme.of(context).disabledColor : const Color(0xffE2E1E1),
                                ),
                              )
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color: num2 ? Theme.of(context).disabledColor : const Color(0xffE2E1E1),
                                ),
                              )
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color: num3 ? Theme.of(context).disabledColor : const Color(0xffE2E1E1),
                                ),
                              )
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  color: num4 ? Theme.of(context).disabledColor : const Color(0xffE2E1E1),
                                ),
                              )
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon : const Icon(Icons.backspace),
                            onPressed: () {
                                if(num1){
                                  password1list.removeLast();
                                }
                                if(num3){
                                  setState(() {
                                    num3 = false;
                                  });
                                }else if(num2){
                                  setState(() {
                                    num2 = false;
                                  });
                                }else if(num1){
                                  setState(() {
                                    num1 = false ;
                                  });
                                }
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height/30) ,
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buton(context, "1"),
                                buton(context, "2"),
                                buton(context, "3"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buton(context, "4"),
                                buton(context, "5"),
                                buton(context, "6"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buton(context, "7"),
                                buton(context, "8"),
                                buton(context, "9"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buton(context, "0"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed:() {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.vertical(
                                          top: Radius.circular(
                                              25))),
                                  backgroundColor:
                                  const Color(0xff0D1C26),
                                  builder: (context) {
                                    //ref.watch(databaseRiverpod).updatest;
                                    // genel bilgi sekmesi açılıyor.
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                      child: SizedBox(
                                        height: 220,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context).forgotPassword,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontFamily: "Nexa2"
                                                  ),
                                                ),
                                                DecoratedBox(
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(40),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    icon: Icon(
                                                      Icons.clear_rounded,
                                                      size: 30,
                                                      color: renkler.koyuuRenk,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context).disablePasswordParagraph,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: renkler.arkaRenk,
                                                  ),
                                                ),
                                                const SizedBox(height: 25),

                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).pop();
                                                      showModalBottomSheet(
                                                          context:context ,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius.circular(
                                                                      25))),
                                                          backgroundColor:
                                                          const Color(0xff0D1C26),
                                                          builder: (context) {
                                                            return const PasswordForget();
                                                          },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 80,
                                                      color: renkler.arkaRenk,
                                                      child: Center(
                                                        child: Text(
                                                          translation(context).continueProcessing,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: renkler.koyuuRenk
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                translation(context).forgotPassword,
                                style: const TextStyle(
                                  fontFamily: "Nexa4"
                                ),
                              )
                          ),
                        ],
                      ),
                  ],
                ),
              ],
          ),
            ),
        ),
      ),
      )
    );
  }
  void temizle(){
    setState(() {
      num1 = false;
      num2 = false;
      num3 = false;
      num4 = false;
    });
  }
  Widget buton(BuildContext context,String num ){
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return SizedBox(
      height: size.height / 9.5,
      width: size.height / 9.5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Container(
          color: const Color(0xffE2E1E1),
          child: Center(
            child: SizedBox(
              height: size.height / 12,
              width:  size.height / 12,
              child: InkWell(
                onTap: () {
                  if (num1 == false) {
                    password1list.add(num);
                    setState(() {
                      num1 = true ;
                    });
                  }else if(num2 == false){
                    password1list.add(num);
                    setState(() {
                      num2 = true;
                    });
                  }else if(num3  == false){
                    password1list.add(num);
                    setState(() {
                      num3 = true;
                    });
                  }else if(num4 == false){
                    setState(() {
                      password1 = "" ;
                    });
                    password1list.add(num);
                    if(password1list.length == 4) {
                      for (var i = 0; i < password1list.length ; i++) {
                        password1 = password1 + password1list[i];
                      }
                      print("ps1 = $password1");
                      if (password1 == ref.read(settingsRiverpod).Password ) {
                        setState(() {
                          password1list.clear();
                          ref.read(settingsRiverpod).setStatus(true);
                          Navigator.of(context).pop();
                          ref.read(settingsRiverpod).useSecurityClaim(false);
                          /*
                          if(widget.mode == "admin"){
                            Navigator.of(context).pop();
                            print("POP oldu");
                          }

                           */
                        });
                        widget.mode == "admin"
                            ?Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 1),
                            pageBuilder: (context, animation, nextanim) => const PasswordPage(),
                            reverseTransitionDuration: const Duration(milliseconds: 1),
                            transitionsBuilder: (context, animation, nexttanim, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        )
                            :null;
                        temizle();
                      } else {
                        temizle();
                        password1list.clear();
                        setState(() {
                          abuzer = 1;
                          ref.read(settingsRiverpod).setStatus(false);
                        });
                      }
                    }
                  }
                },
                child: Center(
                  child: Text(
                    num,
                    style: TextStyle(
                        color: renkler.koyuuRenk,
                        fontSize: 25,
                        fontFamily: "Nexa2"
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
