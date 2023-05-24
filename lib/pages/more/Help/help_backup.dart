import 'package:flutter/material.dart';

import '../../../classes/app_bar_for_page.dart';
import '../../../constans/material_color.dart';
import 'help_footer.dart';

class HelpBacup extends StatelessWidget {
  const HelpBacup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child:Scaffold(
            backgroundColor: const Color(0xffF2F2F2),
            appBar: AppBarForPage(title: "YARDIM<"),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Yedekleme Sistemi",
                          style: TextStyle(
                            fontFamily: "Nexa3",
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      const Text(
                        "Kullanıcıların en çok ihtiyacı olduğu en önemli özelliklerden biri olan yedeklenme sistemine uygulamamız üzerinde yer verdik. Verilerimizin kaybolmasını hiç istemeyiz, değil mi? 😁\n"
                      ),
                      const Text(
                          "Şu anda Google Cloud üzerinden yedeklenmeleri gerçekleştiriyoruz. Bu yüzden 1 defaya mahsus olarak Google hesabı üzerinden giriş gerçekleştirmeniz gerekmektedir.\n"
                      ),
                      Image.asset(
                        "assets/image/helpbackup1.png",
                        height: 80,
                      ),
                      SizedBox(height: 10),
                      const Text(
                        "Sonraki adımlarda ise hesabınız otomatik olarak giriş yapacaktır\n"
                      ),
                      const Text(
                        "Ön tanımlı olarak Yedeklenme sıklığı Günlük olarak ayarlanmıştır tabii isteğinize göre ayarlayabilirsiniz. Son yedeklenme tarihi üzerinden uygulamaya her giriş sağladığınızda tercihinize gere otomatik yedeklenme gerçekleşecektir. Lakin  önemli olan daha öncesinde uygulamaya Google hesabınızın giriş yapılı olması gerekiyor aksi halde otomatik yedekleme gerçekleştirilemez.\n"
                      ),
                      Image.asset(
                        "assets/image/helpbackup2.jpg",
                        height: 300,
                      ),
                      SizedBox(height: 10),
                      const Text(
                        "hesap girişi sonrası ekranlarınız da Emailiniz , Ad ve Soyadınız son olarak da Son yedeklenme tarihiniz gösterilmektedir.\n"
                      ),
                      const Text(
                        "Yedekle butonu sayesinde kayıtlarınızı .cvs dosyası şeklinde Cloud sistemine yedekleyebiliyorsunuz. Aynı şekilde Geri Yükle butonu sayesinde de Cloud üzerinden verilerinizi çekebiliyorsunuz. Endişelenmeyin her kayıt sonrası kayıtlarınız cihazınızdan silinerek yeni gelecek kayıtları temiz bir sayfa ile karşılıyoruz  \n\n Herhangi bir sorununuz da bize ulaşmayı ihmal etmeyiniz."
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                helpFooter(context)
              ],
            ),
          ),
        ),
    );
  }
}
