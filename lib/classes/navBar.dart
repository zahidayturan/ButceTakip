import 'package:butcekontrol/Pages/addData.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class navBar extends ConsumerWidget {
  const navBar({Key ?key}) : super(key : key) ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watch = ref.watch(botomNavBarRiverpod);
    var read = ref.read(botomNavBarRiverpod);
    var readDB = ref.read(databaseRiverpod) ;
    var selectindex = watch.currentindex;
    CustomColors renkler = CustomColors();
    var selectindex = watch.currentindex;
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: read.currentColor,
      width: size.width,
      height: 64,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 52,
              //color: Colors.white,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Container(
                    width: size.width,
                    height: 52,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                size: 30,
                                Icons.equalizer,
                                color: Colors.white,
                              ),
                              constraints: BoxConstraints(
                                minHeight: 45,
                                minWidth: 50
                              ),
                              onPressed: () {
                                read.setCurrentindex(1);
                              },
                            ),
                            read.currentindex == 1
                                ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height : 7,
                                    width : 25 ,
                                    color: renkler.sariRenk,
                                  ),
                                )
                                :SizedBox(width: 1,)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                size: 30,
                                Icons.calendar_month_sharp,
                                color: Colors.white,
                              ),
                              constraints: BoxConstraints(
                                  minHeight: 45,
                                  minWidth: 50
                              ),
                              onPressed: () {
                                read.setCurrentindex(2);
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => testPages(),));
                              }
                            ),
                            read.currentindex == 2
                                ? ClipRRect(
                                  borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height : 7,
                                    width : 25 ,
                                    color: renkler.sariRenk,
                              ),
                            )
                                :SizedBox(width: 1,)
                          ],
                        ),
                        SizedBox(
                          width: size.width / 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                size: 30,
                                Icons.calculate_sharp,
                                color: Colors.white,

                              ),
                              constraints: const BoxConstraints(
                                  minHeight: 45,
                                  minWidth: 50
                              ),
                              onPressed:() {
                                read.setCurrentindex(3);
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Calculator(),));
                              }
                            ),
                            read.currentindex == 3
                                ? ClipRRect(
                                    borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height : 7,
                                      width : 25 ,
                                      color: renkler.sariRenk,
                                    ),
                                  )
                                :SizedBox(width: 1,)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                size: 30,
                                Icons.keyboard_control_sharp,
                                color: Colors.white,
                              ),
                              constraints: const BoxConstraints(
                                  minHeight: 45,
                                  minWidth: 50
                              ),
                              onPressed: () {
                                read.setCurrentindex(4);
                              }
                            ),
                            read.currentindex == 4
                          || read.currentindex == 5
                          || read.currentindex == 6
                          || read.currentindex == 7
                          || read.currentindex == 8
                          || read.currentindex == 9
                          || read.currentindex == 10
                          ||read.currentindex == 11
                          || read.currentindex == 12
                          || read.currentindex == 13
                          || read.currentindex == 14
                                ? ClipRRect( ///navbar sarı pointer
                                  borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height : 7,
                                    width : 25 ,
                                    color: renkler.sariRenk,
                                    ),
                                  )
                                :SizedBox(width: 1,)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.zero,
              width: 64,
              height: 64,
              child: Center(
                heightFactor: 1,
                child: FloatingActionButton.large(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddData(),));
                    read.setcur();  /// arastırılacak
                    },
                  backgroundColor: Color(0xffF2CB05),
                  child: Icon(Icons.add_rounded, color: Colors.white, size: 64),
                  elevation: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff0D1C26)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.5 - size.height, 0);
    //Path path. = Path()..moveTo(size.width * 0.40, size.width*0.5-size.height );
    path.quadraticBezierTo(
        size.width * 0.50, 0, size.width * 0.50, size.height);
    path.moveTo(size.width * 0.50, size.height);
    //path.lineTo(size.width * 0.50, size.height);
    path.quadraticBezierTo(
        size.width * 0.5, 0, size.width * 0.50 + size.height, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
