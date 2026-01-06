import 'package:butcetakip/core/constants/app_colors.dart';
import 'package:butcetakip/core/constants/icon_button.dart';
import 'package:butcetakip/core/constants/text_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/icon_mod.dart';

class AddDataHeader extends ConsumerWidget {
  final String label;
  const AddDataHeader({super.key,required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonMod(
            IconMod(AppIcons.back),
            color: AppColors().lemon,
            onTap: () {
                Navigator.of(context).pop();
              },
          ),
          TextMod(label,level: "l")
        ],
      ),
    );
  }

}