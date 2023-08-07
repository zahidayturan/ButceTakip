import 'package:butcekontrol/UI/customize_installment_operation_list.dart';
import 'package:butcekontrol/UI/customize_operation_list.dart';
import 'package:butcekontrol/UI/registery_list.dart';
import 'package:butcekontrol/pages/more/Help/help_page.dart';
import 'package:butcekontrol/pages/more/settings.dart';
import 'package:butcekontrol/pages/search_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';


class AppBarCustom extends ConsumerWidget  implements  PreferredSizeWidget {
  const AppBarCustom({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSetting = ref.read(settingsRiverpod);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        backgroundColor: const Color(0xFF0D1C26),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Image.asset(
            "assets/image/icon_BKA/yatayYazi.png",
            width: 130,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false, //sayfa saydam olması için
                  transitionDuration: const Duration(milliseconds: 1),
                  pageBuilder: (context, animation, nextanim) => const searchPage(),
                  reverseTransitionDuration: const Duration(milliseconds: 1),
                  transitionsBuilder: (context, animation, nexttanim, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Color(0xFFFFFFFF),
              size: 30,
            ),
            constraints: const BoxConstraints(maxWidth: 40),
            iconSize: 20.0,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const CustomizeList();
                },
              );
            },
            icon: const Icon(
              //Icons.event_repeat_rounded,
              Icons.history_rounded,
              color: Color(0xFFFFFFFF),
              size: 30,
            ),
            constraints: const BoxConstraints(minWidth: 36),
            iconSize: 22.0,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const RegisteryList();
                },
              );
            },
            icon: const Icon(
              Icons.bookmark_outline_rounded,
              color: Color(0xFFFFFFFF),
              size: 30,
            ),
            constraints: const BoxConstraints(minWidth: 36),
            iconSize: 22.0,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 1),
                  pageBuilder: (context, animation, nextanim) =>  const HelpCenter(),
                  reverseTransitionDuration: const Duration(milliseconds: 1),
                  transitionsBuilder: (context, animation, nexttanim, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.help_outline_rounded,
              color: Color(0xFFFFFFFF),
              size: 30,
            ),
            constraints: const BoxConstraints(minWidth: 36),
            iconSize: 22.0,

          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onLongPress: () {
                readSetting.setDarkModeNotBool();
              },
              onTap:() {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 1),
                    pageBuilder: (context, animation, nextanim) => const Settings(),
                    reverseTransitionDuration: const Duration(milliseconds: 1),
                    transitionsBuilder: (context, animation, nexttanim, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                ).then((value) => ref.read(botomNavBarRiverpod).setCurrentindex(4));
              },
              child: const Icon(
                Icons.settings_rounded,
                color: Color(0xFFF2CB05),
                size: 30,
              ),
             // constraints: const BoxConstraints(minWidth: 36),
              //iconSize: 22.0,
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }

}
/*
Row(   /// her bir kaydın oldugu satır
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children:  [
SizedBox(
height:  40,
width : 40 ,
child: DecoratedBox(
decoration: const BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.all(Radius.circular(40)),
),
child: Center(
child: Icon(
Icons.remove_red_eye,
color: renkler.sariRenk,
),
),
),
),
Text("İşlem kategorisi"),
const Text(
"189 TL",
style: TextStyle(
color:  Colors.green,
),
),
],
),

 */