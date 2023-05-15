import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:flutter/material.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18, vertical: 8 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/image/icon_BKA/LOGOBKA-2.png",
                  width: size.width/1.7,
                ),
              ),
            const SizedBox(height: 40),
            Row(
              children: const [
                Icon(Icons.mail),
                SizedBox(width: 5),
                Text("Email   : fezaitech@gmail.com"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: const [
                Icon(Icons.account_circle_outlined),
                SizedBox(width: 5),
                Text("Github : github.com/ibrahimeth/\nButceKontrolApp"),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                const Text(
                    "Yapımcılar",
                    style: TextStyle(
                      fontFamily: "Nexa2",
                      fontSize: 28
                    ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      "assets/image/icon_BKA/İKON.png",
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "İbrahim Ethem AKBIYIK",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Hamza BAYAR",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Zahid AYTURAN",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ) ,
        ),
    ),
    );
  }
}
