import 'package:butcekontrol/UI/customize_operation_list.dart';
import 'package:butcekontrol/UI/introduction_page.dart';
import 'package:butcekontrol/UI/registery_list.dart';
import 'package:butcekontrol/UI/warning_backup.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/pages/more/Help/help_page.dart';
import 'package:butcekontrol/pages/more/settings.dart';
import 'package:butcekontrol/pages/search_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppBarCustom extends ConsumerWidget  implements  PreferredSizeWidget {
  const AppBarCustom({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSetting = ref.watch(settingsRiverpod);
    var readHome = ref.read(homeRiverpod);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        backgroundColor: const Color(0xFF0D1C26),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: readSetting.backUpAlert
          ?InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false, //sayfa saydam olması için
                  transitionDuration: const Duration(milliseconds: 1),
                  pageBuilder: (context, animation, nextanim) => const warningBackUp(),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context).backupFailedEnter,
                      style: const TextStyle(
                        color: Colors.yellow,
                          fontSize: 16
                      ),
                    ),
                    const Icon(
                      Icons.warning,
                      size: 30,
                    ),
                    const SizedBox(width: 7),
                  ],
                ),
                Text(
                  translation(context).clickToCheck,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11
                  ),
                ),
              ],
            ),
          )
          :Image.asset(
            "assets/image/icon_BKA/yatayYazi.png",
            width: 120,
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
                  pageBuilder: (context, animation, nextanim) => const SearchPage(),
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
            onPressed: () async {
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
              /*
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("showBTA", false);
              final bool? showBTA = prefs.getBool("showBTA");
              print("aaaa");
              print(showBTA);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const IntroductionPage())
              );*/
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
                readHome.setStatus();
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
              highlightColor: const Color(0xFF0D1C26),
              child: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).disabledColor,
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
color: Theme.of(context).disabledColor,
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