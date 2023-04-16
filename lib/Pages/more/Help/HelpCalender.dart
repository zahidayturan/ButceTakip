import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

import '../../../classes/navBar.dart';

class helpCalender extends StatelessWidget {
  const helpCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: navBar(),
            appBar: const AppBarForPage(title: "YARDIM<"),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom:  8.0),
                    child: Container(
                      color: renkler.koyuuRenk,
                      height: 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width/10,),
                          Image.asset(
                            "assets/image/LogoBkaShort.png",
                            height: 60,
                            width: 60,
                          ),
                          const Text(
                            "Help Center",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Nexa3",
                                fontSize: 25
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Takvim Sayfası",
                            style: TextStyle(
                              fontFamily: "Nexa3",
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "Kullanıcıların girdilerini esas alarak takvimsel olarak gereklilik olduğunu fark ettik bunun üzerine Kendi tasarımımız olan takvimi uygulattık. \n"
                        ),
                        Image.asset(
                          "assets/image/helpcalender1.png"
                        ),
                        Text(
                          "\n\nKayan butonlar ile uygulamamızın bir çok yerinde karşılaşabilirsiniz. Kullanımı son derece kolay olan bu butonları aktif etmek için yapmanızgereken sağ veya sola kaydırmak olacaktır. Hem ay hem de yıl değişimini sağlayan bu yapı takvim kategorimizin güncellenmesini sağlamaktadır.\n"
                        ),
                        Image.asset(
                            "assets/image/helpcalender2.png"
                        ),
                        Text("Günlük bazda verileri sıralıyor."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
