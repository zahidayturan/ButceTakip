import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';

class HelpAddUpdate extends StatelessWidget {
  const HelpAddUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
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
                                Icons.add_rounded,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Text(
                              "VERİ EKLE - DÜZENLE",
                              style: TextStyle(
                                fontFamily: "Nexa4",
                                fontSize: 23,
                                height: 1,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Tek sayfadan ekleme, düzenleme ve aynı işlemi tekrardan ekleme işlemlerini yapabilirsiniz."
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
                              Icons.south_west_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Gider ve gelir seçiminize göre kategoriler ve döviz aktifliği değişecektir."
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
                              Icons.calendar_month_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Takvimden seçtiğiniz gün, ana işlemin yanı sıra tekrarlı ve taksitli işlemler için de başlangıç günü olarak seçilecektir."
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
                              Icons.category_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Kategorilerde varsayılan olarak eklenenler değiştirelemez. Kendi eklediğiniz kategorileri silebilir ve değiştirebilirsiniz."
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
                              Icons.credit_card_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Kart olarak seçtiğiniz işlemler tek kart olarak işlenir. Şu an da ikinci bir kart ekleyemezsiniz."
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
                              Icons.bookmark_add_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Kaydettiğiniz işlemler ana sayfanın üst tarafında menü içerisinde listelenecektir."
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
                              Icons.refresh_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "Tekrarlı olarak eklediğiniz bir işlem daha sonra taksitli işleme çevrilemez. Taksitli bir işlem için taksit sayısına göre tutar hesaplanacaktır. Siz tutarın hepsini girmelisiniz"
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
                            child: Center(
                              child: Text(
                                "₺",style: TextStyle(
                                fontFamily: "TL",
                                fontSize: 18,
                                color: renkler.yaziRenk
                              ),
                              ),
                            )
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              "En fazla 7 haneli tutar ekleyebilirsiniz. Döviz eklerseniz işlemin tarihine göre döviz kuru işleme uygulanacaktır. Girdiğiniz tutar sabit kalacak, gösterilen tutar değişecektir."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Sadece  gelir olarak eklediğiniz dövizlerin gösterilen tutarı döviz kuruna göre değişecektir. Bu işlemleri işlem detayından kontrol edebilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "İşlem Düzenleme - Tekrar Ekleme"
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
                              Icons.edit_rounded,
                              color: renkler.koyuuRenk,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tekrar ekleyeceğiniz işlemler güncel tarih ile düzenleyeceğiniz işlemler ise işlemin tarihi ile işlenecektir."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(width: 14,),
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
                              child: Center(
                                child: Icon(
                                  size: 20,
                                  Icons.edit_calendar_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "İşlemin türünü değiştirdiyseniz kategori sıfırlanacaktır. Eski haline dönmek isterseniz çıkıp tekrar girmelisiniz."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(width: 14,),
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
                              child: Center(
                                child: Icon(
                                  size: 20,
                                  Icons.category_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Pasif olan bir dövizi düzenlerken dikkatli olmalısınız. Gelir olan dövizler aktifleşecektir."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(width: 14,),
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
                              child: Center(
                                child: Icon(
                                  size: 20,
                                  Icons.currency_exchange_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Sistem mesajını içeren işlemleri düzenlerken o işlemin tekrarlı veya taksitli işlem olduğunu unutmamalısınız. Olmayan bir tekrarı oluşturabilirsiniz."
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(width: 14,),
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
                              child: Center(
                                child: Icon(
                                  size: 20,
                                  Icons.message_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                          ),
                        ],
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
