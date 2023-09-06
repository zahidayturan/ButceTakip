import 'package:flutter/material.dart';
import '../../../classes/app_bar_for_page.dart';
import '../../../classes/language.dart';
import '../../../constans/material_color.dart';
import '../../../utils/textConverter.dart';
import 'help_footer.dart';

class HelpAssets extends StatelessWidget {
  const HelpAssets({Key? key}) : super(key: key);

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
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: Offset(0, 2)
                                    )
                                  ]
                              ),
                              child: Icon(
                                size: 20,
                                Icons.wallet,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "VARLIK SAYFASI",
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
                      Text(
                        "Varlıklarım sayfası anlık olarak tüm varlığınızı görebilmeniz için   tasarlanmıştır."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Bu sayfada yapabileceğiniz işlemler"
                        ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      FittedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: size.height * .007, horizontal: size.width *.03),
                          decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    spreadRadius: 1
                                )
                              ]
                          ),
                          child:  Row(
                            children: [
                              Center(
                                child: Text(
                                  translation(context).addRemoveAsset,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      height: 1
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Varlığınızda düzenleme yapabilmenizi sağlar ister döviz ister yerel para biriminiz cinsinden giriş sağlayabilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Container(
                        height: size.height * .052,
                        width: size.width * .36,
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ],
                          color: Theme.of(context).indicatorColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 35,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/bank.png",
                                    height: 21,
                                    color: Theme.of(context).canvasColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  Text(
                                    translation(context).card,
                                    style: TextStyle(
                                      fontSize: 11,
                                      height: 1,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "2071" ,
                              style: TextStyle(
                                fontFamily: 'NEXA3',
                                fontSize: 17,
                                height: 1,
                                color: Theme.of(context).canvasColor
                              ),
                            ),
                            Text(
                              "₺" ,
                              style:  TextStyle(
                                  fontFamily: 'TL',
                                  fontSize: 19,
                                  height: 1,
                                  color: Theme.of(context).canvasColor
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Kart, Nakit , Diğer işlem araçlarından her biri için net değişim miktarları da gösterilmektedir."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      FittedBox(
                        child:  Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child : const Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 9,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Aktif Döviz"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Dövizleriniz için ayrılmış alanda sadece Aktif Dövizleriniz yani varsayılan para biriminden farklı ve gelir olarak girilmiş aynı zamanda uygulamaya her girişinizde işlem miktarı yeniden hesaplanan kayıtlar gösterilir."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      SizedBox(
                        width: size.width * .43,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: size.width *.02, vertical: size.height * .013),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).indicatorColor,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Converter().textConverterFromDB("Kart", context, 2),
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).canvasColor,
                                          ),
                                        ),
                                        Text(
                                          "04.09.2023",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            color: Theme.of(context).canvasColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "TRY",style: TextStyle(
                                      height: 1,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                  flex: 1,
                                  child: Icon(Icons.swap_horiz_rounded)
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        "Gösterilen kayıtları isterseniz buradan isterseniz de işlem detayından para birimini değiştirebilirsiniz. itemin üzerine tıkladığınızda döviz bürosu açılacaktır ve farklı para birimlerine Güncel döviz kurlarıyla dövizinizi dönüştürebilir veya bozdurabilirsiniz."
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
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