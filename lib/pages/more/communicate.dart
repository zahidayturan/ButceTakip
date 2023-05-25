import 'package:butcekontrol/classes/app_bar_for_page.dart';
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
                                  backgroundColor:
                                  Color(0xff0D1C26),
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
                        child:  RichText(
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
                const SizedBox(height: 30),
                Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "GELİŞTİRİCİLER",
                          style: TextStyle(
                              fontFamily: "Nexa4",
                              fontSize: 22,
                              color: Color(0xFF0D1C26)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/image/icon_BKA/İKON.png",
                            height: 70,
                            width: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    launchURL('https://github.com/ibrahimeth');
                                  },
                                  child: const Text(
                                    "İbrahim Ethem Akbıyık",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                InkWell(
                                  onTap: () {
                                    launchURL('https://github.com/Hamza-Bayar-2');
                                  },
                                  child: const Text(
                                    "Hamza Bayar",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                InkWell(
                                  onTap: () {
                                    launchURL('https://github.com/zahidayturan');
                                  },
                                  child: const Text(
                                    "Zahid Ayturan",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
