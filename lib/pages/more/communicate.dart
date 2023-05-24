import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../classes/nav_bar.dart';

class Communicate extends StatelessWidget {
  const Communicate({Key? key}) : super(key: key);

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
                    width: size.width/2,
                  ),
                ),
              const SizedBox(height: 20),
               const Padding(
                 padding: EdgeInsets.only(left: 20),
                 child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(Icons.mail),
                    ),
                    SizedBox(width: 5),
                    Text("Email : fezaitech@gmail.com",style: TextStyle(fontSize: 16)),
                  ],
              ),
               ),
              const SizedBox(height: 10),
               const Padding(
                 padding: EdgeInsets.only(left: 20),
                 child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(Icons.account_circle_outlined),
                    ),
                    SizedBox(width: 5),
                    Text("Github : github.com/ibrahimeth/\nButceTakipApp",style: TextStyle(fontSize: 16)),
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
                          "YAPIMCILAR",
                          style: TextStyle(
                            fontFamily: "Nexa4",
                            fontSize: 22,
                            color: Color(0xFF0D1C26)
                          ),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "İbrahim Ethem Akbıyık",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Hamza Bayar",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Zahid Ayturan",
                                style: TextStyle(
                                  fontSize: 18,
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
            const BannerAds(adSize: AdSize.largeBanner,),
          ],
        ),
    ),
    );
  }
}
