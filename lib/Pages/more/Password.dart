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
  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    bool isopen = readSetting.isPassword == 1 ? true : false ;
    TextEditingController passwordController = TextEditingController();
    bool num1 = false;
    bool num2 = false;
    bool num3 = false;
    bool num4 = false;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: "GİRİŞ ŞİFRESİ"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(
              children: [
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
                                  readSetting.setBackup(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                            color: num1 ? Colors.black : Color(0xffE2E1E1),
                          ),
                        )
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
