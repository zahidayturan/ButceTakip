import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class helpHomePage extends StatelessWidget {
  const helpHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffF2F2F2),
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
                             "Ana Sayfa",
                           style: TextStyle(
                             fontFamily: "Nexa3",
                             fontSize: 30,
                             color: Colors.black,
                           ),
                         ),
                       ),
                       const SizedBox(
                         child: Text(
                           """Uygulamamızın Ana sayfasında kullanıcıya kolaylık  sağlanması amacıyla Faydalı alanı en kullanışlı şekilde dizaynettik. Burada hem Aylık harcama bilgilerini hem de o güne aitverileri ana sayfamız üzerinden gösterebiliyoruz. 
                           """
                         ),
                       ),
                       Image.asset(
                         "assets/image/helphome1.png",
                       ),
                       const Text(
                         """\nKullanıcı istediği kaydın üzerine tıklayarak O güne ait verilerin olduğu sayfa açılıyor harcamaların üzerinden istenilen kayda gidildiğinde harcamanın detay sayfası bizi karşılıyor"""
                       ),
                       Image.asset(
                         "assets/image/helphome2.png",
                       ),
                       const Text(
                           """\nGünlük harcama bilgilerinin gösterildiği alanda  kullanıcının en çok görmek istediği verileri düşünerek Kategori, Ödeme türü, Miktar bilgisini ve harcama saati bilgisine yer verdik."""
                       ),
                       Image.asset(
                         "assets/image/helphome3.png",
                       ),
                       const Text(
                           """Ana Sayfamızın Appbar kısmında Bazı shortWay’ler  kullanılmıştır Bunlar aşağıda belirtilmiştir. """
                       ),
                       Image.asset(
                         "assets/image/helphome4.png",
                       ),
                       const Text(
                           """\nKaydedilen sekmesinde kullanıcının tekrar tekrar aynı verileri  girmesinden kaçınılmak için tek seferde veriyi kaydetmesini sağlamaktadır örneğin ; Maaş, Aidat/Kira, Burs , vb."""
                       ),
                       Image.asset(
                         "assets/image/helphome5.png",
                         width: size.width/1.7,
                       ),
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
