import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
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
          //backgroundColor: const Color(0xffF2F2F2),
          appBar: AppBarForPage(title: translation(context).helpTitle2),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom:  8.0),
                  child: Container(
                    color: Theme.of(context).highlightColor,
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
                          "Yardım Merkezi",
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
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                         "Ana Sayfa",
                       style: TextStyle(
                         fontFamily: "Nexa3",
                         fontSize: 30,
                         color: Theme.of(context).canvasColor,
                       ),
                     ),
                   ),
                   SizedBox(height: 10,),
                   SizedBox(
                     child: Text(
                       """Uygulamamızın Ana sayfasında kullanıcıya kolaylık sağlanması amacıyla faydalı alanı en kullanışlı şekilde dizayn ettik. Burada hem Aylık harcama bilgilerini hem de o güne ait verileri ana sayfamız üzerinden gösterimini sağladık. 
                       """,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.2),textAlign: TextAlign.justify,
                     ),
                   ),
                   Image.asset(
                     "assets/image/helphome1.png",
                   ),
                   Text(
                     "\nKullanıcı istediği kaydın üzerine tıklayarak o güne ait verilerin olduğu sayfaya yönlendiriliyor. Harcamaların üzerinden istenilen kayda gidildiğinde harcamanın detay sayfası bizi karşılıyor\n"
                         ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.2),textAlign: TextAlign.justify,
                   ),
                   Image.asset(
                     "assets/image/helphome2.png",
                   ),
                   Text(
                       """\nGünlük harcama bilgilerinin gösterildiği alanda  kullanıcının en çok görmek istediği verileri düşünerek Kategori, Ödeme türü, Miktar bilgisi ve harcama saati bilgisine yer verdik."""
                   ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.2),textAlign: TextAlign.justify,
                   ),
                   SizedBox(height: 5,),
                   Image.asset(
                     "assets/image/helphome3.png",
                   ),
                   Text(
                       """\nAna Sayfamızın Appbar kısmında Bazı shortWay’ler  kullanılmıştır Bunlar aşağıda belirtilmiştir. \n"""
                   ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.2),textAlign: TextAlign.justify,
                   ),
                   Image.asset(
                     "assets/image/helphome4.png",
                   ),
                   Text(
                       """\nKaydedilen sekmesinde kullanıcının tekrar tekrar aynı verileri girmesinden kaçınılmak için tek seferde veriyi kaydetmesini sağlamaktadır örneğin ; Maaş, Aidat/Kira, Burs , vb.\n\n"""
                   ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.2),textAlign: TextAlign.justify,
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
