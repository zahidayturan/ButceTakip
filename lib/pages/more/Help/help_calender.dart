import 'package:butcekontrol/Pages/more/Help/help_footer.dart';
import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class HelpCalender extends StatelessWidget {
  const HelpCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> monthList = [
      translation(context).january,
      translation(context).february,
      translation(context).march,
      translation(context).april,
      translation(context).may,
      translation(context).june,
      translation(context).july,
      translation(context).august,
      translation(context).september,
      translation(context).october,
      translation(context).november,
      translation(context).december,
    ];
    List<String> yearList = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
      '2029',
      '2030',
    ];
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
                                Icons.calendar_month_rounded,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              translation(context).calenderPage,
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
                        translation(context).calenderPageDescription
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
                      SizedBox(
                        width: size.width * 0.46,
                        height: size.height * 0.06,
                        child: Stack(
                          children: [
                            Positioned(
                              top: size.height * 0.005,
                              child: Container(
                                height: size.height * 0.05,
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color: Theme.of(context).disabledColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 2,
                                          offset: Offset(0, 2)
                                      )
                                    ]
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: size.height * 0.05,
                                  width: size.width * 0.27,
                                  child: PageView(
                                    //controller: read.pageMonthController,
                                    onPageChanged: (index) {
                                    },
                                    children: monthList
                                        .map(
                                          (month) => Center(
                                        widthFactor: 1.5,
                                        child: Text(
                                          month,
                                          style: const TextStyle(
                                            color: Color(0xff0D1C26),
                                            fontSize: 16,
                                            fontFamily: 'Nexa4',
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.18,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                                    color: Theme.of(context).highlightColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 0.5,
                                            blurRadius: 2,
                                            offset: Offset(0, 2)
                                        )
                                      ]
                                  ),
                                  child: PageView(
                                    //controller: read.pageYearController,
                                    onPageChanged: (index) {
                                    },
                                    children: yearList
                                        .map(
                                          (year) => Center(
                                        child: Text(
                                          year,
                                          style: TextStyle(
                                            color: Theme.of(context).dialogBackgroundColor,
                                            fontSize: 16,
                                            fontFamily: 'Nexa4',
                                            fontWeight: FontWeight.w600,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        translation(context).changeMonthYear
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15,
                      ),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                shape: BoxShape.circle,
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
                              Icons.refresh_rounded,
                              color: renkler.arkaRenk,
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              translation(context).backToCurrentMonth
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
                                      offset: Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Center(
                              child: Text(
                                "1",style:TextStyle(
                                color: renkler.koyuuRenk,
                                fontFamily: "Nexa4",
                                fontSize: 17
                              ) ,
                              ),
                            )
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              translation(context).startingDayOfMonth
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
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Theme.of(context).dividerColor,
                                border: Border.all(color: Theme.of(context).focusColor,width: 1,strokeAlign: BorderSide.strokeAlignOutside),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Stack(
                              children: [
                              Positioned(
                              right: 3,
                              top: 3,
                              child: Container(
                                height: 14,
                                width: 14,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(90),
                                      topRight: Radius.circular(50)),
                                  color: Color(0xffD91A2A),
                                ),
                              ),
                            ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      "16",style:TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontFamily: "Nexa3",
                                        fontSize: 17
                                    ) ,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Text(
                              translation(context).dayButtons
                              ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      Text(
                        translation(context).incomeNetAmountExpenses
                        ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 7,),
                      SizedBox(
                        width: size.width * 0.90,
                        height: size.height * 0.046,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 3,
                              child: SizedBox(
                                height: size.height * 0.036,
                                width: size.width * 0.90,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 0.5,
                                            blurRadius: 2,
                                            offset: Offset(0, 2)
                                        )
                                      ],
                                    gradient: LinearGradient(
                                      colors: [Theme.of(context).hintColor, Theme.of(context).hoverColor],
                                      stops: [0.5, 0.5],
                                    ),
                                    borderRadius:
                                    const BorderRadius.vertical(bottom: Radius.circular(10)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "  +337,75",
                                        style: TextStyle(
                                          color:  Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Nexa3',
                                          fontWeight: FontWeight.w900,
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.15,
                                      ),
                                      const Text(
                                        "-840.75  ",
                                        style: TextStyle(
                                          color:  Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Nexa3',
                                          fontWeight: FontWeight.w900,
                                          height: 1.4,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: size.height * 0.046,
                                width: size.width / 3.5,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Theme.of(context).disabledColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 0.5,
                                            blurRadius: 2,
                                            offset: Offset(0, 2)
                                        )
                                      ]
                                  ),
                                  child: Center(
                                    child: Text(
                                      "503.0",
                                      style: TextStyle(
                                        color: Color(0xff0D1C26),
                                        fontSize: 15,
                                        fontFamily: 'Nexa3',
                                        fontWeight: FontWeight.w900,
                                        height: 1.4,
                                      ),
                                    ),
                                  ), //Toplam değişim.
                                ),
                              ),
                            ),
                          ],
                        ),
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
