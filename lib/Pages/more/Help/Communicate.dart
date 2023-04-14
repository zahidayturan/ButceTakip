import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class communicate extends StatelessWidget {
  const communicate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk,
      child:SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: "İLETİŞİM"),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:18, vertical: 8 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/image/icon_BKA/LOGOBKA-2.png",
                    width: size.width/1.7,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: const [
                    Icon(Icons.mail),
                    Text("Email   : *****@gmail.com"),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.account_circle_outlined),
                    Text("Github : https://github.com/ibrahimeth/ButceKontrolApp"),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    const Text(
                        "Yapımcılar",
                        style: TextStyle(
                          fontFamily: "Nexa2",
                          fontSize: 28
                        ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          "assets/image/icon_BKA/İKON.png",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "İbrahim Ethem AKBIYIK",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "İsmet Zahid AYTURAN",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Hamza BAYAR",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ) ,
          ),
        ),
      ) ,

    );
  }
}
