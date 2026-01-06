import 'package:butcetakip/core/constants/app_colors.dart';
import 'package:butcetakip/core/constants/icon_mod.dart';
import 'package:flutter/material.dart';

class IconButtonMod extends StatelessWidget {
  final IconMod appIcon;
  final Color? color;
  final String level;
  final double? customSize;
  final VoidCallback? onTap;

  const IconButtonMod(
      this.appIcon, {
        super.key,
        this.color,
        this.level = 'm',
        this.customSize,
        this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color ?? AppColors().lemon,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10),
            child: appIcon,
          ),
        ),
      ),
    );
  }
}