import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class AppBarForPage extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  const AppBarForPage({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  Widget build(BuildContext context, WidgetRef ref) {
    var read2 = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                    color: Color(0xff0D1C26),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    )),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: 60,
                decoration: const BoxDecoration(
                    color: Color(0xffF2CB05),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      topRight: Radius.circular(100),
                    )),
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 5,
            child: IconButton(
              padding: const EdgeInsets.only(right: 0),
              iconSize: 48,
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                //Navigator.of(context).pop();
                read2.setCurrentindex(0);
              },
            ),
          ),
          Positioned(
            right: 20,
            top: 18,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'NEXA4',
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}