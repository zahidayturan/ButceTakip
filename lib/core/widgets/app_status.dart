import 'package:butcetakip/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/language.dart';

class AppStatus extends ConsumerStatefulWidget {
  final String status;
  const AppStatus({super.key,required this.status});

  @override
  ConsumerState<AppStatus> createState() => _AppStatusState();
}

class _AppStatusState extends ConsumerState<AppStatus> {

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: helloPage(context)
      ),
    );
  }

  String? selectedLanguage;
  Widget helloPage(BuildContext context) {
    AppColors appColors = AppColors();

    var darkMode = false;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: darkMode
              ? const ExactAssetImage(
            "assets/image/introductionBackground2.png",
          )
              : const ExactAssetImage(
            "assets/image/introductionBackground.png",
          ),
          opacity: 0.05,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.status == "care" ?  translation(context).care1 : translation(context).update1,
                      style: TextStyle(
                          fontSize: 36,
                          height: 1,
                          fontFamily: "FontBold",
                          ),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.status == "care" ?  translation(context).care2 : translation(context).update2,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1,
                          ),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(
                widget.status == "care" ?  translation(context).care3 : "",
                style: TextStyle(
                    fontSize: 18,
                    height: 1,
                    fontFamily: "FontBold",
                    fontWeight: FontWeight.w900,
                    ),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: widget.status == "update",
                child: InkWell(
                  child:
                      Text(
                        translation(context).update3,
                        style: const  TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontFamily: "FontMedium"
                          ),
                        ),
                  onTap: () {
                    final appId = 'com.fezaitech.butcetakip';
                    final url = Uri.parse(
                        "market://details?id=$appId"
                    );
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  widget.status == "care" ?  "fezaitech@gmail.com" : "",
                  style: TextStyle(
                      fontSize: 18,
                      height: 1,
                      fontFamily: "FontMedium",
                      ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Fezai Tech",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "FontMedium",
                        height: 1),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 4,
                  width: 100,
                  decoration: BoxDecoration(
                      color: appColors.lemon,
                ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
