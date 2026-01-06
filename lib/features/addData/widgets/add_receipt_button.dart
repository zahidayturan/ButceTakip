import 'package:butcetakip/core/constants/app_colors.dart';
import 'package:butcetakip/core/constants/text_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/icon_mod.dart';

class AddReceiptButton extends ConsumerWidget {
  const AddReceiptButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
        child: InkWell(
          onTap: () {},
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 54),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 8,
                    color: AppColors().black,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextMod("Fiş İle Gider Ekleyin",fontFamily: "FontSemiBold"),
                          TextMod("Fişin fotoğrafını çekerek okutun", level: "s", fontFamily: "FontLight")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 54,
                    color: AppColors().black,
                    child: Center(child: IconMod(AppIcons.openCamera)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}