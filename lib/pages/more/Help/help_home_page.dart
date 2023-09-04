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
                                Icons.equalizer_rounded,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "ANA SAYFA",
                              style: TextStyle(
                                fontFamily: "Nexa4",
                                fontSize: 24,
                                height: 1,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "İşlem\nDetayı",
                            style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 15,
                              height: 1,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Eklediğiniz işlemleri aylık olarak takip etmeniz ve diğer sayfalara ulaşmanız için hazırlanmıştır."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Bu sayfada yapabileceğiniz işlemler"
                        ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
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
                              Icons.search_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Not ve kategoriye göre işlem arama menüsü."
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
                              Icons.history_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Tekrarlı ve taksitli işlemler menüsü. Bu tür işlemleri buradan kontrol edebilirsiniz."
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
                              Icons.bookmark_outline_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Kaydedilen ve son işlemler menüsü."
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
                              Icons.settings_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Ayarlar menüsü. Basılı tutarak temayı da buradan değiştirebilirsiniz"
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      SizedBox(
                        width: 210,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: Theme.of(context).disabledColor
                                ),
                                width: 208,
                                height: 26,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        "assets/icons/arrow.png",
                                        color: renkler.koyuuRenk,
                                      ),
                                    ),
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                    child: Container(
                                      height: 32,
                                      width: 164,
                                      color: Theme.of(context).highlightColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              translation(context).august,
                                              style: TextStyle(
                                                color: renkler.arkaRenk,
                                                fontSize: 17,
                                                fontFamily: 'Nexa3',
                                              ),
                                            ),
                                            // Ay gösterge
                                            const SizedBox(width: 4),
                                            Text(
                                              "2023",
                                              style: TextStyle(
                                                color: renkler.arkaRenk,
                                                fontSize: 17,
                                                fontFamily: 'Nexa4',
                                              ),
                                            ),
                                            // Yıl gösterge
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        "assets/icons/arrow.png",
                                        color: renkler.koyuuRenk,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Ayı değiştirmek için butonları kullanabilir veya doğrudan aylık verileri sağa veya sola kaydırabilirsiniz. Yazıya bastığınızda ise içinde bulunduğunuz aya dönülecektir."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Theme.of(context).indicatorColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding:
                          const EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: renkler.kirmiziRenk,
                                            borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(90),
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(50),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          height: 18,
                                          width: 18,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 9, top: 5),
                                          child: Text("16", style: TextStyle(
                                              height: 1,
                                              fontFamily: "Nexa4",
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(translation(context).monday, style: const TextStyle(height: 1,
                                          fontFamily: "Nexa3", fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: FittedBox(
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Row(
                                            children: [
                                              Text("1907.6",
                                                style: TextStyle(
                                                  height: 1,
                                                  color: renkler.kirmiziRenk,
                                                  fontFamily: "Nexa4",
                                                  fontSize: 17,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection: TextDirection.ltr,
                                              ),
                                              Text("₺",
                                                style: TextStyle(
                                                  height: 1,
                                                  color: renkler.kirmiziRenk,
                                                  fontFamily: "TL",
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${5} ${translation(context).activityCount}",
                                      style: TextStyle(
                                        height: 1,
                                        color: Theme.of(
                                            context)
                                            .canvasColor,
                                        fontFamily:
                                        "Nexa3",
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child:  FittedBox(
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: RichText(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                TextSpan(text:  "650.9",
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: renkler.yesilRenk,
                                                    fontFamily: "Nexa3",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "₺",
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: renkler.yesilRenk,
                                                    fontFamily: "TL",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ])),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text:  "-2558,5",
                                                style: TextStyle(
                                                  height: 1,
                                                  color: renkler
                                                      .kirmiziRenk,
                                                  fontFamily:
                                                  "Nexa3",
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "₺",
                                                style: TextStyle(
                                                  height: 1,
                                                  color: renkler
                                                      .kirmiziRenk,
                                                  fontFamily:
                                                  "TL",
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ]
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Seçili ayın işlem içeren günlerinin yer aldığı tıklanabilir liste. Basarak detaylarına erişebilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                color: Theme.of(context).highlightColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                                child: Text(
                                  translation(context).todaysActivities,
                                  style: TextStyle(
                                    color: renkler.arkaRenk,
                                    height: 1,
                                    fontFamily: 'Nexa3',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 25,
                                left: 25,
                                top: 4,
                              ),
                              child: Text("${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1,
                                      fontFamily: 'Nexa4',
                                      fontWeight: FontWeight.w900,
                                      color: Theme.of(context).canvasColor
                                  )),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Bu yazı butonlarına basarak içinde bulunduğunuz günün işlem detaylarına ve takvim menüsüne erişebilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "İşlem Detayları - Açılır Menü"
                            ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                          ),
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
                              Icons.remove_red_eye_rounded,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Bir işlemin tüm detayları yer almaktadır. Bu menüden işlemi silebilir, tekrar ekleyebilir ve düzenleyebilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              Icons.delete,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
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
                              Icons.refresh_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
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
                              Icons.create_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                              height: 30,
                              //width: 30,
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
                              child: Center(child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: renkler.yesilRenk
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6,top: 4),
                                    child: Text("Aktif Döviz",style: TextStyle(color: renkler.koyuuRenk,height: 1),),
                                  ),
                                ],
                              ))
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Bu bilgi gelir olarak eklediğiniz dövizlerde yer alacaktır. Cebinizde olacağı için her gün döviz kuruna göre tutarı yeniden hesaplanacaktır."
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
                            //width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
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
                            child: Center(child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: renkler.arkaRenk
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 6,top: 4),
                                  child: Text("Pasif Döviz",style: TextStyle(color: renkler.arkaRenk,height: 1),),
                                ),
                              ],
                            ))
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Bu bilgi daha önceden gelir olarak eklenmiş bir dövizin gider olarak eklenmesi sonucunda ortaya çıkacaktır. Cebinizden çıktığı için artık tutarı sabit kalacaktır."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Bu menüde eğer ki sistem mesajı görülüyorsa o işlem tekrar veya taksitli bir işlemdir."
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
