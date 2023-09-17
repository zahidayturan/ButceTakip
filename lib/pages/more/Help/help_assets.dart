import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
                              translation(context).assetsPage1,
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
                        translation(context).assetsPage2
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: BannerAds(
                          adSize: AdSize.banner,
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        translation(context).whatYouCanDoOnThisPage
                        ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      FittedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: size.height * .007, horizontal: size.width *.03),
                          decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
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
                        translation(context).assetsPage3
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Container(
                        height: size.height * .052,
                        width: size.width * .36,
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(0, 2)
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
                        translation(context).assetsPage4
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      FittedBox(
                        child: Container(
                            height: 30,
                            //width: 110,
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
                                  child: Text(translation(context).activeCurrency,style: TextStyle(color: renkler.koyuuRenk,height: 1),),
                                ),
                              ],
                            ))
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        translation(context).assetsPage5
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
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ]
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
                        translation(context).assetsPage6
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