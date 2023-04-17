import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constans/MaterialColor.dart';
import '../../riverpod_management.dart';

class passwordPage extends ConsumerStatefulWidget {
  const passwordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<passwordPage> createState() => _passwordPageState();
}

class _passwordPageState extends ConsumerState<passwordPage> {
  bool Status = false;
  bool num1 = false;
  bool num2 = false;
  bool num3 = false;
  bool num4 = false;
  List <String> password1list = [];
  List <String> password2list = [];
  String Password1 = "" ;
  String Password2 = "" ;
  String info = "Giriş kodunuzu giriniz.";
  bool security = false ;
  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    bool isopen = readSetting.isPassword == 1 ? true : false ;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: "GİRİŞ ŞİFRESİ"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(
              children: [
                  SizedBox(height: size.height/80),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Container(
                        height: 40,
                        width: size.width,
                        color: renkler.ArkaRenk,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              const Text(
                                "Giriş Şifresi Durumu",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                ),
                              ),
                              Spacer(),
                              isopen ? Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                  : Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                              Switch(
                                value: isopen ,
                                onChanged: (bool value) {
                                  setState(() {
                                    readSetting.setPasswordMode(value);
                                    readSetting.setisuseinsert();
                                    if(!value){
                                      readSetting.setPassword("null");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                !isopen
                  ? SizedBox(width: 1)
                  : Column(
                    mainAxisAlignment:  MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: size.height/20) ,
                      Text(
                        "$info",
                        style: TextStyle(
                          color: renkler.koyuuRenk,
                          fontFamily: "Nexa4"
                        ),
                      ),
                      SizedBox(height: size.height/30) ,
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
                              if(security){
                                if(num1){
                                  password2list.removeLast();
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
                              }else{
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
      ),
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
          if(security){
            password2list.add(num);
          }else{
             password1list.add(num);
          }
          setState(() {
            num1 = true ;
          });
        }else if(num2 == false){
          if(security){
            password2list.add(num);
          }else{
            password1list.add(num);
          }
          setState(() {
            num2 = true;
          });
        }else if(num3  == false){
          if(security){
            password2list.add(num);
          }else{
            password1list.add(num);
          }
          setState(() {
            num3 = true;
          });
        }else if(num4 == false){
          if(security){
            setState(() {
              security = false ;
              Password1 = "" ;
              Password2 = "" ;
            });
            password2list.add(num);
            if(password2list.length == 4) {
              for (var i = 0; i < password1list.length ; i++) {
                Password1 = Password1 + password1list[i];
              }
              for (var i = 0; i < password2list.length ; i++) {
                Password2 = Password2 + password2list[i];
              }
              if (Password1 == Password2) {
                setState(() {
                  info = "şifreniz ayarlandı" ;
                  password1list.clear();
                  password2list.clear();
                  Status = true ;
                  ref.read(settingsRiverpod).setPasswordMode(true);
                  ref.read(settingsRiverpod).setPassword(Password1);
                  Navigator.of(context).pop();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor:
                    Color(0xff0D1C26),
                    duration: Duration(seconds: 1),
                    content: Text(
                      'Şifreniz Oluşturuldu.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Nexa3',
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                );
                temizle();
              } else {
                temizle();
                password1list.clear();
                password2list.clear();
                setState(() {
                  info = "Şifreler Uyuşmuyor." ;
                  Status = false;
                });
              }
            }
          }else{
            password1list.add(num);
            setState(() {
              security = true;
              num4 = true ;
              info = "Tekrar gininiz." ;
            });
              Future.delayed(Duration(milliseconds: 150)).then((value) => temizle());
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
