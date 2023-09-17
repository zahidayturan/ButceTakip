import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../classes/app_bar_for_page.dart';
import '../../../classes/language.dart';
import '../../../constans/material_color.dart';
import '../../../utils/textConverter.dart';
import 'help_footer.dart';

class HelpBackup extends StatelessWidget {
  const HelpBackup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    int initialLabelIndex = 1 ;
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
                              translation(context).backupSystem1,
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
                        translation(context).backupSystem2
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      SizedBox(
                        width: size.width * 0.56,
                        height: 31,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2)
                              )
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [const Color(0xff2A2895), renkler.koyuuRenk],
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      "assets/icons/google.png"
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    translation(context).signIn,
                                    style: TextStyle(
                                        color: renkler.arkaRenk,
                                        height: 1,
                                        fontSize: 15,
                                        fontFamily: "Nexa3"
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6,),
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
                      Text(
                        translation(context).backupSystem4
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      SizedBox(
                        height: 25,
                        child: ToggleSwitch(
                          initialLabelIndex: initialLabelIndex,
                          totalSwitches: 3,
                          labels: [translation(context).dailyBackup, translation(context).monthlyBackup, translation(context).yearlyBackup],
                          activeBgColor: const [Color(0xffF2CB05)],
                          activeFgColor: const Color(0xff0D1C26),
                          inactiveBgColor: Theme.of(context).highlightColor,
                          inactiveFgColor: const Color(0xFFE9E9E9),
                          minWidth: 60,
                          cornerRadius: 20,
                          radiusStyle: true,
                          animate: true,
                          curve: Curves.linearToEaseOut,
                          customTextStyles: const [
                            TextStyle(
                                fontSize: 9, fontFamily: 'Nexa3', fontWeight: FontWeight.w800, height: 1)
                          ],
                          onToggle: (index) {

                          },
                        )
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            height: 26,
                            width: size.width * 0.2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: renkler.koyuuRenk,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    translation(context).backup, // geri yükle
                                    style: TextStyle(
                                        height: 1,
                                        color: renkler.arkaRenk,
                                        fontSize: 11,
                                        fontFamily: "Nexa3"
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              translation(context).backupSystem5
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14,),

                      Row(
                        children: [
                          FittedBox(
                            child: Container(
                              height: 26,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: renkler.koyuuRenk,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      translation(context).restoreData, // geri yükle
                                      style: TextStyle(
                                          height: 1,
                                          color: renkler.arkaRenk,
                                          fontSize: 11,
                                          fontFamily: "Nexa3"
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              translation(context).backupSystem6
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      /*
                      Container( //boyut
                        height: size.width * .5,
                        width: size.width * .73,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: renkler.koyuuRenk,
                          border: Border.all(
                            color: Theme.of(context).canvasColor
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: size.width * .3,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                          decoration: BoxDecoration(
                                            //color: Theme.of(context).indicatorColor,
                                            color: Theme.of(context).indicatorColor,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "BT_Data*16_08_2002",
                                                  style: TextStyle(
                                                      fontSize: 13
                                                  ),
                                                ),
                                                //Icon(Icons.download_rounded),
                                                const Icon(Icons.cloud_download_outlined),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ) ;
                                },
                              ),
                            ),
                            Center(
                              child: Text(
                                "${translation(context).numberOfRecordsShown} 2",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Nexa3",
                                  color: renkler.arkaRenk,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        translation(context).backupSystem7
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      */
                      const SizedBox(height: 14),
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 40,
                        shadows: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 2)
                          )
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        translation(context).backupSystem8
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