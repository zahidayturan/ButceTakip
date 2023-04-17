import 'package:butcekontrol/Pages/more/Password.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../riverpod_management.dart';

class passwordSplash extends ConsumerStatefulWidget {
  final String ?mode;
  const passwordSplash({Key? key, this.mode}) : super(key: key);

  @override
  ConsumerState<passwordSplash> createState() => _passwordSplashState();
}

class _passwordSplashState extends ConsumerState<passwordSplash> {
  bool num1 = false;
  bool num2 = false;
  bool num3 = false;
  bool num4 = false;
  List <String> password1list = [];
  String Password1 = "" ;
  String info = "Giriş kodunuzu giriniz.";
  bool security = false ;
  CustomColors renkler =  CustomColors();
  @override
  Widget build(BuildContext context) {
    String? Password2 = ref.read(settingsRiverpod).Password ;
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async  => widget.mode == "admin" ? true : false,
      child: Container(
        color: renkler.koyuuRenk,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffF2F2F2),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
                      SizedBox(width: 20),
                      Text(
                        "Vazgeç",
                        style: TextStyle(
                          color: renkler.koyuuRenk,
                          fontSize: 20,
                          fontFamily: "Nexa2"
                        ),
                      )
                    ],
                  )
                  :SizedBox(),
                  SizedBox(height: size.height/60),
                  Column(
                    mainAxisAlignment:  MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: size.height/15) ,
                      Text(
                        "$info",
                        style: TextStyle(
                            color: renkler.koyuuRenk,
                            fontFamily: "Nexa4"
                        ),
                      ),
                    SizedBox(height: size.height/20) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: Container(
                                color: num1 ? Colors.black : Color(0xffE2E1E1),
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: Container(
                                color: num2 ? Colors.black : Color(0xffE2E1E1),
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: Container(
                                color: num3 ? Colors.black : Color(0xffE2E1E1),
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: Container(
                                color: num4 ? Colors.black : Color(0xffE2E1E1),
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon : Icon(Icons.backspace),
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
                    SizedBox(height: size.height/30) ,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Buton(context, "1"),
                              Buton(context, "2"),
                              Buton(context, "3"),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Buton(context, "4"),
                              Buton(context, "5"),
                              Buton(context, "6"),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Buton(context, "7"),
                              Buton(context, "8"),
                              Buton(context, "9"),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Buton(context, "0"),
                            ],
                          )
                        ],
                      ),
                    )//
                  ],
                ),
              ],
            ),
          ),
        ),
      ),)
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
  Widget Buton(BuildContext context,String num ){
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return InkWell(
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
              Password1 = "" ;
            });
            password1list.add(num);
            if(password1list.length == 4) {
              for (var i = 0; i < password1list.length ; i++) {
                Password1 = Password1 + password1list[i];
              }
              print("ps1 = $Password1");
              if (Password1 == ref.read(settingsRiverpod).Password ) {
                setState(() {
                  info = "Giriş Başarılı" ;
                  password1list.clear();
                  ref.read(settingsRiverpod).setStatus(true);
                  Navigator.of(context).pop();
                });
                widget.mode == "admin"
                ?Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1),
                    pageBuilder: (context, animation, nextanim) => passwordPage(),
                    reverseTransitionDuration: Duration(milliseconds: 1),
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
                  info = "Yanlış Şifre Girdiniz." ;
                  ref.read(settingsRiverpod).setStatus(false);
                });
              }
            }
          }
        },
      child: SizedBox(
        height: size.height / 9.5,
        width: size.height / 9.5,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
            color: Color(0xffE2E1E1),
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
    );
  }
}
