import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';

class HelpHomePage extends StatelessWidget {
  const HelpHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
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
                       """Uygulamamızın Ana sayfasında kullanıcıya kolaylık sağlanması amacıyla faydalı alanı en kullanışlı şekilde dizayn ettik. Burada hem Aylık harcama bilgilerini hem de o güne ait verileri ana sayfamız üzerinden gösterimini sağladık. 
                       """
                     ),
                   ),
                   Image.asset(
                     "assets/image/helphome1.png",
                   ),
                   const Text(
                     "\nKullanıcı istediği kaydın üzerine tıklayarak o güne ait verilerin olduğu sayfaya yönlendiriliyor. Harcamaların üzerinden istenilen kayda gidildiğinde harcamanın detay sayfası bizi karşılıyor\n"
                   ),
                   Image.asset(
                     "assets/image/helphome2.png",
                   ),
                   const Text(
                       """\nGünlük harcama bilgilerinin gösterildiği alanda  kullanıcının en çok görmek istediği verileri düşünerek Kategori, Ödeme türü, Miktar bilgisi ve harcama saati bilgisine yer verdik."""
                   ),
                   Image.asset(
                     "assets/image/helphome3.png",
                   ),
                   const Text(
                       """\nAna Sayfamızın Appbar kısmında Bazı shortWay’ler  kullanılmıştır Bunlar aşağıda belirtilmiştir. \n"""
                   ),
                   Image.asset(
                     "assets/image/helphome4.png",
                   ),
                   const Text(
                       """\nKaydedilen sekmesinde kullanıcının tekrar tekrar aynı verileri  girmesinden kaçınılmak için tek seferde veriyi kaydetmesini sağlamaktadır örneğin ; Maaş, Aidat/Kira, Burs , vb.\n\n"""
                   ),
                   Image.asset(
                     "assets/image/helphome5.png",
                     width: size.width/1.7,
                   ),
                 ],
               ),
             ),
              const SizedBox(height: 10,),
              helpFooter(context),
            ],
          ),
        ),
      )
    );
  }
}
