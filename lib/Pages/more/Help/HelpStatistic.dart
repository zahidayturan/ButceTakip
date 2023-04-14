import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class helpStatisic extends StatelessWidget {
  const helpStatisic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
          child: Scaffold(
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
                            "İstatistik Sayfası",
                            style: TextStyle(
                              fontFamily: "Nexa3",
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Text(
                          "Değerli kullanıcılarımızın harcama bilgilerini belirli periyotlarda görmek istemekteler. Bunun için İstatistik sayfasını oluşturduk burada pasta dilimi kullanarak yüzdesel olarak harcama detaylarını görselleştiriyoruz.\n"
                        ),
                        Image.asset(
                          "assets/image/helpstatistic1.png"
                        ),
                        const Text(
                          "\nİstatistik bölümümüzdeki pasta grafiğini en etkili şekilde yeniden biçimlendirmek için pratik işlem menüsü tasarlandı. Dolayısıyla veri havuzunu Yıllık, Aylık, Haftalık ve Günlük olacak şekilde filitreleyip sonuçların analizini yaptırabileceksiniz."
                        ),
                        Image.asset(
                            "assets/image/helpstatistic2.png"
                        ),
                        const Text(
                            "\nİstatistiksel olarak yapılan hesplama sonrası Liste şeklinde her bir kategoriye özel harcama bilgisigösterilmektedir."
                        )
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
