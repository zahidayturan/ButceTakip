import 'package:butcekontrol/classes/app_bar_for_page.dart';
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
        backgroundColor: const Color(0xffF2F2F2),
        bottomNavigationBar: const NavBar(),
        appBar: const AppBarForPage(title: "İLETİŞİM"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/image/icon_BKA/LOGOBKA-2.png",
                    width: size.width / 2,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Icon(Icons.mail),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: 'Email : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nexa3',
                              color: Color(0xff0D1C26),
                            ),
                          ),
                          TextSpan(
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
                              const SnackBar(
                                  backgroundColor: Color(0xff0D1C26),
                                  duration: Duration(seconds: 1),
                                  content: Text('Email kopyalandı')));
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Icon(Icons.account_circle_outlined),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          launchURL('https://github.com/ibrahimeth');
                        },
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: 'Github : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nexa3',
                              color: Color(0xff0D1C26),
                            ),
                          ),
                          TextSpan(
                            text: 'github.com/ibrahimeth/\nButceTakip',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ])),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Column(
                  children: [
                    FittedBox(
                      // Title
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: renkler.koyuuRenk,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 9),
                            child: Text(
                              "GELİŞTİRİCİLER",
                              style: TextStyle(
                                  fontFamily: "Nexa4",
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
                                        BorderRadius.all(Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
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
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              'https://github.com/ibrahimeth');
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 90,
                                            color: Colors.grey.shade300,
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
                                                  ),
                                                ),
                                                Text("Github"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              "https://www.linkedin.com/in/ibrahim-ethem-akb%C4%B1y%C4%B1k-53a099224/");
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 95,
                                            color: Colors.grey.shade300,
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
                                                Text("Linkedin"),
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
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
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              'https://github.com/Hamza-Bayar-2');
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 95,
                                            color: Colors.grey.shade300,
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
                                                  ),
                                                ),
                                                Text("Github"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              "https://www.linkedin.com/in/hamza-bayar-251b7b234/");
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 95,
                                            color: Colors.grey.shade300,
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
                                                Text("Linkedin"),
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
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
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              'https://github.com/zahidayturan');
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            width: 95,
                                            color: Colors.grey.shade300,
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
                                                  ),
                                                ),
                                                Text("Github"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 110)
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
            const BannerAds(
              adSize: AdSize.largeBanner,
            ),
          ],
        ),
      ),
    );
  }
}
