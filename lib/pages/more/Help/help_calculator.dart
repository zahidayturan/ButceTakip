import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/fezai_checkbox.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HelpCalculator extends StatelessWidget {
  const HelpCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    List<String> moneyPrefix = <String>[
      'TRY',
      "USD",
      "EUR",
      "GBP",
      "KWD",
      "JOD",
      "IQD",
      "SAR"
    ];
    String first = "TRY";
    return SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: translation(context).helpTitle2),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                              child: Icon(
                                size: 20,
                                Icons.calculate_rounded,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              translation(context).calculatorTitle,
                              style: TextStyle(
                                fontFamily: "Nexa4",
                                fontSize: 24,
                                height: 1,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            translation(context).currencyConverter
                            ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                          ),
                          const Spacer(),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Icon(
                              size: 20,
                              Icons.currency_exchange_rounded,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                items: moneyPrefix
                                    .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            fontFamily: 'Nexa3',
                                            color: renkler.koyuuRenk),
                                      ),
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: first.toString(),
                                onChanged: (newValue) {
                                },
                                //barrierColor: renkler.koyuAraRenk.withOpacity(0.8),
                                buttonStyleData: ButtonStyleData(
                                  overlayColor: MaterialStatePropertyAll(renkler
                                      .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  height: 30,
                                  width: 70,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 150,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: renkler.sariRenk,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  iconEnabledColor:
                                  renkler.koyuAraRenk,
                                  openMenuIcon: Icon(
                                    Icons.arrow_drop_up,
                                    color: Theme.of(context).canvasColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Açılır menülerde yalnızca uygulamada kullanabileceğiniz para birimleri yer almaktadır. Tek yapmanız gereken çevireceğiniz birimleri seçip tutarı girmektir."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Icon(
                              Icons.double_arrow_rounded,
                              size: 20,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Döviz çevirme işleminin yönünü göstermektedir."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            child: Image.asset(
                              "assets/icons/swap2.png",
                              width: 24,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Bu buton ile para birimlerinin yerlerini değiştirebilirsiniz."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Temizle butonu ile tutarı sıfırlayabilir, kopyala butonu ile sonucu kopyalayabilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Eski kurdan hesaplamayı seçerseniz, sistemimizde bu zamana dek kayıtlı olan bütün kur tarihleri çıkacaktır. Şu an da listede olmayan bir tarihe ulaşamazsınız."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: BannerAds(
                          adSize: AdSize.fullBanner,
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            translation(context).calculateInterestCredit
                            ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                          ),
                          const Spacer(),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Icon(
                              size: 20,
                              Icons.credit_card,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Ana para ve faiz değerlerini girdikten sonra vade seçimi yapmanız gerekmektedir. Hesapla butonuna basarak sonuçları görebilir, sıfırla butonu ile girdiğiniz değerleri silebilirsiniz. Sonuçlar listelenecektir."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Icon(
                              size: 20,
                              Icons.warning_amber_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "En fazla 7 haneli ana para girebilirsiniz. Vade listesinde yer alanların dışında vade giremezsiniz."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            translation(context).percentageCalculation
                            ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                          ),
                          const Spacer(),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Icon(
                              size: 20,
                              Icons.percent_rounded,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Tek sayılı işlemlerde bir sayı ve bir yüzde girmeniz gerekmektedir. Girilen sayının yüzdesini verecektir."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          fezaiCheckBox(
                            value: true,
                            clickedColor: Theme.of(context).disabledColor,
                            size: 18,
                            onChanged: (value) {
                            },
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "İkinci sayı için kutucuğu işaretlemelisiniz."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "İki sayılı işlemlerde; ikinci sayı birinci sayının yüzde kaçıdır ve birinci sayıdan ikinci sayıya değişim oranı kaçtır işlemlerini yapabilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 18,),
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
