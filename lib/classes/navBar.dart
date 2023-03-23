import 'package:butcekontrol/App/Aylikinfo.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:flutter/material.dart';
import '../utils/dpHelper.dart';

class navBar extends StatefulWidget {
  //const navBar({Key? key}) : super(key: key);
  @override
  State<navBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<navBar> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      //alignment: Alignment.bottomCenter,
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
                        IconButton(
                          icon: const Icon(
                            size: 30,
                            Icons.equalizer,
                            color: Colors.white,
                          ),
                          onPressed: () {

                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            size: 30,
                            Icons.calendar_month_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: size.width / 5,
                        ),
                        IconButton(
                          icon: const Icon(
                            size: 30,
                            Icons.calculate_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            size: 30,
                            Icons.keyboard_control_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {},
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
