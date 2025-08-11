import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/text_pref.dart';
import '../../riverpod_management.dart';
import '../../l10n/language.dart';


class AppBarForPage extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  const AppBarForPage({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(bottomNavBarRiverpod);
    var readSetting = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 5,
            child: IconButton(
              padding: const EdgeInsets.only(right: 0),
              iconSize: 48,
              icon: title == translation(context).helpTitle
                  || title == translation(context).helpTitle2
                  || title == translation(context).settingsTitle
                  || title == translation(context).contactUsTitle
                  || title == translation(context).backupTitle
                  || title == translation(context).loginPasswordTitle
                  || title == translation(context).myAssets
                  || title == "Görünüm Ayarları"
              ?Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 40,
                ),
              )
                  :Icon(
                Icons.home_rounded,
                size: 40,
              ),
              onPressed: () async {
                if(title == translation(context).helpTitle || title == translation(context).settingsTitle || title == translation(context).contactUsTitle || title == translation(context).backupTitle || title == translation(context).helpTitle2 || title == translation(context).myAssets || title == "Görünüm Ayarları"){
                  Navigator.of(context).pop();
                }else if(title == translation(context).loginPasswordTitle) {
                  if(readSetting.isPassword == 1 && readSetting.Password == "null") {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            shadowColor: Theme.of(context).highlightColor,
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: Theme.of(context).disabledColor,
                                  size: 35,
                                ),
                                const SizedBox(width: 20),
                                TextMod(translation(context).warning, Colors.white, 18),
                              ],
                            ),
                            content: TextMod(translation(context).youHaveNotCreatedAnyPasswordWarning, Colors.white, 15),
                            actions: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20) ,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: Theme.of(context).disabledColor,
                                  margin: const EdgeInsets.all(5),
                                  child:  InkWell(
                                      onTap: () => Navigator.pop(context, false),
                                      child: SizedBox(
                                          child: Center(
                                              child: TextMod(translation(context).yes, Colors.red,16)
                                          )
                                      )
                                  ) ,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20) ,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: Theme.of(context).disabledColor,
                                  margin: const EdgeInsets.all(5),
                                  child:  InkWell(
                                      onTap: () {
                                        Navigator.pop(context, true);
                                        readSetting.setPasswordMode(false);
                                        readSetting.setisuseinsert();
                                      },
                                      child: SizedBox(
                                          child: Center(
                                              child: TextMod(translation(context).no,Colors.red, 16)
                                          )
                                      )
                                  ) ,
                                ),
                              ),

                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                    );
                    if (confirm == true) {
                      Navigator.pop(context);
                    }
                  }else{
                    Navigator.pop(context, true);
                  }
                }
                else{
                  readNavBar.goToHome();
                }
              },
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'FontBold',
                fontSize: 22,
                height: 1,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}