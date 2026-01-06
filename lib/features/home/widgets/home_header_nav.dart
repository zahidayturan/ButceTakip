import 'package:butcetakip/core/constants/app_icons.dart';
import 'package:butcetakip/core/constants/icon_button.dart';
import 'package:butcetakip/core/constants/icon_mod.dart';
import 'package:flutter/material.dart';

class HomeHeaderNav extends StatelessWidget {
  const HomeHeaderNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 14,
        children: [
          IconButtonMod(IconMod(AppIcons.user)),
          Spacer(),
          IconButtonMod(IconMod(AppIcons.notification),color: Theme.of(context).scaffoldBackgroundColor),
          IconButtonMod(IconMod(AppIcons.settings),color: Theme.of(context).scaffoldBackgroundColor)
        ],
      ),
    );
  }
}
