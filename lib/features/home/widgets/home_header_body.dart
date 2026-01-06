import 'package:butcetakip/core/constants/app_colors.dart';
import 'package:butcetakip/core/constants/text_pref.dart';
import 'package:butcetakip/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/icon_mod.dart';
import '../../addData/add_data_page.dart';

class HomeHeaderBody extends ConsumerWidget {
  const HomeHeaderBody({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColorLight,
      padding: const EdgeInsets.only(bottom: 14, left: 14, right: 14),
      child: Column(
        children: [
          TextMod("Ağustos Dönemi", level: "l", weight: FontWeight.bold),
          TextMod("15 Ağustos - 14 Eylül", level: "s"),
          const SizedBox(height: 10),
          TextMod("+24.720 TL", level: "xl", weight: FontWeight.bold, color: AppColors().green),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                context: context,
                color: AppColors().green,
                icon: IconMod(AppIcons.income),
                label: "Gelir Ekle",
                onTap: () => _navigate(context,ref,true),
              ),
              const SizedBox(width: 30),
              _buildActionButton(
                context: context,
                color: Theme.of(context).scaffoldBackgroundColor,
                icon: IconMod(AppIcons.expense, color: AppColors().red),
                label: "Gider Ekle",
                onTap: () => _navigate(context,ref,false),
              )
            ],
          )
        ],
      ),
    );
  }

  void _navigate(BuildContext context,WidgetRef ref, bool isIncome) {
    ref.read(addDataRiverpod).setAddDataType(isIncome);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddDataPage()),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required Color color,
    required IconMod icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 12),
                TextMod(label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}