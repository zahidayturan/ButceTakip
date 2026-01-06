import 'package:butcetakip/core/enums/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod_management.dart';
import '../constants/app_icons.dart';
import '../constants/icon_mod.dart';

const _kAnimationDuration = Duration(milliseconds: 300);

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final PageType currentPage = ref.watch(bottomNavBarRiverpod).currentPage;
    final readNavBar = ref.read(bottomNavBarRiverpod);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width,
        height: 70,
        child: Container(
          color: theme.primaryColorLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NavBarItem(
                appIcon: AppIcons.home,
                isSelected: currentPage == PageType.home,
                label: "Ana Sayfa",
                onPressed: () {
                  readNavBar.goToHome();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                appIcon: AppIcons.statistics,
                isSelected: currentPage == PageType.statistics,
                label: "İstatistikler",
                onPressed: () {
                  readNavBar.goToStatistics();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                appIcon: AppIcons.assets,
                isSelected: currentPage == PageType.assets,
                label: "Varlıklarım",
                onPressed: () {
                  readNavBar.goToAssets();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              /*_NavBarItem(
                appIcon: AppIcons.user,
                isSelected: currentPage == PageType.account,
                label: "Hesabım",
                onPressed: () {
                  readNavBar.goToAccount();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String appIcon;
  final bool isSelected;
  final VoidCallback onPressed;
  final String label;

  const _NavBarItem({
    required this.appIcon,
    required this.isSelected,
    required this.onPressed,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: AnimatedOpacity(
          duration: _kAnimationDuration,
          opacity: isSelected ? 1.0 : 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              IconMod(appIcon),
              Text(label,style: TextStyle(fontSize: 10,color: Theme.of(context).primaryColor))
            ],
          ),
        ),
      ),
    );
  }
}