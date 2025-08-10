import 'package:butcetakip/features/addData/add_data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

const _kAnimationDuration = Duration(milliseconds: 300);

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int currentIndex = ref.watch(botomNavBarRiverpod).currentindex;
    final readNavBar = ref.read(botomNavBarRiverpod);
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
            children: [
              _NavBarItem(
                icon: Icons.equalizer_rounded,
                isSelected: currentIndex == 1,
                onPressed: () {
                  readNavBar.setCurrentindex(1);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                icon: Icons.calendar_month_rounded,
                isSelected: currentIndex == 2,
                onPressed: () {
                  readNavBar.setCurrentindex(2);
                  readCalendar.resetPageController();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                icon: Icons.add,
                isSelected: currentIndex == 5,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddData(addDataMode: 0),
                    ),
                  );
                  readNavBar.setcur();
                },
              ),
              _NavBarItem(
                icon: Icons.calculate_rounded,
                isSelected: currentIndex == 3,
                onPressed: () {
                  readNavBar.setCurrentindex(3);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              _NavBarItem(
                icon: Icons.keyboard_control_rounded,
                isSelected: currentIndex == 4,
                onPressed: () {
                  readNavBar.setCurrentindex(4);
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

  const _NavBarItem({
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        duration: _kAnimationDuration,
        opacity: isSelected ? 1.0 : 0.6,
        child: IconButton(
          icon: Icon(
            icon,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
          splashColor: Theme.of(context).scaffoldBackgroundColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}