import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/DateTimeManager.dart';
import 'package:butcekontrol/utils/dbHelper.dart';



class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _AddAppBar(),
      body: ButtonMenu(),
    );
  }
}

class _AddAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AddAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      //color: Color(0xff0D1C26),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                height: 60,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 60),
                      painter: BNBCustomPainter(),
                    ),
                    CustomPaint(
                      size: Size(size.width, 60),
                      painter: BNBCustomPainter2(),
                    ),
                    Container(
                      width: (size.width / 13) * 11,
                      height: 60,
                      padding: const EdgeInsets.only(left: 16, top: 6),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'GELİR / GİDER EKLE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'NexaKalın',
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 60,
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: const EdgeInsets.only(right: 1.0),
                        iconSize: 60,
                        //alignment: Alignment.centerLeft,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xff0D1C26)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.lineTo(0, 0);
    path.lineTo((size.width / 13) * 12, 0);
    //Path path. = Path()..moveTo(size.width * 0.40, size.width*0.5-size.height );
    path.quadraticBezierTo(
        (size.width / 13) * 12, 60, (size.width / 13) * 10, 60);
    path.lineTo(0, 60);
    path.lineTo(0, 0);
    //path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BNBCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xffF2CB05)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(size.width, 0);
    path.lineTo(size.width, 30);
    path.conicTo(size.width, 60, (size.width / 13) * 12, 60,
        0.8); //GEREKİRSE BUNU KALDIR
    //path.lineTo((size.width/13)*12, 60); //SAĞ ALT KÖSE KIVRIM
    //Path path. = Path()..moveTo(size.width * 0.40, size.width*0.5-size.height );
    //path.quadraticBezierTo(
    //(size.width/13)*11, 60, (size.width/13)*11, 30);
    path.conicTo((size.width / 13) * 11, 60, (size.width / 13) * 11, 30, 0.8);
    /*path.quadraticBezierTo(
        (size.width/13)*11, 0, (size.width/13)*12, 0);*/
    path.conicTo((size.width / 13) * 11, 0, (size.width / 13) * 12, 0, 0.8);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ButtonMenu extends StatefulWidget {
  const ButtonMenu({Key? key}) : super(key: key);
  @override
  _ButtonMenu createState() => _ButtonMenu();
}

class _ButtonMenu extends State<ButtonMenu> {
  final TextEditingController _note = TextEditingController(text: "NOT");
  final TextEditingController _amount = TextEditingController(text: "154.50");
  final TextEditingController _operationType =
  TextEditingController(text: "Gider");
  final TextEditingController _category = TextEditingController(text: "Harclik");
  final TextEditingController _operationTool =
  TextEditingController(text: "Nakit");
  final TextEditingController  _registration = TextEditingController(text: "0");
  final TextEditingController _operationDate = TextEditingController(
      text:
      '${DateTimeManager.getCurrentDay()}.${DateTimeManager.getCurrentMonth()}.${DateTimeManager.getCurrentYear()}');
  //final TextEditingController _operationDay = TextEditingController(text: "25");
  //final TextEditingController _operationMonth =TextEditingController(text: "4");
  //final TextEditingController _operationYear =TextEditingController(text: "2023");
  //final TextEditingController _operationTime = TextEditingController();
  //int _registration = 0;
  int clickedNoteID = -1;
  String operation = "";
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _operationDate.text = DateFormat('dd.MM.yyyy').format(_selectedDate!);
      });
    }
  }

  var heightt1 = 45.0;
  var widthh1 = 85.0;
  var top1 = 1.0;
  var bottom1;
  var right1;
  var left1 = 0.0;
  var heightt2 = 45.0;
  var widthh2 = 85.0;
  var top2 = 1.0;
  var bottom2;
  var right2;
  var left2 = 0.0;

  int selecteed = 0;
  int regss = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //resizeToAvoidBottomInset: false,
    return SizedBox(
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 11, left: 8),
                    child: SizedBox(
                      width: size.width * 0.33,
                      height: 25,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xff0D1C26),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.fastOutSlowIn,
                    height: heightt1,
                    width: widthh1,
                    top: top1,
                    bottom: bottom1,
                    right: right1,
                    left: left1,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: heightt1,
                            width: widthh1,
                            color: const Color(0xffF2CB05),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: SizedBox(
                      width: size.width * 0.34,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selecteed = 0;
                                      left1 = 0.0;
                                      top1 = 1.0;
                                      widthh1 = size.width / 4.8;
                                      _operationType.text = "Gider";
                                    });
                                  },
                                  child: const Text("GIDER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17))),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selecteed = 1;
                                      top1 = 0.8;
                                      left1 = size.width / 5.8;
                                      widthh1 = size.width / 5;
                                      _operationType.text = "Gelir";
                                    });
                                  },
                                  child: const Text("GELIR",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Stack(
                  fit: StackFit.passthrough,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 3, right: 1),
                      child: SizedBox(
                        width: 180,
                        height: 25,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color(0xff0D1C26),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 4),
                            child: Text("TARIH",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: 110,
                        height: 30,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Color(0xffF2CB05),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: TextFormField(
                                onTap: () => _selectDate(context),
                                autofocus: false,
                                keyboardType: TextInputType.datetime,
                                controller: _operationDate,
                                textAlign: TextAlign.center,
                                readOnly: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Positioned(
                  top: 12,
                  child: Container(
                    width: size.width * 0.9,
                    height: 4,
                    color: Colors.black,
                  ),
                ),
                Center(
                  child: Container(
                    width: 130,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                        child: Text("KATEGORI",
                            style: TextStyle(
                                fontSize: 22, color: Colors.white))),
                  ),
                ),
              ],
            ),
            categorySelector(selecteed),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 11, left: 8),
                    child: SizedBox(
                      width: size.width * 0.50,
                      height: 25,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color(0xff0D1C26),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.fastOutSlowIn,
                    height: heightt2,
                    width: widthh2,
                    top: top2,
                    bottom: bottom2,
                    right: right2,
                    left: left2,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: heightt1,
                            width: widthh1,
                            color: const Color(0xffF2CB05),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: SizedBox(
                      width: size.width * 0.50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      left2 = 0.0;
                                      top2 = 1.0;
                                      widthh2 = size.width / 4.8;
                                      _operationTool.text = "Nakit";
                                    });
                                  },
                                  child: const Text("NAKIT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17))),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      top2 = 0.8;
                                      left2 = size.width / 5.8;
                                      widthh2 = size.width / 5;
                                      _operationTool.text = "Kart";
                                    });
                                  },
                                  child: const Text("KART",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17))),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      top2 = 0.8;
                                      left2 = size.width / 3;
                                      widthh2 = size.width / 4.8;
                                      _operationTool.text = "Diger";
                                    });
                                  },
                                  child: const Text("DIGER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Stack(
                  fit: StackFit.passthrough,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, right: 1),
                      child: SizedBox(
                        width: 120,
                        height: 25,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color(0xff0D1C26),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 6),
                            child: Text("KAYDET",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Color(0xffF2CB05),
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          child: registration(regss),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: 115,
                ),
                SizedBox(
                  width: size.width * 0.85,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: _note,
                        maxLength: 256,
                        decoration: const InputDecoration(
                          //labelText: "Not",
                            hintText: "İşlem ile ilgili notlar",
                            border: InputBorder.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SizedBox(
                    height: 100,
                    width: size.width * 0.9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border:
                        Border.all(color: const Color(0xff0D1C26), width: 1.5),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  child: SizedBox(
                    width: 120,
                    height: 30,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xff0D1C26),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 7),
                        child: Text(
                          "NOT EKLE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 300,
                  child: SizedBox(
                    width: 44,
                    height: 24,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xffF2CB05),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sil",
                            style: TextStyle(
                                color: Color(0xff0D1C26), fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Container(
                    width: size.width * 0.9,
                    height: 4,
                    color: const Color(0xff0D1C26),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: SizedBox(
                      width: 164,
                      height: 25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xff0D1C26),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, top: 5),
                          child: Text("TUTAR",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 180,
                  child: SizedBox(
                    width: 90,
                    height: 30,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xffF2CB05),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,3}')),
                            ],
                            autofocus: false,
                            controller: _amount,
                            decoration: const InputDecoration(
                                hintText: "0.00", border: InputBorder.none)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: SizedBox(
                        width: 90,
                        height: 30,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                            color: Color(0xffF2CB05),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextButton(
                              onPressed: () {
                                print(_operationType.text+
                                    _category.text+
                                    _operationTool.text+
                                    _registration.toString()+
                                    _amount.toString()+
                                    _note.text+
                                    DateTimeManager.getCurrentTime()+
                                    _operationDate.text);
                              },
                              child: const Text("SIFIRLA",
                                  style: TextStyle(
                                      color: Color(0xff0D1C26),
                                      fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      height: 30,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: TextButton(
                            onPressed: () {
                              _addItem(
                                int.parse(_registration.text),
                                double.parse(_amount.text),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("KAYDET",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  var heightt = 45.0;
  var widthh = 75.0;
  var top = 1.0;
  var bottom;
  var right;
  var left = 1.0;
  var heightt3 = 45.0;
  var widthh3 = 75.0;
  var top3 = 1.0;
  var bottom3;
  var right3;
  var left3 = 1.0;

  Widget registration(int regs) {
    if (regs == 0) {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 1;
              _registration.text = '1';
            });
          },
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
          ));
    } else {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 0;
              _registration.text = '0';
            });
          },
          icon: const Icon(
            Icons.bookmark,
            color: Color(0xff0D1C26),
          ));
    }
  }

  Widget categorySelector(int selected) {
    var size = MediaQuery.of(context).size;
    if (selected == 0) {
      return Stack(
        //fit: StackFit.passthrough,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastOutSlowIn,
              height: heightt,
              width: widthh,
              top: top,
              bottom: bottom,
              right: right,
              left: left,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: heightt,
                      width: widthh,
                      color: const Color(0xffF2CB05),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: SizedBox(
                width: size.width * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          //style: const ButtonStyle(
                          // backgroundColor: MaterialStatePropertyAll(Colors.red),
                          //),
                            onPressed: () {
                              setState(() {
                                left = 0.0;
                                top = 1.0;
                                widthh = size.width / 5;
                                _category.text = 'Yemek';
                              });
                            },
                            child: const Text("Yemek",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 1.0;
                                left = size.width / 4.2;
                                widthh = size.width / 5.1;
                                _category.text = 'Giyim';
                              });
                            },
                            child: const Text("Giyim",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 1.0;
                                left = size.width / 2.15;
                                widthh = size.width / 4.5;
                                _category.text = 'Eglence';
                              });
                            },
                            child: const Text("Eglence",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 1.0;
                                left = size.width / 1.37;
                                widthh = size.width / 5.2;
                                _category.text = 'Egitim';
                              });
                            },
                            child: const Text("Egitim",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                top = 50.0;
                                left = 0.0;
                                widthh = size.width / 3.5;
                                _category.text = 'Aidat/Kira';
                              });
                            },
                            child: const Text("Aidat/Kira",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17)),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 50.0;
                                left = size.width / 3.5;
                                widthh = size.width / 4.2;
                                _category.text = 'Alisveris';
                              });
                            },
                            child: const Text("Alısveris",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 50.0;
                                left = size.width / 1.85;
                                widthh = size.width / 6;
                                _category.text = 'Ozel';
                              });
                            },
                            child: const Text("Ozel",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 50.0;
                                left = size.width / 1.38;
                                widthh = size.width / 5.1;
                                _category.text = 'Ulasim';
                              });
                            },
                            child: const Text("Ulasim",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  top = 98.0;
                                  left = 0.0;
                                  widthh = size.width / 5.2;
                                  _category.text = 'Saglik';
                                });
                              },
                              child: const Text("Saglik",
                                  style: TextStyle(
                                      color: Color(0xff0D1C26), fontSize: 17))),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 98.0;
                                left = size.width / 4.9;
                                widthh = size.width / 3;
                                _category.text = 'Gunluk Yasam';
                              });
                            },
                            child: const Text("Gunluk Yasam",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 98.0;
                                left = size.width / 1.8;
                                widthh = size.width / 5.5;
                                _category.text = 'Hobi';
                              });
                            },
                            child: const Text("Hobi",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top = 98.0;
                                left = size.width / 1.35;
                                widthh = size.width / 5.5;
                                _category.text = 'Diger';
                              });
                            },
                            child: const Text("Diger",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]);
    } else {
      return Stack(
        //fit: StackFit.passthrough,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastOutSlowIn,
              height: heightt3,
              width: widthh3,
              top: top3,
              bottom: bottom3,
              right: right3,
              left: left3,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: heightt3,
                      width: widthh3,
                      color: const Color(0xffF2CB05),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: SizedBox(
                width: size.width * 0.9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          //style: const ButtonStyle(
                          // backgroundColor: MaterialStatePropertyAll(Colors.red),
                          //),
                            onPressed: () {
                              setState(() {
                                left3 = 0.0;
                                top3 = 1.0;
                                widthh3 = size.width / 4.9;
                                _category.text = 'Harclik';
                              });
                            },
                            child: const Text("Harçlık",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 1.0;
                                left3 = size.width / 4.8;
                                widthh3 = size.width / 5.8;
                                _category.text = 'Burs';
                              });
                            },
                            child: const Text("Burs",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 1.0;
                                left3 = size.width / 2.7;
                                widthh3 = size.width / 4.8;
                                _category.text = 'Maas';
                              });
                            },
                            child: const Text("Maas",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 1.0;
                                left3 = size.width / 1.8;
                                widthh3 = size.width / 5.2;
                                _category.text = 'Kredi';
                              });
                            },
                            child: const Text("Kredi",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 1.0;
                                left3 = size.width / 1.32;
                                widthh3 = size.width / 6.2;
                                _category.text = 'Ozel';
                              });
                            },
                            child: const Text("Özel",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 50.0;
                                left3 = 0.0;
                                widthh3 = size.width / 3;
                                _category.text = 'Kira/Odenek';
                              });
                            },
                            child: const Text("Kira/Ödenek",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17)),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 50.0;
                                left3 = size.width / 2.8;
                                widthh3 = size.width / 3.4;
                                _category.text = 'Fazla Mesai';
                              });
                            },
                            child: const Text("Fazla Mesai",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 50.0;
                                left3 = size.width / 1.48;
                                widthh3 = size.width / 4;
                                _category.text = 'Is Getirisi';
                              });
                            },
                            child: const Text("Is Getirisi",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  top3 = 98.0;
                                  left3 = 0.0;
                                  widthh3 = size.width / 3;
                                  _category.text = 'Doviz Getirisi';
                                });
                              },
                              child: const Text("Doviz Getirisi",
                                  style: TextStyle(
                                      color: Color(0xff0D1C26), fontSize: 17))),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 98.0;
                                left3 = size.width / 2.8;
                                widthh3 = size.width / 2.8;
                                _category.text = 'Yatirim Getirisi';
                              });
                            },
                            child: const Text("Yatirim Getirisi",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                top3 = 98.0;
                                left3 = size.width / 1.35;
                                widthh3 = size.width / 5.5;
                                _category.text = 'Diger';
                              });
                            },
                            child: const Text("Diger",
                                style: TextStyle(
                                    color: Color(0xff0D1C26), fontSize: 17))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]);
    }
  }

  Future<void> _addItem(int? registration,double? amount) async {
    String time = _operationDate.text;
    List<String> parts = time.split(".");
    int parseDay = int.parse(parts[0]);
    int parseMonth = int.parse(parts[1]);
    int parseYear = int.parse(parts[2]);
    await SQLHelper.createItem(spendinfo(
        _operationType.text,
        _category.text,
        _operationTool.text,
        registration,
        amount,
        _note.text,
        parseDay.toString(),
        parseMonth.toString(),
        parseYear.toString(),
        DateTimeManager.getCurrentTime(),
        _operationDate.text));
  }
}
/*
  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        cli, _harcamatipiController.text, _odemeyontemiController.text, _kategoriController.text, _tutarController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully updated'),
    ));
    _refreshSpendinfoList();
  }
*/

