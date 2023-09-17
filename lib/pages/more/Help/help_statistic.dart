import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HelpStatisic extends StatelessWidget {
  const HelpStatisic({Key? key}) : super(key: key);

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
                              translation(context).statisticsPageHelp,
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
                        translation(context).statisticsPageHelpDescription
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

                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2)
                              )
                            ]),
                            child: ClipPath(
                              clipper: MyCustomClipper(),
                              child: Tooltip(
                                message: translation(context).expenses,
                                triggerMode: TooltipTriggerMode.tap,
                                showDuration: const Duration(seconds: 1),
                                textStyle: TextStyle(
                                    fontSize: 13,
                                    color: renkler.arkaRenk,
                                    height: 1),
                                textAlign: TextAlign.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                    color: Theme.of(context).highlightColor),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).disabledColor,
                                  ),
                                  child: Icon(Icons.south_west_rounded,
                                      color:renkler.koyuuRenk),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              translation(context).infoBoxesForFiltering
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        translation(context).statisticsFiltering
                        ,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,height: 1.1,fontSize: 16,fontFamily: "Nexa4"),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Container(
                                height: 30,
                                width: size.width,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 8),
                              child: SizedBox(
                                height: 32,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        translation(context).dateStatistics,
                                        style: TextStyle(
                                            color: renkler.arkaRenk,
                                            fontSize: 14,
                                            fontFamily: 'Nexa3'),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 32,
                                          //width: 100,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).disabledColor,
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14),
                                              child: Text(translation(context).monthly,style: TextStyle(
                                                color: renkler.koyuuRenk,
                                                fontSize: 12,
                                                fontFamily: "Nexa4"
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                                height: 30,
                                                width: 68,
                                                child: Center(
                                                    child: Text(
                                                      translation(context).august,
                                                      style: TextStyle(
                                                          color: renkler.arkaRenk,
                                                          height: 1,
                                                          fontSize: 12,
                                                          fontFamily: 'Nexa3'),
                                                    ))),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                height: 5,
                                                width: 68,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(15),
                                                      topLeft: Radius.circular(15)),
                                                  color: Theme.of(context).disabledColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                            child: Text(
                                              '/',
                                              style: TextStyle(color: renkler.arkaRenk),
                                            )),
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 54,
                                              child: Center(
                                                  child: Text(
                                                    "2023",
                                                    style: TextStyle(
                                                        color: renkler.arkaRenk,
                                                        height: 1,
                                                        fontSize: 12,
                                                        fontFamily: 'Nexa3'),
                                                  )),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                height: 5,
                                                width: 54,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(15),
                                                      topLeft: Radius.circular(15)),
                                                  color: Theme.of(context).disabledColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        translation(context).filteringInstructions
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Text(
                        translation(context).resetButtonForFiltering
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      SizedBox(
                        height: 38,
                        width: size.width * 0.95,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).focusColor,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Container(
                                width: 70,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: const Center(
                                    child: Text(
                                      "% 24",
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'NEXA3',
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  translation(context).foodExpense,
                                  style: TextStyle(
                                    height: 1,
                                    fontFamily: 'NEXA3',
                                    fontSize: 18,
                                    color:
                                    Theme.of(context).canvasColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "112.40",
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'NEXA3',
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .dialogBackgroundColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      " ₺",
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: 'TL',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .dialogBackgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        translation(context).filteringResult
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
                              Icons.pie_chart_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              translation(context).pieChart
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
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
class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double roundnessFactor = 4.0;
    double height = 30.0;
    double width = 30.0;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width - roundnessFactor, 0);
    path.quadraticBezierTo(width, 0, width, roundnessFactor);

    path.lineTo(width - roundnessFactor, height - roundnessFactor);

    path.quadraticBezierTo(
        width - roundnessFactor, height, width - (roundnessFactor * 2), height);

    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
