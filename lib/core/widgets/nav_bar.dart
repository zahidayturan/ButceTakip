import 'package:butcetakip/core/enums/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod_management.dart';

const _kAnimationDuration = Duration(milliseconds: 300);

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final PageType currentPage = ref.watch(bottomNavBarRiverpod).currentPage;
    final readNavBar = ref.read(bottomNavBarRiverpod);
    final readCalendar = ref.read(calendarRiverpod);
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
                icon: Icons.home,
                isSelected: currentPage == PageType.home,
                label: "Ana Sayfa",
                onPressed: () {
                  readNavBar.goToHome();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                icon: Icons.equalizer,
                isSelected: currentPage == PageType.statistics,
                label: "İstatistikler",
                onPressed: () {
                  readNavBar.goToStatistics();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                icon: Icons.wallet,
                isSelected: currentPage == PageType.calendar,
                label: "Varlıklarım",
                onPressed: () {
                  readNavBar.goToCalendar();
                  readCalendar.resetPageController();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                icon: Icons.account_circle_outlined,
                isSelected: currentPage == PageType.more,
                label: "Profilim",
                onPressed: () {
                  readNavBar.goToMore();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final String label;

  const _NavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onPressed,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Expanded(
        child: AnimatedOpacity(
          duration: _kAnimationDuration,
          opacity: isSelected ? 1.0 : 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              Icon(
                icon,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              Text(label,style: TextStyle(fontSize: 10))
            ],
          ),
        ),
      ),
    );
  }
}