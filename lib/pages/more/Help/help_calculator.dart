import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';

class HelpCalculator extends StatelessWidget {
  const HelpCalculator({Key? key}) : super(key: key);

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
                          "Hesap Makinesi",
                          style: TextStyle(
                            fontFamily: "Nexa3",
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Text(
                          "Mevzu bahis cüzdan ve para yönetimi ise hesap ve basit matematik işlemleri olmadan olmaz dedik dolayısıyla uygulamamızda pratik işlemleri yapabileceğiniz küçük bir hesap makinesi oluşturduk.\n"
                      ),
                      Image.asset(
                        "assets/image/helpcalculator1.png",
                      ),
                      const Text("\nYüzde hesabını kullanmak için bazı özelliklerin bilinmesi gerekmektedir varsayılan olarak sayı girdisi ve yüzdesel oran alınarak sonuç gösterilir lakin bazı durumlarda bir adet sayı yetmeyebilir bu yüzden 2. bir sayıya ihtiyaç duyulur.\n"),
                      Image.asset(
                        "assets/image/helpcalculator2.png",
                      ),
                      const Text(
                        "\nSayı 2 ‘yi ekle seçeneği işaretlendiğinde varsayılı olarak 1. seçenek yani Sayı 2 Sayı 1’in Yüzde kaçıdır tarzındaki problemler için yazılmış mod seçilmiş oluyor burada program yüzdesel oran çıktısını veriyor .\n\n",
                      ),
                      const Text(
                          "2. seçenek yani Sayı 1’den Sayı 2’ ye Değişim oranı kaçtır bu probleme genel olarak finans alanında çokça karşılaşılır. Bu seçeneğimizde yine yüzdesel bir çıktı verilir.\n"
                      ),
                      Image.asset(
                        "assets/image/helpcalculator3.png",
                      ),
                      const Text("Döviz dönüştürücü bölümünde internetin varlığında anlık olarak API üzerinden güncellenen kurlarca hesaplama amaçlanmaktadır lakin şuanlık sabitlenen veriler den hesaplama gösterilmektedir API işlemleri sonraki versiyon güncellenmesinde gelmesi beklenmektedir.\n"),
                      const Text(
                        "TL ve USD gibi değişkenleri yana kaydırarak kullanım sağlayabailirsiniz şuanda 3 adet Döviz çeşiti vardır ; TRY, USD, EUR\n",
                      ),
                      Image.asset(
                        "assets/image/helpcalculator4.png",
                        width: size.width,
                      ),
                      const Text(
                        "\n\ngirilen yüzde , Ana para ve Vade ile Kredi hesaplaması yapılmaktadır. Kullanıcılarımıza en basit şekli ile sade bir tasarım sunarak hesaplama sonucunda Aylık taksit miktarı, Toplam faiz ve Toplam ödeme gibi başlıklar gösterilmektedir. \n\n",
                      ),
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
