import 'package:butcetakip/core/constants/app_colors.dart';
import 'package:butcetakip/core/constants/icon_mod.dart';
import 'package:flutter/material.dart';

class IconButtonMod extends StatelessWidget {
  final IconMod appIcon;
  final Color? color;
  final String level;
  final double? customSize;

  const IconButtonMod(
      this.appIcon, {
        super.key,
        this.color,
        this.level = 'm',
        this.customSize,
      });
  

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

      },
      child: InkWell(
        child: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: color ?? AppColors().lemon
            ),
            child: appIcon,
        ),
      ),
    );
  }
}