import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../classes/nav_bar.dart';

class Communicate extends StatelessWidget {
  const Communicate({Key? key}) : super(key: key);

  final String url = 'https://github.com/ibrahimeth';

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL açılamadı: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = new CustomColors();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color(0xffF2F2F2),
        bottomNavigationBar: const NavBar(),
        appBar: AppBarForPage(title: translation(context).contactUsTitle),
        body : CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/image/icon_BKA/LOGOBKA-2.png",
                        width: size.width / 2,
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Icon(Icons.mail,color: Theme.of(context).canvasColor),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: translation(context).email,
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 16,
                                      fontFamily: 'Nexa3',
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'fezaitech@gmail.com',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ])),
                            onTap: () {
                              Clipboard.setData(
                                  const ClipboardData(text: 'fezaitech@gmail.com'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: const Color(0xff0D1C26),
                                      duration: const Duration(seconds: 1),
                                      content: Text('Email Panoya Kopyalandı',style: TextStyle(color : Theme.of(context).canvasColor,fontFamily: 'Nexa3',fontSize: 15),)));
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: size.width * .22,
                              child:  Divider(
                                color: Theme.of(context).highlightColor,
                                thickness: 2,
                              ),
                            ),
                            FittedBox(
                              // Title
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 9),
                                    child: Text(
                                      translation(context).developers,
                                      style: TextStyle(
                                          fontFamily: "Nexa4",
                                          fontSize: 18,
                                          color: renkler.arkaRenk),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .22,
                              child: Divider(
                                color: Theme.of(context).highlightColor,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(25)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).highlightColor.withOpacity(0.4),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(3, 3), // x,y offset değerleri
                                          )
                                        ]),
                                    child: Stack(children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                            "https://avatars.githubusercontent.com/u/92324388?v=4"),
                                      ),
                                    ]),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        "İbrahim Ethem Akbıyık",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), //nam// e
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              launchURL(
                                                  'https://github.com/ibrahimeth');
                                            },
                                            highlightColor: Theme.of(context).indicatorColor,
                                            borderRadius: BorderRadius.circular(15),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              child: Container(
                                                width: 90,
                                                color: Theme.of(context).indicatorColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Image.asset(
                                                        "assets/icons/github.png",
                                                        height: 18,
                                                        color: Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                    const Text("GitHub"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          InkWell(
                                            onTap: () {
                                              launchURL(
                                                  "https://www.linkedin.com/in/ibrahim-ethem-akb%C4%B1y%C4%B1k-53a099224/");
                                            },
                                            highlightColor: Theme.of(context).indicatorColor,
                                            borderRadius: BorderRadius.circular(15),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              child: Container(
                                                width: 95,
                                                color: Theme.of(context).indicatorColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Image.asset(
                                                        "assets/icons/linkedin.png",
                                                        height: 18,
                                                      ),
                                                    ),
                                                    const Text("LinkedIn"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ), //social icon
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(25)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).highlightColor.withOpacity(0.4),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(
                                                3, 3), // x,y offset değerleri
                                          )
                                        ]),
                                    child: Stack(children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                            "https://avatars.githubusercontent.com/u/99787343?v=4"),
                                      ),
                                    ]),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        "Hamza Bayar",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), //nam// e
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              launchURL(
                                                  'https://github.com/Hamza-Bayar-2');
                                            },
                                            highlightColor: Theme.of(context).indicatorColor,
                                            borderRadius: BorderRadius.circular(15),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              child: Container(
                                                width: 95,
                                                color: Theme.of(context).indicatorColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Image.asset(
                                                        "assets/icons/github.png",
                                                        height: 18,
                                                        color: Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                    const Text("GitHub"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          InkWell(
                                            onTap: () {
                                              launchURL(
                                                  "https://www.linkedin.com/in/hamza-bayar-251b7b234/");
                                            },
                                            highlightColor: Theme.of(context).indicatorColor,
                                            borderRadius: BorderRadius.circular(15),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              child: Container(
                                                width: 95,
                                                color: Theme.of(context).indicatorColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Image.asset(
                                                        "assets/icons/linkedin.png",
                                                        height: 18,
                                                      ),
                                                    ),
                                                    const Text("LinkedIn"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ), //social icon
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(25)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).highlightColor.withOpacity(0.4),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(
                                                3, 3), // x,y offset değerleri
                                          )
                                        ]),
                                    child: Stack(children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                            "https://avatars.githubusercontent.com/u/91957947?v=4"),
                                      ),
                                    ]),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        "Zahid Ayturan",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), //nam// e
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              launchURL(
                                                  'https://github.com/zahidayturan');
                                            },
                                            highlightColor: Theme.of(context).indicatorColor,
                                            borderRadius: BorderRadius.circular(15),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              child: Container(
                                                width: 95,
                                                color: Theme.of(context).indicatorColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Image.asset(
                                                        "assets/icons/github.png",
                                                        height: 18,
                                                        color: Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                    const Text("GitHub"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 110)
                                        ],
                                      ), //social icon
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      child: BannerAds(
                        adSize: AdSize.banner,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),

      ),
    );
  }
}
