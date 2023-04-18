import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/Pages/more/Help/help_footer.dart';

class VersionsHelp extends StatelessWidget {
  const VersionsHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: const NavBar(),
          appBar: const AppBarForPage(title: "YARDIM <"),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
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

                        SizedBox(
                          width: size.width / 1.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Android 1.0 v",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Nexa3",
                                    fontSize: 25
                                ),
                              ),
                              Text(
                                "Update(17.04.2023)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Nexa3",
                                    fontSize: 25
                                ),
                              ),
                            ],
                          ),
                        ), // Yazıları sağdan soldan ortalayabilmek için box ın içine koydum
                      ],
                    ),
                  ),
                ), // versiyon ve short logo kismi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/rocket.ico",
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: size.width / 40,),
                          Text(
                            "İlk Gösterim",
                            style: TextStyle(
                              color: renkler.koyuuRenk,
                              fontSize: 28,
                              fontFamily: 'Nexa3'
                            ),
                          ),
                        ],
                      ), //ilk gosterim başlığı
                      SizedBox(height: size.height / 80,),
                      Column(
                        children: [
                          const Text("Merhaba! Bütçe Kontrol uygulamamızı kullanmaya başladığınız için teşekkür ederiz. Uygulamamız Version v1.0 ile ilk gösterime ıktığını duyurmaktan büyük mutluluk duyuyoruz. Tüm yazılım ekibimize buradan Tebrikler diliyoruz.\n"),
                          Image.asset(
                              "assets/image/icon_BKA/LOGOBKA-4.png",
                            height: size.height / 10,
                            width: size.width / 1.7,
                          ), // butce kontrol logosu
                          const Text('\nBu uygulama, gelir ve giderlerinizi takip etmenize, tasarruf etmenize ve bütçenizi kontrol altında tutmanıza yardımcı olmak için tasarlanmıştır.\n'),
                          const Text("Uygulamamız oldukça titiz bir çalışma sonucunda ortaya çıkarılmışır yazılım ekibimiz tarafından proje geliştirme adımları teker teker uygulanmıştır.\n"),
                          const Text('Uygulamamızda, aylık gelir ve giderlerinizi takip edebileceğiniz kolay bir arayüz bulunmaktadır. Ayrıca, bütçenizi aşan harcamalarınızı da takip edebilirsiniz. Böylece, bütçenizi aşmadan tasarruf etmek için gerekli adımları atabilirsiniz.\n'),
                          const Text("Harcamalarınızı günlük, aylık, haftalık veya yıllık olarak istatistik bölümünden kolaylıkla takip edebilirsiniz. Pasta grafiği sayesinde en çok hangi alanlara ne kadar harcama yaptığınızı kolayca takip edebilir ve bu harcamaları yönetmek veya azaltmak için adımlar atabilirsiniz.\n\n"),

                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/emoji_recycling.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: size.width / 40,),
                              Text(
                                "Sık Güncelleme",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'Nexa3',
                                  color: renkler.koyuuRenk,
                                ),
                              )
                            ],
                          ), // sık güncelleme
                          SizedBox(height: size.height / 80,),
                          const Text("Sürekli geliştirmelere ve önerilere açık bir altyapıyla her gün yeni özellikler üzerine çalışmalar yürütülmektedir. Ayrıca uygulamamız OpenSource(Açık kaynaklı kod) olarak yayınlamaktayız dolayısıyla her geliştirici arkadaş uygulamamıza katkıda bulunabilir. Google Play ve AppStrore gibi plartformlar üzüerinden kolay güncellenebilir durumdadır.\n\n"),

                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/Vector.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: size.width / 40,),
                              Text(
                                "Gelecekteki Yenilikler",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'Nexa3',
                                  color: renkler.koyuuRenk,
                                ),
                              )
                            ],
                          ), // gelecekteki yenilikler başlığı
                          SizedBox(height: size.height / 80,),
                          const Text("Uygulamamızın gelecekteki güncellemelerinde farklı para birimleriyle harcama takibi yapma, İngilizce ve Arapça gibi dillerin eklenmesi, harcama kategorilerinin özelleştirilmesi gibi yeni özellikler yer alacaktır. Takipte kalın ve bütçenizi kontrol altında tutmak için Bütçe Kontrol uygulamamızı kullanmaya devam edin.\n\n"),


                        ],
                      ), // bilgilendirme yazıları, ikon ve logolar

                    ],
                  ),
                ),
                helpFooter(context),
              ],
            ),
          ),
        )
    );
  }
}
