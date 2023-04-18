import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';

import '../../../classes/nav_bar.dart';

class HelpCalender extends StatelessWidget {
  const HelpCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          bottomNavigationBar: const NavBar(),
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
                      const Text(
                          "Kullanıcıların girdilerini esas alarak takvimsel olarak gereklilik olduğunu fark ettik bunun üzerine Kendi tasarımımız olan takvimi uygulattık. \n"
                      ),
                      Image.asset(
                          "assets/image/helpcalender1.png"
                      ),
                      const Text(
                          "\n\nKayan butonlar ile uygulamamızın bir çok yerinde karşılaşabilirsiniz. Kullanımı son derece kolay olan bu butonları aktif etmek için yapmanızgereken sağ veya sola kaydırmak olacaktır. Hem ay hem de yıl değişimini sağlayan bu yapı takvim kategorimizin güncellenmesini sağlamaktadır.\n"
                      ),
                      Image.asset(
                          "assets/image/helpcalender2.png"
                      ),
                      const Text("Günlük bazda verileri sıralıyor."),
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
